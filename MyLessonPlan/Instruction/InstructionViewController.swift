//
//  InstructionViewController.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 4/19/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit
import GearRefreshControl

class InstructionViewController: UIViewController {
    var dataFlow:Model?
    var instructionScene = InstructionScene()
    let transition = Icon_view_transition()
    var sequenceTyped: Sequecne = .main
    private lazy var mainTableView = addAndGetMainTableView()
    private lazy var gearRefreshControl = GearRefreshControl(frame: self.view.bounds)
    private var destinationBar:ModelBarView?
    private var draggedBar:ModelBarView?
    private var barWidth = CGFloat(0)
    private var currentStep:[(title:String,color:UIColor, steps:[(step:String, content:String)])]?
    private var currentStepIsOpen:[Bool] = []
    private lazy var numOfRows = 0
    private lazy var numOfCols = 0
    private var instructionModel = InstructionModel()
    static let instructionViewControllerInstance = InstructionViewController()
    private var shouldAnimate = false
    static var isVisited = false
    private weak var timer: Timer?
    private var tappedSection = 0
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        // Navigation Bar
        self.setNavigationBar(title: "Instruction\nSequence")
        self.addBackNaviButton(title: "Back")
        
        self.title = "InstructionViewController"
        createObservers()
        updateCellHeights()
        addBottomView()
        addAndGetPDFButton().addTarget(self, action: #selector(pdfButtonClicked), for: .touchUpInside)
        addAndGetContinueButton(title:"Save and Continue to\nClosure →").addTarget(self, action: #selector(continueButtonClicked), for: .touchUpInside)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
        mainTableView.register(SDContentTableViewCell.self, forCellReuseIdentifier: "SDContentTableViewCell")
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
        mainTableView.refreshControl = gearRefreshControl
        gearRefreshControl.gearTintColor = UIColor.byuHRed
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            let orient = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
            switch orient {
            case .portrait:
                print("Portrait")
            case .landscapeLeft,.landscapeRight :
                print("Landscape")
            default:
                print("Anything But Portrait")
            }
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            self.updateCellHeights()
            self.mainTableView.setContentOffset(.zero, animated:true)
            // 防止 present singleton instance 后 viewcontroller navigation bar 变色的问题
            // reset Navigation Bar
            self.setNavigationBar(title: "Instruction\nSequence")
            self.addBackNaviButton(title: "Back")
            self.reloadBarsTableViews()
            self.mainTableView.reloadData()
        })
        super.viewWillTransition(to: size, with: coordinator)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // 防止 present singleton instance 后 viewcontroller navigation bar 变色的问题
        // reset Navigation Bar
        self.setNavigationBar(title: "Instruction\nSequence")
        self.addBackNaviButton(title: "Back")
        // update bars in instructionSequence according to the latest data flow
        if instructionScene.bars.count < dataFlow!.instructionSequence.count{
            for _ in 0..<dataFlow!.instructionSequence.count-instructionScene.bars.count{
                instructionScene.bars.append(ModelBarView())
            }
        }
        let rowNum = instructionScene.cellHeightsSorttedList().firstIndex(of: "4_bars")!
        if let cell = self.mainTableView.cellForRow(at: IndexPath(row: rowNum, section: 0)){
            self.updateBarsFromModel(cell:cell, view:self.view, removeIndex: nil, redo:false)
        }
        currentStep = nil
        currentStepIsOpen = []
        updateCellHeights()
        mainTableView.reloadData()
        reloadBarsTableViews()
        //        mainTableView.scrollToRow(at: IndexPath(row: instructionScene.cellHeightsSorttedList().firstIndex(of: "4_bars")!, section: 0), at: .top, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // showfocuseLinkBlurView
        if dataFlow?.state["instructionState"]! == "◎"{
            // check whether community cell is complete visible
            let cellRect = mainTableView.rectForRow(at: IndexPath(row: 4, section: 0))
            let completelyVisible = mainTableView.bounds.contains(cellRect)
            if completelyVisible{
                // show hint animation
                instructionScene.showfocuseLinkBlurView(view:self.view)
            }else{
                mainTableView.scrollToRow(at: IndexPath(row: 3, section: 0), at: .top, animated: true)
                shouldAnimate = true
            }
        }
    }
    override func viewDidLayoutSubviews() {
        //        self.mainTextView.setContentOffset(.zero, animated: false)
    }
}

//MARK: Delegation
extension InstructionViewController:SDContentTableViewCellDataFlowUpdatingDelegation{
    func callReloadMainTableView(cell: SDContentTableViewCell) {
        #if targetEnvironment(macCatalyst)
        for visibleCell in mainTableView.visibleCells{
            if visibleCell != cell{
                let indexp = mainTableView.indexPath(for: visibleCell)!
                mainTableView.reloadRows(at: [indexp], with: .automatic)
            }
        }
        #endif
    }
    func updateDataFlowFromSDContentTableVC(step: String, content: String, save:Bool) {
        if save{
            saveCurrentJsonDataToDiskAndBroadcastReminderUpdating(dataFlow: dataFlow, animated: true)
        }else{
            // update Learning Objective Model
            if step == "My Learning Objective One"{
                dataFlow!.learningObjectiveOne = content
            }else if step == "My Learning Objective Two"{
                dataFlow!.learningObjectiveTwo = content
            }else{
                // update the current currentStep
                for i in 0..<currentStep!.count{
                    for j in 0..<currentStep![i].steps.count{
                        if currentStep![i].steps[j].step == step{
                            currentStep![i].steps[j].content = content
                        }
                    }
                }
                // update model from currentStep
//                for i in 0..<dataFlow!.instructionSequence.count{
//                    for j in 0..<currentStep!.count{
//                        if dataFlow!.instructionSequence[i].title == currentStep![j].title{
//                            dataFlow!.instructionSequence[i] = currentStep![j]
//                        }
//                    }
                //                }
                for i in  0..<dataFlow!.instructionSequence.count{
                    for j in 0..<dataFlow!.instructionSequence[i].steps.count{
                        label: for m in 0..<currentStep!.count{
                            for n in 0..<currentStep![m].steps.count{
                                if dataFlow!.instructionSequence[i].steps[j].step == currentStep![m].steps[n].step{
                                    dataFlow!.instructionSequence[i].steps[j].content = currentStep![m].steps[n].content
                                    break label
                                }
                            }
                        }
                    }
                }
            }
            // reload reminder cards
            updateCollectionViewAndTitleViewfromModel(from: dataFlow!, to: mainTableView)
            // update bars from model
            if let cell = mainTableView.cellForRow(at:IndexPath(row: instructionScene.cellHeightsSorttedList().firstIndex(of: "4_bars")!, section: 0)){
                updateBarsFromModel(cell: cell, view: self.view, removeIndex: nil, redo: false)
            }
        }
    }
}
extension InstructionViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        gearRefreshControl.scrollViewDidScroll(scrollView)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
        self.gearRefreshControl.endRefreshing()
    }
}

extension InstructionViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataFlow!.reminderTitle.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ReminderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReminderCollectionViewCell", for: indexPath) as! ReminderCollectionViewCell
        cell.titleLabel.text = dataFlow!.reminderTitle[indexPath.item]
        if indexPath.item == 5{
            cell.backgroundColor = UIColor.byuhGold
            cell.textView.backgroundColor = UIColor.byuhGold
        }else{
            cell.backgroundColor = #colorLiteral(red: 0.7349098325, green: 0.2120193839, blue: 0.3139412701, alpha: 1)
            cell.textView.backgroundColor = #colorLiteral(red: 0.7349098325, green: 0.2120193839, blue: 0.3139412701, alpha: 1)
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(editReminderTapped))
        cell.editLabel.addGestureRecognizer(tapGesture)
        cell.editLabel.tag = indexPath.row
        updateCellfromModel(from: dataFlow!, to: cell, indexPath: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: instructionScene.cellHeightsDict["2_reminder"]!*0.9)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        let rotationTransfrom = CATransform3DTranslate(CATransform3DIdentity, 0, -100, 0)
        cell.alpha = 0.5
        cell.layer.transform = rotationTransfrom
        UIView.animate(withDuration: 0.5, animations: {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        })
    }
}

