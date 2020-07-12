//
//  InfoViewController.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 4/20/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit
import GearRefreshControl

class InfoViewController: UIViewController{
    
    // MARK: Global Var
    var infoModel = InfoModel()
    var infoScene = InfoScene()
    let transition = Icon_view_transition()
    var sequenceTyped: Sequecne = .main
    var dataFlow:Model?
    private lazy var mainTableView = addAndGetMainTableView()
    private lazy var gearRefreshControl = GearRefreshControl(frame: self.view.bounds)
    private var currentTabbedTextView = ""
    static let InfoViewControllerInstance = InfoViewController()
    static var isVisited = false
    var shouldPopResotrePopView = false
    
    deinit{
         NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        // Navigation Bar
        self.setNavigationBar(title: infoModel.navTilte)
        self.addBackNaviButton(title: "Back")
        self.title = "InfoViewController"
        
        createObservers()
        updateCellHeights()
        addBottomView()
        addAndGetPDFButton().addTarget(self, action: #selector(pdfButtonClicked), for: .touchUpInside)
        addAndGetContinueButton(title:infoModel.continueButtonTitle).addTarget(self, action: #selector(continueButtonClicked), for: .touchUpInside)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(InfoTableTableViewCell.self, forCellReuseIdentifier: "InfoTableTableViewCell")
        mainTableView.separatorStyle = .none
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
            self.setNavigationBar(title: self.infoModel.navTilte)
            self.addBackNaviButton(title: "Back")
            self.mainTableView.reloadData()
        })
        super.viewWillTransition(to: size, with: coordinator)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // 防止 present singleton instance 后 viewcontroller navigation bar 变色的问题
        // reset Navigation Bar
        self.setNavigationBar(title: infoModel.navTilte)
        self.addBackNaviButton(title: "Back")
        mainTableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if shouldPopResotrePopView{
            animatedIn(self.setBlurView())
            animatedIn(self.setPopView(title: "Load Successfully", content:"You have just restored your last saved lesson plan.\nYou can now continue to edit this lesson plan", textAlignment: .center))
            shouldPopResotrePopView = false
        }
        
    }
}

//MARK: Delegation
extension InfoViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        gearRefreshControl.scrollViewDidScroll(scrollView)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
        self.gearRefreshControl.endRefreshing()
    }
}

