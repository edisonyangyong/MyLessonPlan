//
//  LessonViewController.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 4/20/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit
import GearRefreshControl

class LessonViewController: UIViewController {
    var dataFlow:Model?
    var lessonScene = LessonScene()
    let transition = Icon_view_transition()
    var sequenceTyped: Sequecne = .main
    private lazy var mainTableView = addAndGetMainTableView()
    private lazy var gearRefreshControl = GearRefreshControl(frame: self.view.bounds)
    private var lessonModel = LessonModel()
    static let lessonViewControllerInstance = LessonViewController()
    static var isVisited = false
    
   deinit{
         NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
         
        // Navigation Bar
        self.setNavigationBar(title: "Lesson Adaptation\nReflective Questions")
        self.addBackNaviButton(title: "Back")
        
        self.title = "LessonViewController"
        createObservers()
        updateCellHeights()
        addBottomView()
        addAndGetPDFButton().addTarget(self, action: #selector(pdfButtonClicked), for: .touchUpInside)
        addAndGetContinueButton(title:"Save and Continue to\nInstruction Sequence →").addTarget(self, action: #selector(continueButtonClicked), for: .touchUpInside)
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
            // 防止 present singleton instance 后 viewcontroller navigation bar 变色的问题
            // reset Navigation Bar
            self.setNavigationBar(title: "Lesson Adaptation\nReflective Questions")
            self.addBackNaviButton(title: "Back")
            self.mainTableView.reloadData()
        })
        super.viewWillTransition(to: size, with: coordinator)
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(true)
        // 防止 present singleton instance 后 viewcontroller navigation bar 变色的问题
        // reset Navigation Bar
        self.setNavigationBar(title: "Lesson Adaptation\nReflective Questions")
        self.addBackNaviButton(title: "Back")
        self.mainTableView.reloadData()
    }
}

//MARK: Delegation
extension LessonViewController: SDContentTableViewCellDataFlowUpdatingDelegation{
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
            if step == "Lesson Adaptation"{
                dataFlow?.lessonAdaption = content
            }else if step == "Reflective Questions"{
                dataFlow?.reflectiveQuestions = content
            }
            // reload reminder cards
            updateCollectionViewAndTitleViewfromModel(from: dataFlow!, to: mainTableView)
        }
    }
}

extension LessonViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        gearRefreshControl.scrollViewDidScroll(scrollView)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
        self.gearRefreshControl.endRefreshing()
    }
}