extension InstructionViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if currentStep == nil{
            return 1
        }else{
            return currentStep!.count + 1
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }else{
             return 44
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section >= 1{
            let headerView = UIView()
            let headerLabel = UILabel()
            let headerButton = UIButton(type: .system)
            headerView.addSubview(headerLabel)
            headerView.addSubview(headerButton)
            headerLabel.frame = CGRect(x: sdGap+safeLeft, y: 0, width: self.view.frame.width/2, height: 44)
            headerLabel.text = (currentStep?[section-1].title)! + ":"
            headerLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
            headerLabel.adjustsFontSizeToFitWidth = true
            headerLabel.textColor = .white
            headerButton.frame = CGRect(x: self.view.frame.width-100-safeRight-sdGap, y: 7, width: 100, height: 30)
            headerButton.layer.cornerRadius = 30*0.5
            headerButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            headerButton.layer.borderWidth = 2
            if currentStepIsOpen[section-1]{
                 headerButton.setTitle("collapse ∆", for: .normal)
            }else{
                 headerButton.setTitle("expand ∇", for: .normal)
            }
            headerButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            headerButton.addTarget(self, action: #selector(expendOrCollapse), for: .touchUpInside)
            headerButton.tag = section
            headerView.backgroundColor = UIColor.byuHRed
            headerView.layer.borderWidth = 2.5
            headerView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            return headerView
        }
        return nil
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if shouldAnimate{
            instructionScene.showfocuseLinkBlurView(view:self.view)
            shouldAnimate = false
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //        if indexPath.row == 4{
        //            setAnimatedSwipe(to: cell, in: CGRect(x: self.view.frame.width-sdGap-44-safeRight, y: 0, width: 44, height: 44), offset:1)
        //        }
        //        #if !targetEnvironment(macCatalyst)
        //            if indexPath.row >= 6{
        //                UIView.transition(
        //                    with: cell,
        //                    duration: 0.5,
        //                    options: .transitionFlipFromBottom, animations: {
        //                })
        //            }
        //        #endif
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return instructionScene.cellHeightsDict.count
        }else{
            if currentStep == nil{
                return 0
            }else{
                if section == 1{
                    if !currentStepIsOpen[section-1]{
                        return 0
                    }else{
                        return currentStep![section-1].steps.count + 2
                    }
                }else{
                    if !currentStepIsOpen[section-1]{
                        return 0
                    }else{
                        return currentStep![section-1].steps.count
                    }
                }
            }
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if indexPath.section == 0{
            if indexPath.row < instructionScene.cellHeightsSorttedList().count{
                return instructionScene.cellHeightsDict[instructionScene.cellHeightsSorttedList()[indexPath.row]]!
            }
        }else if indexPath.section == 1{
            if indexPath.row == 0{
                return 100
            }else if indexPath.row == 1{
                return 100
            }else{
                return 150
            }
        }else{
            return 150
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.byuHlightGray
        cell.selectionStyle = .none
        if indexPath.section == 0 && indexPath.row == 0{
            // Road Map
            cell.addSubview(instructionScene.roadMap)
            let rowHeight = instructionScene.cellHeightsDict[instructionScene.cellHeightsSorttedList()[indexPath.row]]!
            instructionScene.setRoadMapLayout(height:rowHeight, to: cell, view:self.view)
            setUpTabViews()
            setAnimatedChose(to: cell)
            let tap = UITapGestureRecognizer(target: self, action: #selector(questionMarkTapped))
            setAndGetQuestionMarkOnRoadMap(to: cell).addGestureRecognizer(tap)
        }else if indexPath.section == 0 && indexPath.row == 1{
            // Curve
            cell.addSubview(instructionScene.curve)
            instructionScene.setCurveLayout(height: instructionScene.cellHeightsDict[instructionScene.cellHeightsSorttedList()[indexPath.row]]!, view:self.view)
            cell.backgroundColor = UIColor.byuHRed
            // reminder title
            let tap = UITapGestureRecognizer(target: self, action: #selector(questionMarkTapped))
            setReminderTitleAndGetQuestionMark(percentage: dataFlow!.lessonPlanCompletion, cell:cell).addGestureRecognizer(tap)
        }else if indexPath.section == 0 && indexPath.row == 2{
            // Reminder
            let reminder = setReminderCollectionView()
            reminder.delegate = self
            reminder.dataSource = self
            cell.addSubview(reminder)
            reminder.scrollToItem(at: IndexPath(item: 5, section: 0), at: .centeredHorizontally, animated: false)
        }else if indexPath.section == 0 && indexPath.row == 3{
            // Title & Question Mark
            cell.addSubview(instructionScene.titleView)
            instructionScene.setTitleViewLayout(height: instructionScene.cellHeightsDict[instructionScene.cellHeightsSorttedList()[indexPath.row]]!, view:self.view)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(questionMarkTapped))
            instructionScene.questionMark.addGestureRecognizer(tapGesture)
            // Redo Icon
            cell.addSubview(instructionScene.redoImageView)
            instructionScene.setRedoLayout(height: instructionScene.cellHeightsDict[instructionScene.cellHeightsSorttedList()[indexPath.row]]!, view: self.view)
            let gesture = UITapGestureRecognizer(target: self, action: #selector(redoClicked))
            instructionScene.redoImageView.addGestureRecognizer(gesture)
            // Animated Pointer
            let pointer = UIImageView()
            pointer.image = #imageLiteral(resourceName: "finger pointing-user (1)")
            pointer.frame = CGRect(x: self.view.center.x-22, y: instructionScene.tipLabel.frame.maxY, width: 44, height: 44)
            cell.addSubview(pointer)
            //            addAnimatedIcon(to: cell, in: CGRect(x: self.view.center.x-22, y: instructionScene.tipLabel.frame.maxY, width: 44, height: 44),image:#imageLiteral(resourceName: "drag1"))
        }else if indexPath.section == 0 && indexPath.row == 4{
            // Modules (Bars)
            //let row = 5
            updateBarsFromModel(cell:cell, view:self.view, removeIndex: nil, redo:true)
            for bar in instructionScene.bars{
                // Pan Gesture
                let padRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.paned))
                bar.addGestureRecognizer(padRecognizer)
                // Tap Gesture
                let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.editInBarTapped))
                bar.editImageView.addGestureRecognizer(tapRecognizer)
            }
        }else if indexPath.section == 1 && indexPath.row == 0{
            // state the objective
            let cell = tableView.dequeueReusableCell(withIdentifier: "SDContentTableViewCell") as! SDContentTableViewCell
            cell.selectionStyle = .none
            cell.label.text = "My Learning Objective One"
            cell.textView.textColor = .black
            cell.textView.text =  dataFlow!.learningObjectiveOne
            cell.shape = "triangle"
            cell.setupLayout(view:self.view)
            cell.changeTextViewHeight(view:self.view, to: 100)
            cell.backgroundColor = UIColor.byuHlightGray
            cell.delegate = self
            // add gesture for question mark
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(questionMarkTapped))
            cell.questionMark.tag = instructionModel.getIDfromTitle["State Objectives"]!
            cell.questionMark.addGestureRecognizer(tapGesture)
            return cell
        }else if indexPath.section == 1 && indexPath.row == 1{
            // state the objective
            let cell = tableView.dequeueReusableCell(withIdentifier: "SDContentTableViewCell") as! SDContentTableViewCell
            cell.selectionStyle = .none
            cell.shape = "triangle"
            cell.textView.text =  dataFlow!.learningObjectiveTwo
            cell.textView.textColor = .black
            cell.label.text = "My Learning Objective Two"
            cell.setupLayout(view:self.view)
            cell.changeTextViewHeight(view:self.view, to: 100)
            cell.backgroundColor = UIColor.byuHlightGray
            cell.delegate = self
            // add gesture for question mark
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(questionMarkTapped))
            cell.questionMark.tag = instructionModel.getIDfromTitle["State Objectives"]!
            cell.questionMark.addGestureRecognizer(tapGesture)
            return cell
        }else{
            var offset  = 0
            if indexPath.section == 1 && indexPath.row > 1{
                offset  = 2
            }
            let title = currentStep?[indexPath.section-1].steps[indexPath.row - offset].step
            // Main Content TableViews
            let cell = tableView.dequeueReusableCell(withIdentifier: "SDContentTableViewCell") as! SDContentTableViewCell
            cell.selectionStyle = .none
            if title == "Differentiation of Presentation / Lecture"
                || title == "Differentiation of Direct Instruction"
                || title == "Differentiation of Cooperative Learning"
                || title == "Differentiation of Classroom Discussion"
                || title == "Differentiation of 5 Es"
                || title == "Differentiation of Language Support"
                || title == "Combined Differentiation"{
                cell.shape = "star"
                 cell.questionMark.tag = instructionModel.getIDfromTitle["Differentiation"]!
            }else if title == "Formative Assessment of Presentation / Lecture"
            || title == "Formative Assessment of Direct Instruction"
            || title == "Formative Assessment of Cooperative Learning"
            || title == "Formative Assessment of Classroom Discussion"
            || title == "Formative Assessment of 5 Es"
            || title == "Formative Assessment of Language Support"
            || title == "Combined Formative Assessment"{
                cell.shape = "star"
                 cell.questionMark.tag = instructionModel.getIDfromTitle["Formative"]!
            }else if title == "Presentation Lecture Content Topic One" ||
                title == "Presentation Lecture Content Topic Two" ||
                title == "Presentation Lecture Content Topic Three" ||
                title == "Language Support Content Topic One" ||
                title == "Language Support Content Topic Two" ||
                title == "Language Support Content Topic Three" ||
                title == "Combined Content Topic One" ||
                title == "Combined Content Topic Two" ||
                title == "Combined Content Topic Three"{
                cell.shape = "circle"
                cell.questionMark.tag = instructionModel.getIDfromTitle["Topics"]!
            }else if title == "Presentation Lecture Meaningful Activity One" ||
            title == "Presentation Lecture Meaningful Activity Two" ||
            title == "Presentation Lecture Meaningful Activity Three" ||
            title == "Language Support Meaningful Activity One" ||
            title == "Language Support Meaningful Activity Two" ||
            title == "Language Support Meaningful Activity Three" ||
            title == "Combined Meaningful Activity One" ||
            title == "Combined Meaningful Activity Two" ||
            title == "Combined Meaningful Activity Three"{
                cell.shape = "circle"
                cell.questionMark.tag = instructionModel.getIDfromTitle["Meaningful Activity"]!
            }else if title == "Presentation Lecture Check Understanding One" ||
            title == "Presentation Lecture Check Understanding Two" ||
            title == "Presentation Lecture Check Understanding Three" ||
            title == "Language Support Check Understanding One" ||
            title == "Language Support Check Understanding Two" ||
            title == "Language Support Check Understanding Three" ||
            title == "Combined Check Understanding One" ||
            title == "Combined Check Understanding Two" ||
            title == "Combined Check Understanding Three"{
                cell.shape = "circle"
                cell.questionMark.tag = instructionModel.getIDfromTitle["Check Understanding"]!
            }else{
                cell.shape = "circle"
                cell.questionMark.tag = instructionModel.getIDfromTitle[title!]!
            }
            cell.label.text = title
            if currentStep?[indexPath.section-1].steps[indexPath.row - offset].content == ""{
                cell.textView.textColor = .lightGray
                cell.textView.text = "(Optional)"
            }else{
                cell.textView.textColor = .black
                cell.textView.text = currentStep?[indexPath.section-1].steps[indexPath.row - offset].content
            }
            cell.backgroundColor = UIColor.byuHlightGray
            cell.delegate = self
            cell.setupLayout(view:self.view)
            // add gesture for question mark
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(questionMarkTapped))
            self.tappedSection = indexPath.section-1
            cell.questionMark.addGestureRecognizer(tapGesture)
            return cell
        }
        return cell
    }
}