extension InfoViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataFlow!.reminderTitle.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ReminderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReminderCollectionViewCell", for: indexPath) as! ReminderCollectionViewCell
        cell.titleLabel.text = dataFlow!.reminderTitle[indexPath.item]
        if indexPath.item == 0{
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
        return CGSize(width: 300, height: infoScene.cellHeights[2].height*0.9)
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

extension InfoViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoScene.cellHeights.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return infoScene.cellHeights[indexPath.row].height
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row >= 3{
//            UIView.transition(
//                with: cell,
//                duration: 0.5,
//                options: .transitionFlipFromBottom, animations: {
//            })
//        }
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.byuHlightGray
        cell.selectionStyle = .none
        if indexPath.row == 0{
            let row = 0
            // Road Map
            cell.addSubview(infoScene.roadMap)
            infoScene.setRoadMapLayout(height: infoScene.cellHeights[row].height, to: cell, from:self.view)
            setUpTabViews()
            setAnimatedChose(to: cell)
            let tap = UITapGestureRecognizer(target: self, action: #selector(questionMarkTapped))
            setAndGetQuestionMarkOnRoadMap(to: cell).addGestureRecognizer(tap)
        }else if indexPath.row == 1{
            let row = 1
            // Curve
            cell.addSubview(infoScene.curve)
            infoScene.setCurveLayout(height: infoScene.cellHeights[row].height, view:self.view)
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
            reminder.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
        }else if indexPath.row == 3{
            let row = 3
            // Hint
            cell.addSubview(infoScene.hint)
            infoScene.setHintLayout(height: infoScene.cellHeights[row].height, view:self.view)
        }else{
            // text View
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableTableViewCell") as! InfoTableTableViewCell
            cell.textView.delegate = self
            cell.view = self.view
            cell.setLayout(view:self.view)
            
            // Picker
            infoScene.picker.delegate = self
            
            if indexPath.row == 4{
                cell.textView.tag = 0
                cell.hintLabel.text = "Teacher's Name"
                if dataFlow!.name == ""{
                    cell.textView.textColor = .lightGray
                    cell.textView.text = "(Required)"
                }else{
                    cell.textView.textColor = .black
                    cell.textView.text = dataFlow!.name
                }
                cell.textView.inputView = nil
                cell.textView.addTwoBarButtons(leftTitle: "Paste", rightTitle: "Done", target: self, leftSelector: #selector(tabPaste), rightSelector: #selector(tapDone))
            }else if indexPath.row == 5{
                cell.hintLabel.text = "Grade"
                cell.textView.inputView = infoScene.picker
                cell.textView.isAccessibilityElement = true
                infoScene.setPickerLayout(view:self.view)
                cell.textView.tag = 1
                if dataFlow!.grade == ""{
                    cell.textView.textColor = .lightGray
                    cell.textView.text = "(Required)"
                }else{
                    cell.textView.textColor = .black
                    cell.textView.text = dataFlow!.grade
                }
                cell.textView.addThreeBarButtons(title1: "Keyboard", title2: "Select A Grade", title3: "Done", target: self, selector1: #selector(tabKeyboard), selector2: #selector(tabSelect), selector3: #selector(tapDone))
            }else if indexPath.row == 6{
                cell.textView.tag = 2
                cell.hintLabel.text = "Subject"
                cell.textView.inputView = infoScene.picker
                if dataFlow!.subject == ""{
                    cell.textView.textColor = .lightGray
                    cell.textView.text = "(Required)"
                }else{
                    cell.textView.textColor = .black
                    cell.textView.text = dataFlow!.subject
                }
                cell.textView.addThreeBarButtons(title1: "Keyboard", title2: "Select A Subject", title3: "Done", target: self, selector1: #selector(tabKeyboard), selector2: #selector(tabSelect), selector3: #selector(tapDone))
            }else if indexPath.row == 7{
                cell.textView.tag = 3
                cell.hintLabel.text = "Lesson Title"
                cell.hintLabel.isAccessibilityElement = true
                if dataFlow!.lessonTitle == ""{
                    cell.textView.textColor = .lightGray
                    cell.textView.text = "(Required)"
                }else{
                    cell.textView.textColor = .black
                    cell.textView.text = dataFlow!.lessonTitle
                }
                cell.textView.inputView = nil
                cell.textView.addTwoBarButtons(leftTitle: "Paste", rightTitle: "Done", target: self, leftSelector: #selector(tabPaste), rightSelector: #selector(tapDone))
            }else if indexPath.row == 8{
                cell.textView.tag = 4
                cell.hintLabel.text = "Email"
                if dataFlow!.email == ""{
                    cell.textView.textColor = .lightGray
                    cell.textView.text = "(Optional)"
                }else{
                    cell.textView.textColor = .black
                    cell.textView.text = dataFlow!.email
                }
                cell.textView.inputView = nil
                cell.textView.addTwoBarButtons(leftTitle: "Paste", rightTitle: "Done", target: self, leftSelector: #selector(tabPaste), rightSelector: #selector(tapDone))
                print("cell: \(cell.isAccessibilityElement)")
                print("textview:\(cell.textView.isAccessibilityElement)")
            }
            return cell
        }
        return cell
    }
}

// MARK: Text View Delegate
extension InfoViewController: UITextViewDelegate{
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool{
        if textView.text == "(Required)" || textView.text == "(Optional)"{
            textView.text = ""
        }
        textView.textColor = .black
        switch textView.tag {
        case 0:
            currentTabbedTextView = "Name"
        case 1:
            infoScene.picker.tag = 1
            infoScene.picker.reloadAllComponents()
        case 2:
            infoScene.picker.tag = 2
            infoScene.picker.reloadAllComponents()
        case 3:
            currentTabbedTextView = "Lesson Title"
        case 4:
            currentTabbedTextView = "Email"
        default:
            return true
        }
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        //        mainTableView.isScrollEnabled = true
        if textView.text == ""{
            if textView.tag == 4{
                textView.textColor = .lightGray
                textView.text = "(Optional)"
            }else{
                textView.textColor = .lightGray
                textView.text = "(Required)"
            }
        }
        saveCurrentJsonDataToDiskAndBroadcastReminderUpdating(dataFlow:dataFlow, animated: true)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
//        mainTableView.isScrollEnabled = false
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView.tag == 0{
            dataFlow!.name = textView.text
        }else if textView.tag == 1{
            dataFlow!.grade = textView.text
        }else if textView.tag == 2{
            dataFlow!.subject = textView.text
        }else if textView.tag == 3{
            dataFlow!.lessonTitle = textView.text
        }else if textView.tag == 4{
            dataFlow!.email = textView.text
        }
        updateCollectionViewAndTitleViewfromModel(from: dataFlow!, to: mainTableView)
    }
}

// MARK: Picker Delegate
extension InfoViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return infoModel.gradeList.count
        case 2:
            return infoModel.subjectList.count
        default:
            return 0
        }
    }
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return infoModel.gradeList[row]
        case 2:
            if row > infoModel.subjectList.count - 1{
                return infoModel.subjectList[infoModel.subjectList.count-1]
            }else{
                return infoModel.subjectList[row]
            }
        default:
            return nil
        }
    }
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            dataFlow?.grade = infoModel.gradeList[row]
            let cell = mainTableView.cellForRow(at: IndexPath(row: 5, section: 0)) as! InfoTableTableViewCell
            cell.textView.text = infoModel.gradeList[row]
        case 2:
            dataFlow?.subject = infoModel.subjectList[row]
            let cell = mainTableView.cellForRow(at: IndexPath(row: 6, section: 0)) as! InfoTableTableViewCell
            cell.textView.text = infoModel.subjectList[row]
        default:
            return
        }
        updateCollectionViewAndTitleViewfromModel(from: dataFlow!, to: mainTableView)
    }
}