extension LessonViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataFlow!.reminderTitle.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ReminderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReminderCollectionViewCell", for: indexPath) as! ReminderCollectionViewCell
        cell.titleLabel.text = dataFlow!.reminderTitle[indexPath.item]
        if indexPath.item == 8{
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
        return CGSize(width: 300, height: lessonScene.cellHeights[2].height*0.9)
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

extension LessonViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessonScene.cellHeights.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return lessonScene.cellHeights[indexPath.row].height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.byuHlightGray
        cell.selectionStyle = .none
        if indexPath.row == 0{
            let row = 0
            // Road Map
            cell.addSubview(lessonScene.roadMap)
            lessonScene.setRoadMapLayout(height: lessonScene.cellHeights[row].height, to: cell, view:self.view)
            setUpTabViews()
            setAnimatedChose(to: cell)
            let tap = UITapGestureRecognizer(target: self, action: #selector(questionMarkTapped))
            setAndGetQuestionMarkOnRoadMap(to: cell).addGestureRecognizer(tap)
        }else if indexPath.row == 1{
            let row = 1
            // Curve
            cell.addSubview(lessonScene.curve)
            lessonScene.setCurveLayout(height: lessonScene.cellHeights[row].height, view:self.view)
            cell.backgroundColor = UIColor.byuHRed
            // reminder title
             let tap = UITapGestureRecognizer(target: self, action: #selector(questionMarkTapped))
             setReminderTitleAndGetQuestionMark(percentage: dataFlow!.lessonPlanCompletion, cell:cell).addGestureRecognizer(tap)
        }else if indexPath.row == 2{
            // Reminder
            let reminder = setReminderCollectionView()
            reminder.delegate = self
            reminder.dataSource = self
            cell.addSubview(reminder)
            reminder.scrollToItem(at: IndexPath(item: 8, section: 0), at: .centeredHorizontally, animated: false)
        }else if indexPath.row == 3{
            let row = 3
            // Title & Question Mark
            cell.addSubview(lessonScene.titleView)
            lessonScene.setTitleViewLayout(height: lessonScene.cellHeights[row].height, view:self.view)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(questionMarkTapped))
            lessonScene.questionMark.addGestureRecognizer(tapGesture)
        }else if indexPath.row == 4{
            // Lesson Adaptation
            let cell = tableView.dequeueReusableCell(withIdentifier: "SDContentTableViewCell") as! SDContentTableViewCell
            cell.backgroundColor = .green
            cell.selectionStyle = .none
            cell.shape = "circle"
            cell.label.text = "Lesson Adaptation"
            if dataFlow!.lessonAdaption == ""{
                cell.textView.textColor = .lightGray
                cell.textView.text = "(Optional)"
            }else{
                cell.textView.textColor = .black
                cell.textView.text = dataFlow!.lessonAdaption
            }
            cell.backgroundColor = UIColor.byuHlightGray
            cell.delegate = self
            cell.setupLayout(view:self.view)
            // add gesture for question mark
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(questionMarkTapped))
            cell.questionMark.tag = indexPath.row
            cell.questionMark.addGestureRecognizer(tapGesture)
            return cell
        }else if indexPath.row == 5{
            // Differentiation
            let cell = tableView.dequeueReusableCell(withIdentifier: "SDContentTableViewCell") as! SDContentTableViewCell
            cell.backgroundColor = .green
            cell.selectionStyle = .none
            cell.shape = "circle"
            cell.label.text = "Reflective Questions"
            if dataFlow!.reflectiveQuestions == ""{
                cell.textView.textColor = .lightGray
                cell.textView.text = "(Optional)"
            }else{
                cell.textView.textColor = .black
                cell.textView.text = dataFlow!.reflectiveQuestions
            }
            cell.backgroundColor = UIColor.byuHlightGray
            cell.delegate = self
            cell.setupLayout(view:self.view)
            // add gesture for question mark
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(questionMarkTapped))
            cell.questionMark.tag = indexPath.row
            cell.questionMark.addGestureRecognizer(tapGesture)
            return cell
        }
        return cell
    }
}