// MARK: Functions
extension InstructionViewController{
    @objc func expendOrCollapse(button:UIButton){
        var indexPath = [IndexPath]()
        if button.tag == 1{
             indexPath.append(IndexPath(row: 0, section: button.tag))
             indexPath.append(IndexPath(row: 1, section: button.tag))
            for i in 0..<currentStep![button.tag-1].steps.count{
                indexPath.append(IndexPath(row: i+2, section: button.tag))
            }
        }else{
            for i in 0..<currentStep![button.tag-1].steps.count{
                indexPath.append(IndexPath(row: i, section: button.tag))
            }
        }
        if button.titleLabel?.text == "collapse ∆"{
            button.setTitle("expand ∇", for: .normal)
            currentStepIsOpen[button.tag-1] = false
            mainTableView.deleteRows(at: indexPath, with: .fade)
        }else{
            button.setTitle("collapse ∆", for: .normal)
            currentStepIsOpen[button.tag-1] = true
            mainTableView.insertRows(at: indexPath, with: .fade)
            mainTableView.scrollToRow(at: IndexPath(row: 0, section: button.tag), at: .top, animated: true)
        }
    }
    private func convertInstructionSequenceTocurrentStep(data:(title:String,color:UIColor, steps:[(step:String, content:String)])){
        currentStep = []
        currentStepIsOpen = []
        dataFlow?.convertRegularModelToJsonModel()
        if data.steps[data.steps.count-1].step != "Combined Formative Assessment"{
            currentStep?.append(data)
        }else{
            let titles = data.title.components(separatedBy: "\n")
            if titles.contains("Presentation / Lecture"){
                if titles.contains("Language Support"){
                    currentStep?.append((title: "Presentation / Lecture", color: UIColor.byuhGold, steps: [
                        (step: "Advance Organizer", content: dataFlow!.jsonModel.Item!.Advance_Organizer!.S)
                    ]))
                    currentStep?.append((title: "Language Support", color: UIColor.byuhGold, steps: [
                        (step: "My Language Objective", content: dataFlow!.jsonModel.Item!.My_Language_Objective!.S),
                         (step: "Key Vocabulary", content: dataFlow!.jsonModel.Item!.Key_Vocabulary!.S),
                         (step: "Combined Content Topic One", content: dataFlow!.jsonModel.Item!.Combined_Content_Topic_One!.S),
                         (step: "Combined Meaningful Activity One", content: dataFlow!.jsonModel.Item!.Combined_Meaningful_Activity_One!.S),
                         (step: "Combined Check Understanding One", content: dataFlow!.jsonModel.Item!.Combined_Check_Understanding_One!.S),
                         (step: "Combined Content Topic Two", content: dataFlow!.jsonModel.Item!.Combined_Content_Topic_Two!.S),
                         (step: "Combined Meaningful Activity Two", content: dataFlow!.jsonModel.Item!.Combined_Meaningful_Activity_Two!.S),
                         (step: "Combined Check Understanding Two", content: dataFlow!.jsonModel.Item!.Combined_Check_Understanding_Two!.S),
                         (step: "Combined Content Topic Three", content: dataFlow!.jsonModel.Item!.Combined_Content_Topic_Three!.S),
                         (step: "Combined Meaningful Activity Three", content: dataFlow!.jsonModel.Item!.Combined_Meaningful_Activity_Three!.S),
                         (step: "Combined Check Understanding Three", content: dataFlow!.jsonModel.Item!.Combined_Check_Understanding_Three!.S)
                    ]))
                }else{
                    currentStep?.append((title: "Presentation / Lecture", color: UIColor.byuhGold, steps: [
                        (step: "Advance Organizer", content: dataFlow!.jsonModel.Item!.Advance_Organizer!.S),
                        (step: "Presentation Lecture Content Topic One", content: dataFlow!.jsonModel.Item!.Presentation_Lecture_Content_Topic_One!.S),
                        (step: "Presentation Lecture Meaningful Activity One", content: dataFlow!.jsonModel.Item!.Presentation_Lecture_Meaningful_Activity_One!.S),
                        (step: "Presentation Lecture Check Understanding One", content: dataFlow!.jsonModel.Item!.Presentation_Lecture_Check_Understanding_One!.S),
                        (step: "Presentation Lecture Content Topic Two", content: dataFlow!.jsonModel.Item!.Presentation_Lecture_Content_Topic_Two!.S),
                        (step: "Presentation Lecture Meaningful Activity Two", content: dataFlow!.jsonModel.Item!.Presentation_Lecture_Meaningful_Activity_Two!.S),
                        (step: "Presentation Lecture Check Understanding Two", content: dataFlow!.jsonModel.Item!.Presentation_Lecture_Check_Understanding_Two!.S),
                        (step: "Presentation Lecture Content Topic Three", content: dataFlow!.jsonModel.Item!.Presentation_Lecture_Content_Topic_Three!.S),
                        (step: "Presentation Lecture Meaningful Activity Three", content: dataFlow!.jsonModel.Item!.Presentation_Lecture_Meaningful_Activity_Three!.S),
                        (step: "Presentation Lecture Check Understanding Three", content: dataFlow!.jsonModel.Item!.Presentation_Lecture_Check_Understanding_Three!.S)
                    ]))
                }
            }else if  titles.contains("Language Support"){
                currentStep?.append((title: "Language Support", color: UIColor.byuhGold, steps: [
                    (step: "My Language Objective", content: dataFlow!.jsonModel.Item!.My_Language_Objective!.S),
                    (step: "Key Vocabulary", content: dataFlow!.jsonModel.Item!.Key_Vocabulary!.S),
                    (step: "Language Support Content Topic One", content: dataFlow!.jsonModel.Item!.Language_Support_Content_Topic_One!.S),
                    (step: "Language Support Meaningful Activity One", content: dataFlow!.jsonModel.Item!.Language_Support_Meaningful_Activity_One!.S),
                    (step: "Language Support Check Understanding One", content: dataFlow!.jsonModel.Item!.Language_Support_Check_Understanding_One!.S),
                    (step: "Language Support Content Topic Two", content: dataFlow!.jsonModel.Item!.Language_Support_Content_Topic_Two!.S),
                    (step: "Language Support Meaningful Activity Two", content: dataFlow!.jsonModel.Item!.Language_Support_Meaningful_Activity_Two!.S),
                    (step: "Language Support Check Understanding Two", content: dataFlow!.jsonModel.Item!.Language_Support_Check_Understanding_Two!.S),
                    (step: "Language Support Content Topic Three", content: dataFlow!.jsonModel.Item!.Language_Support_Content_Topic_Three!.S),
                    (step: "Language Support Meaningful Activity Three", content: dataFlow!.jsonModel.Item!.Language_Support_Meaningful_Activity_Three!.S),
                    (step: "Language Support Check Understanding Three", content: dataFlow!.jsonModel.Item!.Language_Support_Check_Understanding_Three!.S),
                ]))
            }
            if  titles.contains("Direct Instruction"){
                currentStep?.append((title: "Direct Instruction", color: UIColor.byuhGold, steps: [
                    (step: "Direct Instruction", content: dataFlow!.jsonModel.Item!.Direct_Instruction!.S),
                    (step: "I Do", content: dataFlow!.jsonModel.Item!.I_Do!.S),
                    (step: "We Do", content: dataFlow!.jsonModel.Item!.We_Do!.S),
                    (step: "You Do Together", content: dataFlow!.jsonModel.Item!.You_Do_Together!.S),
                    (step: "You Do Independent", content: dataFlow!.jsonModel.Item!.You_Do_Independent!.S)
                ]))
            }
            if  titles.contains("Cooperative Learning"){
                currentStep?.append((title: "Cooperative Learning", color: UIColor.byuhGold, steps: [
                    (step: "Present Information", content: dataFlow!.jsonModel.Item!.Present_Information!.S),
                    (step: "Organize Teams", content: dataFlow!.jsonModel.Item!.Organize_Teams!.S),
                    (step: "Assist Teams", content: dataFlow!.jsonModel.Item!.Assist_Teams!.S),
                    (step: "Assess Teams", content: dataFlow!.jsonModel.Item!.Assess_Teams!.S),
                    (step: "Provide Recognition", content: dataFlow!.jsonModel.Item!.Provide_Recognition!.S)
                ]))
            }
            if  titles.contains("Classroom Discussion"){
                currentStep?.append((title: "Classroom Discussion", color: UIColor.byuhGold, steps: [
                    (step: "Focus Discussion", content: dataFlow!.jsonModel.Item!.Focus_Discussion!.S),
                    (step: "Hold Discussion", content: dataFlow!.jsonModel.Item!.Hold_Discussion!.S),
                    (step: "End Discussion", content: dataFlow!.jsonModel.Item!.End_Discussion!.S),
                    (step: "Debrief Discussion", content: dataFlow!.jsonModel.Item!.Debrief_Discussion!.S),
                ]))
            }
            if  titles.contains("5 Es (Science)"){
                currentStep?.append((title: "5 Es(Science):", color: UIColor.byuhGold, steps: [
                    (step: "Engage", content: dataFlow!.jsonModel.Item!.Engage!.S),
                    (step: "Explore", content: dataFlow!.jsonModel.Item!.Explore!.S),
                    (step: "Explain", content: dataFlow!.jsonModel.Item!.Explain!.S),
                    (step: "Elaborate", content: dataFlow!.jsonModel.Item!.Elaborate!.S),
                    (step: "Evaluate", content: dataFlow!.jsonModel.Item!.Evaluate!.S),
                ]))
            }
            currentStep?.append((title: "Others:", color: UIColor.byuhGold, steps: [
                               (step: "Combined Differentiation", content: dataFlow!.jsonModel.Item!.Combined_Differentiation!.S),
                               (step: "Combined Formative Assessment", content: dataFlow!.jsonModel.Item!.Combined_Formative!.S),
                           ]))
        }
        for _ in 0..<currentStep!.count{
            currentStepIsOpen.append(true)
        }
    }
    @objc func showMore(){
        let navc = UINavigationController(rootViewController: TipsViewController())
        navc.modalPresentationStyle = .overFullScreen
        present(navc, animated: true, completion: nil)
    }
    private func createObservers(){
        let name = Notification.Name(rawValue:NotificationName.broadcastToReloadReminderAndTitle.rawValue)
        NotificationCenter.default.addObserver(self, selector: #selector(updateDataflow), name:name, object: nil)
        
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [unowned self] notification in
            // 防止 present singleton instance 后 viewcontroller navigation bar 变色的问题
            // reset Navigation Bar
            self.setNavigationBar(title: "Instruction\nSequence")
            self.addBackNaviButton(title: "Back")
            self.mainTableView.reloadData()
        }
    }
    @objc private func updateDataflow(notification:NSNotification){
        updateCollectionViewAndTitleViewfromModel(from: dataFlow!, to: mainTableView)
    }
    private func scrollToCurrentItem(){
        if let cell = (mainTableView.cellForRow(at: IndexPath(row: instructionScene.cellHeightsSorttedList().firstIndex(of: "2_reminder")!, section: 0))){
            if let collectionView = (cell.subviews[1]) as? UICollectionView{
                collectionView.scrollToItem(at:IndexPath(item: 5, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }
    @objc func questionMarkTapped(recognizer:UITapGestureRecognizer){
        switch recognizer.view!.tag {
        case 0:
            animatedIn(self.setBlurView())
            animatedIn(self.setPopView(title: instructionModel.popupTitleOnRoadMap, content:instructionModel.popupContentOnRoadMap, textAlignment: .center))
        case 1:
            animatedIn(self.setBlurView())
            animatedIn(self.setPopView(title: instructionModel.popupTitleOnWhat, content:instructionModel.popupContentOnWhat, textAlignment: .justified))
        case 2:
            animatedIn(self.setBlurView())
            animatedIn(self.setPopView(title: instructionModel.popupTitleNextToPercentage, content:dataFlow!.wholeState, textAlignment: .left))
        default:
            animatedIn(self.setBlurView())
            animatedIn(self.setPopView(title: "\(instructionModel.getNoteFromID[recognizer.view!.tag]![0])", content:"\(instructionModel.getNoteFromID[recognizer.view!.tag]![1])",title2:"\(instructionModel.getNoteFromID[recognizer.view!.tag]![2])",content2: "\(instructionModel.getNoteFromID[recognizer.view!.tag]![3])",  textAlignment: .justified))
        }
    }
    @objc func editInBarTapped(recognizer:UITapGestureRecognizer){
        // diable textview edting
        for visibleCell in mainTableView.visibleCells{
            if let cell = visibleCell as? SDContentTableViewCell{
                cell.textView.endEditing(true)
            }
        }
        for i in 0..<(dataFlow?.instructionSequence.count)!{
            if dataFlow?.instructionSequence[i].title == (recognizer.view?.superview as! ModelBarView).barTitle{
                self.convertInstructionSequenceTocurrentStep(data: (dataFlow?.instructionSequence[i])!)
                break
//                currentStep = dataFlow?.instructionSequence[i]
            }
        }
        mainTableView.reloadData()
        mainTableView.scrollToRow(at: IndexPath(row: 2, section: 1), at: .top, animated: true)
        shouldAnimate = false
        
        // Practice List
        let navTitleLable = UILabel()
        navTitleLable.font = UIFont(name: "GillSans-Bold", size: 25)
        navTitleLable.adjustsFontSizeToFitWidth = true
        navTitleLable.text = "Academic tasks must be clearly explained and modeled for students"
        navTitleLable.textAlignment = .center
        navTitleLable.numberOfLines = 2
        navTitleLable.textColor = .white
        navTitleLable.alpha = 1
        self.navigationItem.titleView = navTitleLable
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.6058552265, green: 0.120728381, blue: 0.2143063247, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                                                                        NSAttributedString.Key.font: UIFont(name: "GillSans-Bold", size: 25)!]
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationItem.leftBarButtonItem?.title = "Tips:"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "More",
            style: .done,
            target: self,
            action: #selector(showMore))
        var titles:[String] = []
        for val in instructionModel.practiceDict.values{
            titles.append(contentsOf: val)
        }
        var i = 1
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            UIView.transition(
                with: navTitleLable,
                duration: 0.5,
                options: .transitionFlipFromBottom,
                animations: {
                    navTitleLable.text = titles[i]
            },
                completion: { finished in
                    i += 1
                    if i == titles.count{
                        i = 0
                    }
            })
        }
    }
    func updateCellHeights(){
        // for road map size
        if self.view.frame.width > self.view.frame.height{
            // landscape
            // not ipad
            if traitCollection.horizontalSizeClass != .regular || traitCollection.verticalSizeClass != .regular{
                // 如果不是 ipad， 就把 roadmap 充满整个屏幕
                instructionScene.cellHeightsDict["0_roadMap"] = self.view.frame.height - safeTop - navHeight - safeBottom - bottomViewFrame.height
            }else{
                // 如果是 ipad， landscape 500 足以
                instructionScene.cellHeightsDict["0_roadMap"] = 500
            }
        }else{
            // Portrait
            // ipad only
            if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular{
                // 如果是 ipad， 就放大一点， 500 足以
                instructionScene.cellHeightsDict["0_roadMap"] = 500
            }else{
                instructionScene.cellHeightsDict["0_roadMap"] = 250
            }
        }
        // for bars size
        var offset = 0
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular{
            numOfCols = 2
            offset = 6
        }else if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular{
            numOfCols = 3
            offset = 8
        }else if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .compact{
            numOfCols = 4
            offset = 10
        }
        if self.view.frame.width < self.view.frame.height{
            numOfRows =  Int(ceil(Double(dataFlow!.instructionSequence.count) / Double(numOfCols)))
            let temp = (view.frame.width-44-CGFloat(offset)*sdGap)
            barWidth = temp/CGFloat(numOfCols)
            if numOfRows == 3{
                instructionScene.cellHeightsDict["4_bars"]! = CGFloat(numOfRows)*barWidth+6*sdGap
            }else if numOfRows == 2{
                instructionScene.cellHeightsDict["4_bars"]! = CGFloat(numOfRows)*barWidth+4*sdGap
            }else{
                instructionScene.cellHeightsDict["4_bars"]! = barWidth+2*sdGap
            }
        }else{
            numOfCols = 4
            offset = 10
            numOfRows =  Int(ceil(Double(dataFlow!.instructionSequence.count) / Double(numOfCols)))
            let temp = (view.frame.width-44-CGFloat(offset)*sdGap)
            barWidth = (temp-safeLeft-safeRight)/CGFloat(numOfCols)
            if numOfRows == 2{
                instructionScene.cellHeightsDict["4_bars"]! = CGFloat(numOfRows)*barWidth+6*sdGap
            }else{
                instructionScene.cellHeightsDict["4_bars"]! = CGFloat(numOfRows)*barWidth+4*sdGap
            }
        }
    }
    @objc func redoClicked(){
        dataFlow?.convertRegularModelToJsonModel()
        dataFlow?.instructionSequence = dataFlow!.defaultInstructionSequence
        dataFlow?.jsonModel.Item?.isCombined = false
        dataFlow?.jsonModel.Item?.Presentation_Lecture_State?.S = "separated"
        dataFlow?.jsonModel.Item?.Direct_Instruction_State?.S = "separated"
        dataFlow?.jsonModel.Item?.Cooperative_Learning_State?.S = "separated"
        dataFlow?.jsonModel.Item?.Classroom_Discussion_State?.S = "separated"
        dataFlow?.jsonModel.Item?.FiveEs_State?.S = "separated"
        dataFlow?.jsonModel.Item?.ELLP_State?.S = "separated"
        dataFlow?.convertJsonModelToRegularModel()
        currentStep = nil
//        instructionScene.cellHeightsDict["5_mainContentTitle"]! = 44
        let rowNum = instructionScene.cellHeightsSorttedList().firstIndex(of: "4_bars")!
        if let cell = self.mainTableView.cellForRow(at: IndexPath(row: rowNum, section: 0)){
            self.updateBarsFromModel(cell:cell, view:self.view, removeIndex: nil, redo:true)
        }
        updateCellHeights()
        mainTableView.reloadData()
        reloadBarsTableViews()
        mainTableView.scrollToRow(at: IndexPath(row: instructionScene.cellHeightsSorttedList().firstIndex(of: "4_bars")!, section: 0), at: .top, animated: true)
        shouldAnimate = false
    }
    func updateBarsFromModel(cell:UITableViewCell, view:UIView, removeIndex: Int?, redo:Bool){
        instructionScene.setBarsLayout(numOfCols:numOfCols, cell:cell, view:self.view, barWidth: barWidth, data: dataFlow!, removeIndex: removeIndex, redo:redo)
    }
    func reloadBarsTableViews(){
        for bar in self.instructionScene.bars{
            bar.stepTableView.reloadData()
        }
    }
    @objc func paned(gesture:UIPanGestureRecognizer){
        draggedBar = (gesture.view as! ModelBarView)
        if gesture.state == .began{
            mainTableView.cellForRow(at: IndexPath(row: instructionScene.cellHeightsSorttedList().firstIndex(of: "4_bars")!, section: 0))?.bringSubviewToFront(draggedBar!)
        }else if gesture.state == .changed{
            // drag
            // diable textview edting
            for visibleCell in mainTableView.visibleCells{
                if let cell = visibleCell as? SDContentTableViewCell{
                    cell.textView.endEditing(true)
                }
            }
            let translation = gesture.translation(in: mainTableView.cellForRow(at: IndexPath(row: instructionScene.cellHeightsSorttedList().firstIndex(of: "4_bars")!, section: 0)))
            draggedBar!.transform = CGAffineTransform(translationX: translation.x, y: translation.y )
            // intersection
            var interscedAreas = [ModelBarView:CGFloat]()
            for bar in instructionScene.bars{
                interscedAreas[bar] = CGFloat(0)
            }
            // get intersected areas
            for bar in interscedAreas.keys{
                if draggedBar!.barTitle != bar.barTitle{
                    interscedAreas[bar] = getArea(frame: draggedBar!.frame.intersection(bar.frame))
                }
            }
            // change bar property
            for bar in interscedAreas.keys{
                if interscedAreas.values.max() != 0 && interscedAreas[bar] ==  interscedAreas.values.max(){
                    bar.alpha = 0.75
                    bar.plusImageView.alpha = 1
                    destinationBar = bar
                    bar.addBorder()
                    // 另一种效果
                    //                    mainTableView.cellForRow(at: IndexPath(row: 5, section: 0))?.bringSubviewToFront(draggedBar!)
                    //                    mainTableView.cellForRow(at: IndexPath(row: 5, section: 0))?.bringSubviewToFront(bar)
                }else{
                    bar.alpha = 1
                    bar.plusImageView.alpha = 0
                    bar.removeBorder()
                }
            }
            if interscedAreas.values.max() == 0{
                destinationBar = nil
            }
        }else if gesture.state == .ended{
            if destinationBar != nil{
                // change to combined color
                destinationBar?.backgroundColor = UIColor.byuhGold
                self.destinationBar?.plusImageView.alpha = 0
                UIView.animate(withDuration: 0.5, animations: {
                    self.draggedBar!.frame = CGRect(x: self.destinationBar!.center.x, y: self.destinationBar!.center.y, width: 0, height: 0)
                    self.draggedBar!.alpha = 0
                    self.destinationBar?.removeBorder()
                    self.destinationBar?.alpha = 1
                    self.destinationBar?.doneImageView.alpha = 1
                }, completion: { finished in
                    // update the model
                    var removeIndex:Int?
                    var insertIndex:Int?
                    for index in 0..<(self.dataFlow?.instructionSequence.count)!{
                        if self.dataFlow?.instructionSequence[index].title == self.draggedBar?.barTitle{
                            removeIndex = index
                        }
                        if self.dataFlow?.instructionSequence[index].title == self.destinationBar?.barTitle{
                            insertIndex = index
                        }
                    }
                    if removeIndex != nil{
                        // update the differentation and fomative
                        let insertCounter =  self.dataFlow?.instructionSequence[insertIndex!].steps.count
                        let removeCounter = self.dataFlow?.instructionSequence[removeIndex!].steps.count
                        // Fomative
                        if (self.dataFlow?.instructionSequence[removeIndex!].steps[removeCounter!-1])!.content != ""
                            && (self.dataFlow?.instructionSequence[removeIndex!].steps[removeCounter!-1])!.content !=
                            (self.dataFlow?.instructionSequence[insertIndex!].steps[insertCounter!-1])!.content{
                            self.dataFlow?.instructionSequence[removeIndex!].steps[removeCounter!-1].content =
                                (self.dataFlow?.instructionSequence[insertIndex!].steps[insertCounter!-1])!.content + "\n" +
                                (self.dataFlow?.instructionSequence[removeIndex!].steps[removeCounter!-1])!.content
                        }else if (self.dataFlow?.instructionSequence[insertIndex!].steps[insertCounter!-1])!.content != ""
                            && (self.dataFlow?.instructionSequence[removeIndex!].steps[removeCounter!-1])!.content == ""{
                            self.dataFlow?.instructionSequence[removeIndex!].steps[removeCounter!-1].content = (self.dataFlow?.instructionSequence[insertIndex!].steps[insertCounter!-1])!.content
                        }
                        self.dataFlow?.instructionSequence[removeIndex!].steps[removeCounter!-1].step = "Combined Formative Assessment"
                        // Differentation
                        if (self.dataFlow?.instructionSequence[removeIndex!].steps[removeCounter!-2])!.content != ""
                            && (self.dataFlow?.instructionSequence[removeIndex!].steps[removeCounter!-2])!.content !=
                            (self.dataFlow?.instructionSequence[insertIndex!].steps[insertCounter!-2])!.content{
                            self.dataFlow?.instructionSequence[removeIndex!].steps[removeCounter!-2].content =
                                (self.dataFlow?.instructionSequence[insertIndex!].steps[insertCounter!-2])!.content + "\n" +
                                (self.dataFlow?.instructionSequence[removeIndex!].steps[removeCounter!-2])!.content
                        }else if (self.dataFlow?.instructionSequence[insertIndex!].steps[insertCounter!-2])!.content != ""
                            && (self.dataFlow?.instructionSequence[removeIndex!].steps[removeCounter!-2])!.content == ""{
                            self.dataFlow?.instructionSequence[removeIndex!].steps[removeCounter!-2].content = (self.dataFlow?.instructionSequence[insertIndex!].steps[insertCounter!-2])!.content
                        }
                        self.dataFlow?.instructionSequence[removeIndex!].steps[removeCounter!-2].step = "Combined Differentiation"
                        // update the title in model
                        self.dataFlow?.instructionSequence[insertIndex!].title += "\n"
                        self.dataFlow?.instructionSequence[insertIndex!].title += self.draggedBar!.barTitle
                        // remove fomative and differenation from removeIndex data
                        self.dataFlow?.instructionSequence[insertIndex!].steps.remove(at: insertCounter!-1)
                        self.dataFlow?.instructionSequence[insertIndex!].steps.remove(at: insertCounter!-2)
                        // update the steps in model
                        self.dataFlow?.instructionSequence[insertIndex!].steps += (self.dataFlow?.instructionSequence[removeIndex!].steps)!
                        
                        // special handling from Presentation/Lecture and Language Support Combination
                        let titles = self.dataFlow?.instructionSequence[insertIndex!].title.split(separator: "\n")
                        if titles != nil{
                            if  titles!.contains(where: {$0 == "Presentation / Lecture"}) && titles!.contains(where: {$0 == "Language Support"}){
                                var middleBackUpDict:[String:String] = [:]
                                for i in 0..<(self.dataFlow?.instructionSequence[insertIndex!].steps.count)!{
                                    middleBackUpDict[(self.dataFlow?.instructionSequence[insertIndex!].steps[i].step)!] = self.dataFlow?.instructionSequence[insertIndex!].steps[i].content
                                }
                                if middleBackUpDict["Presentation Lecture Content Topic One"] != nil{
                                    // 全部重组
                                    self.dataFlow?.instructionSequence[insertIndex!].steps = []
                                    self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                        step:"My Language Objective",
                                        content:middleBackUpDict["My Language Objective"]!))
                                    self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                        step:"Advance Organizer",
                                        content:middleBackUpDict["Advance Organizer"]!))
                                    self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                        step:"Key Vocabulary",
                                        content:middleBackUpDict["Key Vocabulary"]!))
                                    
                                    if middleBackUpDict["Language Support Content Topic One"]! != ""{
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Combined Content Topic One",
                                            content:middleBackUpDict["Presentation Lecture Content Topic One"]!+"\n"+middleBackUpDict["Language Support Content Topic One"]!))
                                    }else{
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Combined Content Topic One",
                                            content:middleBackUpDict["Presentation Lecture Content Topic One"]!))
                                    }
                                    if middleBackUpDict["Language Support Meaningful Activity One"]! != ""{
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Combined Meaningful Activity One",
                                            content:middleBackUpDict["Presentation Lecture Meaningful Activity One"]!+"\n"+middleBackUpDict["Language Support Meaningful Activity One"]!))
                                    }else{
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Combined Meaningful Activity One",
                                            content:middleBackUpDict["Presentation Lecture Meaningful Activity One"]!))
                                    }
                                    if middleBackUpDict["Language Support Check Understanding One"]! != ""{
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Combined Check Understanding One",
                                            content:middleBackUpDict["Presentation Lecture Check Understanding One"]!+"\n"+middleBackUpDict["Language Support Check Understanding One"]!))
                                    }else{
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Combined Check Understanding One",
                                            content:middleBackUpDict["Presentation Lecture Check Understanding One"]!))
                                    }
                                    if middleBackUpDict["Language Support Content Topic Two"]! != ""{
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Combined Content Topic Two",
                                            content:middleBackUpDict["Presentation Lecture Content Topic Two"]!+"\n"+middleBackUpDict["Language Support Content Topic Two"]!))
                                    }else{
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Combined Content Topic Two",
                                            content:middleBackUpDict["Presentation Lecture Content Topic Two"]!))
                                    }
                                    if middleBackUpDict["Language Support Meaningful Activity Two"]! != ""{
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Combined Meaningful Activity Two",
                                            content:middleBackUpDict["Presentation Lecture Meaningful Activity Two"]!+"\n"+middleBackUpDict["Language Support Meaningful Activity Two"]!))
                                    }else{
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Combined Meaningful Activity Two",
                                            content:middleBackUpDict["Presentation Lecture Meaningful Activity Two"]!))
                                    }
                                    if middleBackUpDict["Language Support Check Understanding Two"]! != ""{
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Combined Check Understanding Two",
                                            content:middleBackUpDict["Presentation Lecture Check Understanding Two"]!+"\n"+middleBackUpDict["Language Support Check Understanding Two"]!))
                                    }else{
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Combined Check Understanding Two",
                                            content:middleBackUpDict["Presentation Lecture Check Understanding Two"]!))
                                    }
                                    if middleBackUpDict["Language Support Content Topic Three"]! != ""{
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Combined Content Topic Three",
                                            content:middleBackUpDict["Presentation Lecture Content Topic Three"]!+"\n"+middleBackUpDict["Language Support Content Topic Three"]!))
                                    }else{
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Combined Content Topic Three",
                                            content:middleBackUpDict["Presentation Lecture Content Topic Three"]!))
                                    }
                                    if middleBackUpDict["Language Support Meaningful Activity Three"]! != ""{
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Combined Meaningful Activity Three",
                                            content:middleBackUpDict["Presentation Lecture Meaningful Activity Three"]!+"\n"+middleBackUpDict["Language Support Meaningful Activity Three"]!))
                                    }else{
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Combined Meaningful Activity Three",
                                            content:middleBackUpDict["Presentation Lecture Meaningful Activity Three"]!))
                                    }
                                    if middleBackUpDict["Language Support Check Understanding Three"]! != ""{
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Combined Check Understanding Three",
                                            content:middleBackUpDict["Presentation Lecture Check Understanding Three"]!+"\n"+middleBackUpDict["Language Support Check Understanding Three"]!))
                                    }else{
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Combined Check Understanding Three",
                                            content:middleBackUpDict["Presentation Lecture Check Understanding Three"]!))
                                    }
                                    
                                    if titles!.contains(where: {$0 == "Direct Instruction"}){
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Direct Instruction",
                                            content:middleBackUpDict["Direct Instruction"]!))
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"I Do",
                                            content:middleBackUpDict["I Do"]!))
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"We Do",
                                            content:middleBackUpDict["We Do"]!))
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"You Do Together",
                                            content:middleBackUpDict["You Do Together"]!))
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"You Do Independent",
                                            content:middleBackUpDict["You Do Independent"]!))
                                    }
                                    
                                    if titles!.contains(where: {$0 == "Cooperative Learning"}){
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Present Information",
                                            content:middleBackUpDict["Present Information"]!))
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Organize Teams",
                                            content:middleBackUpDict["Organize Teams"]!))
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Assist Teams",
                                            content:middleBackUpDict["Assist Teams"]!))
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Assess Teams",
                                            content:middleBackUpDict["Assess Teams"]!))
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Provide Recognition",
                                            content:middleBackUpDict["Provide Recognition"]!))
                                    }
                                    
                                    if titles!.contains(where: {$0 == "Classroom Discussion"}){
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Focus Discussion",
                                            content:middleBackUpDict["Focus Discussion"]!))
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Hold Discussion",
                                            content:middleBackUpDict["Hold Discussion"]!))
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"End Discussion",
                                            content:middleBackUpDict["End Discussion"]!))
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Debrief Discussion",
                                            content:middleBackUpDict["Debrief Discussion"]!))
                                    }
                                    
                                    if titles!.contains(where: {$0 == "5 Es (Science)"}){
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Engage",
                                            content:middleBackUpDict["Engage"]!))
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Explore",
                                            content:middleBackUpDict["Explore"]!))
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Explain",
                                            content:middleBackUpDict["Explain"]!))
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Elaborate",
                                            content:middleBackUpDict["Elaborate"]!))
                                        self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                            step:"Evaluate",
                                            content:middleBackUpDict["Evaluate"]!))
                                    }
                                    
                                    self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                        step:"Combined Differentiation",
                                        content:middleBackUpDict["Combined Differentiation"]!))
                                    self.dataFlow?.instructionSequence[insertIndex!].steps.append((
                                        step:"Combined Formative Assessment",
                                        content:middleBackUpDict["Combined Formative Assessment"]!))
                                }
                            }
                        }
                        // update the current step
                        if self.currentStep != nil{
                            self.convertInstructionSequenceTocurrentStep(data: (self.dataFlow?.instructionSequence[insertIndex!])!)
//                            self.currentStep =  self.dataFlow?.instructionSequence[insertIndex!]
                        }
                        // remove the bar
                        self.dataFlow?.instructionSequence.remove(at: removeIndex!)
                        // update main content title cell height