// MARK: Functions
extension InfoViewController{
    private func updateCellHeights(){
        if self.view.frame.width > self.view.frame.height{
            // landscape
            // not ipad
            if traitCollection.horizontalSizeClass != .regular || traitCollection.verticalSizeClass != .regular{
                // 如果不是 ipad， 就把 roadmap 充满整个屏幕
                infoScene.cellHeights[0].height = self.view.frame.height - safeTop - navHeight - safeBottom - bottomViewFrame.height
            }else{
                // 如果是 ipad， landscape 500 足以
                infoScene.cellHeights[0].height = 500
            }
        }else{
            // Portrait
            // ipad only
            if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular{
                // 如果是 ipad， 就放大一点， 500 足以
                infoScene.cellHeights[0].height = 500
            }else{
                infoScene.cellHeights[0].height = 250
            }
        }
    }
    private func createObservers(){
        let name = Notification.Name(rawValue:NotificationName.broadcastToReloadReminderAndTitle.rawValue)
        NotificationCenter.default.addObserver(self, selector: #selector(updateDataflow), name:name, object: nil)
        
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [unowned self] notification in
            // 防止 present singleton instance 后 viewcontroller navigation bar 变色的问题
            // reset Navigation Bar
            self.setNavigationBar(title: self.infoModel.navTilte)
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
                collectionView.scrollToItem(at:IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }
    @objc func questionMarkTapped(recognizer: UITapGestureRecognizer){
        if recognizer.view!.tag == 0{
            animatedIn(self.setBlurView())
            animatedIn(self.setPopView(title: infoModel.popupTitleOnRoadMap, content:infoModel.popupContentOnRoadMap, textAlignment: .center))
        }else if recognizer.view!.tag == 2{
            animatedIn(self.setBlurView())
            animatedIn(self.setPopView(title: infoModel.popupTitleNextToPercentage, content:dataFlow!.wholeState, textAlignment: .left))
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
    @objc func tapDone(){
        self.view.endEditing(true)
    }
    @objc func tabPaste(){
        let pb: UIPasteboard = UIPasteboard.general
        switch currentTabbedTextView {
        case "Name":
            let cell = mainTableView.cellForRow(at: IndexPath(row: 4, section: 0)) as! InfoTableTableViewCell
            cell.textView.text += pb.string ?? ""
            dataFlow!.name = cell.textView.text
        case "Lesson Title":
            let cell = mainTableView.cellForRow(at: IndexPath(row: 7, section: 0)) as! InfoTableTableViewCell
            cell.textView.text += pb.string ?? ""
            dataFlow!.lessonTitle = cell.textView.text
        case "Email":
            let cell = mainTableView.cellForRow(at: IndexPath(row: 8, section: 0)) as! InfoTableTableViewCell
            cell.textView.text += pb.string ?? ""
            dataFlow!.email = cell.textView.text
        default:
            return
        }
        updateCollectionViewAndTitleViewfromModel(from: dataFlow!, to: mainTableView)
    }
    @objc func tabSelect(){
        switch infoScene.picker.tag {
        case 1:
            let cell = mainTableView.cellForRow(at: IndexPath(row: 5, section: 0)) as! InfoTableTableViewCell
            cell.textView.inputView = infoScene.picker
            cell.textView.reloadInputViews()
        case 2:
            let cell = mainTableView.cellForRow(at: IndexPath(row: 6, section: 0)) as! InfoTableTableViewCell
            cell.textView.inputView = infoScene.picker
            cell.textView.reloadInputViews()
        default:
            return 
        }
    }
    @objc func tabKeyboard(){
        switch infoScene.picker.tag {
        case 1:
            let cell = mainTableView.cellForRow(at: IndexPath(row: 5, section: 0)) as! InfoTableTableViewCell
            cell.textView.inputView = nil
            cell.textView.reloadInputViews()
        default:
            let cell = mainTableView.cellForRow(at: IndexPath(row: 6, section: 0)) as! InfoTableTableViewCell
            cell.textView.inputView = nil
            cell.textView.reloadInputViews()
        }
    }
    @objc func continueButtonClicked(){
        saveCurrentJsonDataToDiskAndBroadcastReminderUpdating(dataFlow:dataFlow)
        sequenceTyped = .content
        let vc = ContentStandardViewController.contentStandardViewControllerInstance
        vc.dataFlow = dataFlow
        ContentStandardViewController.isVisited = true
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
extension InfoViewController{
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
            return
        case .content:
            let vc = ContentStandardViewController.contentStandardViewControllerInstance
            vc.dataFlow = dataFlow
            ContentStandardViewController.isVisited = true
            nc = UINavigationController(rootViewController: vc)
        case .objectives:
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
        infoScene.objectivestv.addGestureRecognizer(objectivesGesture)
        let contentGesture = UITapGestureRecognizer(target: self, action: #selector(contentTyped))
        infoScene.contenttv.addGestureRecognizer(contentGesture)
        let summativeGesture = UITapGestureRecognizer(target: self, action: #selector(summativeTyped))
        infoScene.summativetv.addGestureRecognizer(summativeGesture)
        let anticipatoryGesture = UITapGestureRecognizer(target: self, action: #selector(anticipatoryTyped))
        infoScene.anticipatorytv.addGestureRecognizer(anticipatoryGesture)
        let closureGesture = UITapGestureRecognizer(target: self, action: #selector(closureTyped))
        infoScene.closuretv.addGestureRecognizer(closureGesture)
        let instructionGesture = UITapGestureRecognizer(target: self, action: #selector(instructionTyped))
        infoScene.instructiontv.addGestureRecognizer(instructionGesture)
        let backgroundGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTyped))
        infoScene.backgroundtv.addGestureRecognizer(backgroundGesture)
        let lessonGesture = UITapGestureRecognizer(target: self, action: #selector(lessonTyped))
        infoScene.lessontv.addGestureRecognizer(lessonGesture)
    }
}