// MARK: Functions
extension LessonViewController{
    private func updateCellHeights(){
        if self.view.frame.width > self.view.frame.height{
            // landscape
            // not ipad
            if traitCollection.horizontalSizeClass != .regular || traitCollection.verticalSizeClass != .regular{
                // 如果不是 ipad， 就把 roadmap 充满整个屏幕
                lessonScene.cellHeights[0].height = self.view.frame.height - safeTop - navHeight - safeBottom - bottomViewFrame.height
            }else{
                // 如果是 ipad， landscape 500 足以
                lessonScene.cellHeights[0].height = 500
            }
        }else{
            // Portrait
            // ipad only
            if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular{
                // 如果是 ipad， 就放大一点， 500 足以
                lessonScene.cellHeights[0].height = 500
            }else{
                lessonScene.cellHeights[0].height = 250
            }
        }
    }
    private func createObservers(){
        let name = Notification.Name(rawValue:NotificationName.broadcastToReloadReminderAndTitle.rawValue)
        NotificationCenter.default.addObserver(self, selector: #selector(updateDataflow), name:name, object: nil)
        
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [unowned self] notification in
            // 防止 present singleton instance 后 viewcontroller navigation bar 变色的问题
            // reset Navigation Bar
            self.setNavigationBar(title: "Lesson Adaptation\nReflective Questions")
            self.addBackNaviButton(title: "Back")
            self.mainTableView.reloadData()
        }
    }
    @objc private func updateDataflow(notification:NSNotification){
        updateCollectionViewAndTitleViewfromModel(from: dataFlow!, to: mainTableView)
    }
    private func scrollToCurrentItem(){
        if let cell = (mainTableView.cellForRow(at: IndexPath(row: 2, section: 0))){
            if let collectionView = (cell.subviews[1]) as? UICollectionView{
                collectionView.scrollToItem(at:IndexPath(item: 8, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }
    @objc func questionMarkTapped(recognizer: UIGestureRecognizer){
        if recognizer.view!.tag == 0{
            animatedIn(self.setBlurView())
            animatedIn(self.setPopView(title: lessonModel.popupTitleOnRoadMap, content:lessonModel.popupContentOnRoadMap, textAlignment: .center))
        }else if recognizer.view!.tag == 1{
            animatedIn(self.setBlurView())
            animatedIn(self.setPopView(title: lessonModel.popupTitleOnLessonAdaptation[0], content:lessonModel.popupContentOnLessonAdaptation[0], title2: lessonModel.popupTitleOnLessonAdaptation[1], content2:lessonModel.popupContentOnLessonAdaptation[1],textAlignment: .justified))
        }else if recognizer.view!.tag == 2{
            animatedIn(self.setBlurView())
            animatedIn(self.setPopView(title: lessonModel.popupTitleNextToPercentage, content:dataFlow!.wholeState, textAlignment: .left))
        }else if recognizer.view!.tag == 4{
            animatedIn(self.setBlurView())
            animatedIn(self.setPopView(title: lessonModel.popupTitleOnLessonAdaptation[0], content:lessonModel.popupContentOnLessonAdaptation[0], title2: lessonModel.popupTitleOnLessonAdaptation[1], content2:lessonModel.popupContentOnLessonAdaptation[1],textAlignment: .justified))
        }else if recognizer.view!.tag == 5{
            animatedIn(self.setBlurView())
            animatedIn(self.setPopView(title: lessonModel.popupTitleReflectiveQuestion[0], content:lessonModel.popupContentReflectiveQuestion[0],title2: lessonModel.popupTitleReflectiveQuestion[1], content2:lessonModel.popupContentReflectiveQuestion[1], textAlignment: .justified))
        }
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
        saveCurrentJsonDataToDiskAndBroadcastReminderUpdating(dataFlow:dataFlow)
        sequenceTyped = .objectives
        let vc = ObjectivesViewController.objectivesViewControllerInstance
        vc.dataFlow = dataFlow
        ObjectivesViewController.isVisited = true
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
extension LessonViewController{
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
            let vc = InstructionViewController.instructionViewControllerInstance
            vc.dataFlow = dataFlow
            InstructionViewController.isVisited = true
            nc = UINavigationController(rootViewController: vc)
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
            return
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
        lessonScene.objectivestv.addGestureRecognizer(objectivesGesture)
        let contentGesture = UITapGestureRecognizer(target: self, action: #selector(contentTyped))
        lessonScene.contenttv.addGestureRecognizer(contentGesture)
        let summativeGesture = UITapGestureRecognizer(target: self, action: #selector(summativeTyped))
        lessonScene.summativetv.addGestureRecognizer(summativeGesture)
        let anticipatoryGesture = UITapGestureRecognizer(target: self, action: #selector(anticipatoryTyped))
        lessonScene.anticipatorytv.addGestureRecognizer(anticipatoryGesture)
        let closureGesture = UITapGestureRecognizer(target: self, action: #selector(closureTyped))
        lessonScene.closuretv.addGestureRecognizer(closureGesture)
        let instructionGesture = UITapGestureRecognizer(target: self, action: #selector(instructionTyped))
        lessonScene.instructiontv.addGestureRecognizer(instructionGesture)
        let backgroundGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTyped))
        lessonScene.backgroundtv.addGestureRecognizer(backgroundGesture)
        let lessonGesture = UITapGestureRecognizer(target: self, action: #selector(lessonTyped))
        lessonScene.lessontv.addGestureRecognizer(lessonGesture)
    }
}