//                        self.instructionScene.cellHeightsDict["5_mainContentTitle"]! += 17
                        // update cell height
                        self.updateCellHeights()
                    }
                    UIView.animate(
                        withDuration: 0.5,
                        animations: {
                            self.destinationBar?.plusImageView.alpha = 0
                            self.destinationBar?.doneImageView.alpha = 0
                            // update view from model
                            self.updateBarsFromModel(cell:self.mainTableView.cellForRow(at: IndexPath(row:self.instructionScene.cellHeightsSorttedList().firstIndex(of: "4_bars")!, section: 0))!, view:self.view, removeIndex: removeIndex, redo:false)
                            self.reloadBarsTableViews()
                    },
                        completion: {finished in
                            self.mainTableView.reloadData()
                            self.scrollToCurrentItem()
                            self.saveCurrentJsonDataToDiskAndBroadcastReminderUpdating(dataFlow: self.dataFlow, animated: true)
                            self.mainTableView.scrollToRow(at: IndexPath(row: 4, section: 0), at: .top, animated: true)
                            self.shouldAnimate = false
                    })
                })
            }else{
                // No destination bar founded, go back to the original spot
                UIView.animate(
                    withDuration: 0.5,
                    delay: 0,
                    usingSpringWithDamping: 0.5,
                    initialSpringVelocity: 1.5,
                    options: .curveEaseIn, animations: {
                        self.draggedBar?.transform = .identity
                        self.scrollToCurrentItem()
                }
                )}
        }
    }
    func getArea(frame:CGRect) -> CGFloat{
        return frame.width*frame.height
    }
    
    @objc func pdfButtonClicked(){
        sequenceTyped = .pdf
        let vc = PDFViewController()
        dataFlow?.convertRegularModelToJsonModel()
        vc.jsonModel = dataFlow?.jsonModel
        vc.lessonPlanCompletion = dataFlow?.lessonPlanCompletion
        vc.wholeState = dataFlow?.wholeState
        #if targetEnvironment(macCatalyst)
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .overFullScreen
        self.present(nc, animated: true, completion: nil)
        #else
        let nc = UINavigationController(rootViewController: vc)
        nc.transitioningDelegate = self
        nc.modalPresentationStyle = .custom
        present(nc, animated: true, completion: nil)
        #endif
    }
    @objc func continueButtonClicked(){
        saveCurrentJsonDataToDiskAndBroadcastReminderUpdating(dataFlow: dataFlow)
        sequenceTyped = .closure
        let vc = ClosureViewController.closureViewControllerInstance
        vc.dataFlow = dataFlow
        ClosureViewController.isVisited = true
        let nc = UINavigationController(rootViewController: vc)
        #if !targetEnvironment(macCatalyst)
        nc.transitioningDelegate = self
        nc.modalPresentationStyle = .custom
        #else
        nc.modalPresentationStyle = .fullScreen
        #endif
        present(nc, animated: true, completion: nil)
    }
    
    @objc func editReminderTapped(_ recoginzer:UITapGestureRecognizer){
        switch recoginzer.view!.tag {
        case 0:
            sequenceTyped = .info
        case 1:
            sequenceTyped = .content
        case 2:
            sequenceTyped = .objectives
        case 3:
            sequenceTyped = .summative
        case 4:
            sequenceTyped = .anticipatory
        case 5:
            sequenceTyped = .instruction
        case 6:
            sequenceTyped = .closure
        case 7:
            sequenceTyped = .background
        case 8:
            sequenceTyped = .lesson
        default:
            return
        }
        tabToNextView()
    }
}

// MARK: Tab Views On Road Map
extension InstructionViewController{
    @objc func contentTyped(){
        sequenceTyped = .content
        tabToNextView()
    }
    @objc func objectivesTyped(){
        sequenceTyped = .objectives
        tabToNextView()
    }
    @objc func summativeTyped(){
        sequenceTyped = .summative
        tabToNextView()
    }
    @objc func anticipatoryTyped(){
        sequenceTyped = .anticipatory
        tabToNextView()
    }
    @objc func instructionTyped(){
        sequenceTyped = .instruction
        tabToNextView()
    }
    @objc func closureTyped(){
        sequenceTyped = .closure
        tabToNextView()
    }
    @objc func backgroundTyped(){
        sequenceTyped = .background
        tabToNextView()
    }
    @objc func lessonTyped(){
        sequenceTyped = .lesson
        tabToNextView()
    }
    func tabToNextView(){
        if dataFlow == nil{
            dataFlow = Model()
        }
        var nc = UINavigationController()
        switch sequenceTyped {
        case .info:
            let vc = InfoViewController.InfoViewControllerInstance
            vc.dataFlow = dataFlow
            InfoViewController.isVisited = true
            nc = UINavigationController(rootViewController: vc)
        case .content:
            let vc = ContentStandardViewController.contentStandardViewControllerInstance
            vc.dataFlow = dataFlow
            ContentStandardViewController.isVisited = true
            nc = UINavigationController(rootViewController: vc)
        case . objectives:
            let vc = ObjectivesViewController.objectivesViewControllerInstance
            vc.dataFlow = dataFlow
            ObjectivesViewController.isVisited = true
            nc = UINavigationController(rootViewController: vc)
        case .summative:
            let vc = SummativeViewController.summativeViewControllerInstance
            vc.dataFlow = dataFlow
            SummativeViewController.isVisited = true
            nc = UINavigationController(rootViewController: vc)
        case .anticipatory:
            let vc = AnticipatoryViewController.anticipatoryViewControllerInstance
            vc.dataFlow = dataFlow
            AnticipatoryViewController.isVisited = true
            nc = UINavigationController(rootViewController: vc)
        case .instruction:
            return
        case .closure:
            let vc = ClosureViewController.closureViewControllerInstance
            vc.dataFlow = dataFlow
            ClosureViewController.isVisited = true
            nc = UINavigationController(rootViewController: vc)
        case .background:
            let vc = BackgroundViewController.backgroundViewControllerInstance
            vc.dataFlow = dataFlow
            BackgroundViewController.isVisited = true
            nc = UINavigationController(rootViewController: vc)
        case .lesson:
            let vc = LessonViewController.lessonViewControllerInstance
            vc.dataFlow = dataFlow
            LessonViewController.isVisited = true
            nc = UINavigationController(rootViewController: vc)
        default:
            let vc = MainViewController()
            vc.dataFlow = dataFlow
            nc = UINavigationController(rootViewController: vc)
        }
        #if !targetEnvironment(macCatalyst)
        nc.transitioningDelegate = self
        nc.modalPresentationStyle = .custom
        #else
        nc.modalPresentationStyle = .fullScreen
        #endif
        present(nc,animated: true,completion: nil)
    }
    func setUpTabViews(){
        let objectivesGesture = UITapGestureRecognizer(target: self, action: #selector(objectivesTyped))
        instructionScene.objectivestv.addGestureRecognizer(objectivesGesture)
        let contentGesture = UITapGestureRecognizer(target: self, action: #selector(contentTyped))
        instructionScene.contenttv.addGestureRecognizer(contentGesture)
        let summativeGesture = UITapGestureRecognizer(target: self, action: #selector(summativeTyped))
        instructionScene.summativetv.addGestureRecognizer(summativeGesture)
        let anticipatoryGesture = UITapGestureRecognizer(target: self, action: #selector(anticipatoryTyped))
        instructionScene.anticipatorytv.addGestureRecognizer(anticipatoryGesture)
        let closureGesture = UITapGestureRecognizer(target: self, action: #selector(closureTyped))
        instructionScene.closuretv.addGestureRecognizer(closureGesture)
        let instructionGesture = UITapGestureRecognizer(target: self, action: #selector(instructionTyped))
        instructionScene.instructiontv.addGestureRecognizer(instructionGesture)
        let backgroundGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTyped))
        instructionScene.backgroundtv.addGestureRecognizer(backgroundGesture)
        let lessonGesture = UITapGestureRecognizer(target: self, action: #selector(lessonTyped))
        instructionScene.lessontv.addGestureRecognizer(lessonGesture)
    }
}

extension Dictionary where Value: Equatable {
    func someKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}
