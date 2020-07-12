//
//  NameViewController.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 4/14/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit
import SafariServices
import GearRefreshControl

class ContentStandardViewController: UIViewController{
    var dataFlow:Model?
    var contentScene = ContentScene()
    let transition = Icon_view_transition()
    var sequenceTyped: Sequecne = .main
    static var isRemindered = false
    private var pasteValue = ""
    private lazy var mainTableView = addAndGetMainTableView()
    private lazy var gearRefreshControl = GearRefreshControl(frame: self.view.bounds)
    private var isLinkClicked = false
    private var isStandardPasted = false
    private var contentModel = ContentModel()
    static let contentStandardViewControllerInstance = ContentStandardViewController()
    private var shouldAnimate = false
    private var backFromWeb = false
    static var isVisited = false
    
   deinit{
         NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
         createObservers()
        
        // Navigation Bar
        self.setNavigationBar(title: "Content\nStandard")
        self.addBackNaviButton(title: "Back")
        
        self.title = "ContentStandardViewController"
        
        updateCellHeights()
        addBottomView()
        addAndGetPDFButton().addTarget(self, action: #selector(pdfButtonClicked), for: .touchUpInside)
        addAndGetContinueButton(title:"Save and Continue to\nLearning Objectives →").addTarget(self, action: #selector(continueButtonClicked), for: .touchUpInside)
        mainTableView.delegate = self
        mainTableView.dataSource = self
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
            self.setNavigationBar(title: "Content\nStandard")
            self.addBackNaviButton(title: "Back")
            self.mainTableView.reloadData()
        })
        super.viewWillTransition(to: size, with: coordinator)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.mainTableView.setContentOffset(.zero, animated:true)
        // 防止 present singleton instance 后 viewcontroller navigation bar 变色的问题
        // reset Navigation Bar
        self.setNavigationBar(title: "Content\nStandard")
        self.addBackNaviButton(title: "Back")
        self.mainTableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if dataFlow!.contentStandard == "" && !backFromWeb{
            // check whether community cell is complete visible
            let cellRect = mainTableView.rectForRow(at: IndexPath(row: 4, section: 0))
            let completelyVisible = mainTableView.bounds.contains(cellRect)
            if completelyVisible{
                // show hint animation
                contentScene.showfocuseLinkBlurView(view:self.view)
            }else{
                mainTableView.scrollToRow(at: IndexPath(row: 3, section: 0), at: .top, animated: true)
                shouldAnimate = true
            }
        }
        backFromWeb = false
    }
}

//MARK: Delegation
extension ContentStandardViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        gearRefreshControl.scrollViewDidScroll(scrollView)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
        self.gearRefreshControl.endRefreshing()
    }
}

extension ContentStandardViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataFlow!.reminderTitle.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ReminderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReminderCollectionViewCell", for: indexPath) as! ReminderCollectionViewCell
        cell.titleLabel.text = dataFlow!.reminderTitle[indexPath.item]
        if indexPath.item == 1{
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
        return CGSize(width: 300, height: contentScene.cellHeights[2].height*0.9)
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

extension ContentStandardViewController:UITableViewDelegate,UITableViewDataSource{
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if shouldAnimate{
            contentScene.showfocuseLinkBlurView(view:self.view)
            shouldAnimate = false
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contentScene.cellHeights.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        for i in 0..<contentScene.cellHeights.count{
            if indexPath.row == i{
                return contentScene.cellHeights[i].height
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.byuHlightGray
        cell.selectionStyle = .none
        if indexPath.row == 0{
            // Road Map
            cell.addSubview(contentScene.roadMap)
            contentScene.setRoadMapLayout(height: contentScene.cellHeights[indexPath.row].height, to: cell, from: self.view)
            setUpTabViews()
            setAnimatedChose(to: cell)
            let tap = UITapGestureRecognizer(target: self, action: #selector(questionMarkTapped))
            setAndGetQuestionMarkOnRoadMap(to: cell).addGestureRecognizer(tap)
        }else if indexPath.row == 1{
            // Curve
            cell.addSubview(contentScene.curve)
            contentScene.setCurveLayout(height: contentScene.cellHeights[indexPath.row].height, view:self.view)
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
            reminder.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
        }else if indexPath.row == 3{
            // Step View
            cell.addSubview(contentScene.setStepViewLayout(stepNum:1, isComplete:true, height:contentScene.cellHeights[indexPath.row].height))
            
            // Title & Question Mark
            cell.addSubview(contentScene.titleView)
            contentScene.setTitleViewLayout(height: contentScene.cellHeights[indexPath.row].height, view:self.view)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(questionMarkTapped))
            contentScene.questionMark.addGestureRecognizer(tapGesture)
            
            // Pointer up
            cell.addSubview(contentScene.pointerUp)
            contentScene.pointerUp.frame = CGRect(x: self.view.frame.midX-20, y: 100, width: 40, height: 40)
        }else if indexPath.row == 4{
            // Step View
            cell.addSubview(contentScene.setStepViewLayout(stepNum:2, isComplete:isLinkClicked, height:contentScene.cellHeights[indexPath.row].height))
            
            // Link
            contentScene.setLinkButtonLayout(height: contentScene.cellHeights[indexPath.row].height, view:self.view)
            contentScene.linkButton.addTarget(self, action: #selector(linkButtonClicked), for: .touchUpInside)
//            if  contentScene._linkButton != nil{
//                contentScene._linkButton!.addTarget(self, action: #selector(linkButtonClicked), for: .touchUpInside)
//            }
            cell.addSubview(contentScene.linkButton)
            
//            // Animated Pointer
//            addAnimatedIcon(to: cell, in: CGRect(x: self.view.frame.midX-22, y: contentScene.linkButton.frame.maxY-10, width: 44, height: 44), image:#imageLiteral(resourceName: "tap"))
            
            // Pointer Down
            cell.addSubview(contentScene.pointerDown)
            contentScene.pointerDown.frame = CGRect(x: self.view.frame.midX-20, y: -20, width: 40, height: 40)
        }else if indexPath.row == 5{
            // Step View
            cell.addSubview(contentScene.setStepViewLayout(stepNum:3, isComplete:isStandardPasted, height:contentScene.cellHeights[indexPath.row].height))
            
            // Text View
            cell.addSubview(contentScene.standardTextView)
            if dataFlow?.contentStandard != ""{
                contentScene.standardTextView.textColor = .black
                contentScene.standardTextView.text = dataFlow!.contentStandard
            }else{
                contentScene.standardTextView.textColor = .lightGray
                contentScene.standardTextView.text = "Paste the Standard Here"
            }
            contentScene.standardTextView.delegate = self
            contentScene.setStandardTextViewLayout(height: contentScene.cellHeights[indexPath.row].height, view:self.view)
            contentScene.standardTextView.addTwoBarButtons(leftTitle: "Paste", rightTitle: "Done",target: self, leftSelector: #selector(tabPaste), rightSelector: #selector(tapDone))
            if !ContentStandardViewController.isRemindered {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(textViewTapped))
                cell.addGestureRecognizer(tapGesture)
                contentScene.standardTextView.isUserInteractionEnabled = false
            }
        }
        return cell
    }
}

// MARK: SFSafariViewController Delegate
extension ContentStandardViewController: SFSafariViewControllerDelegate{
    func safariViewControllerDidFinish(_: SFSafariViewController){
        backFromWeb = true
        let pb: UIPasteboard = UIPasteboard.general
        if pasteValue == pb.string && contentScene.standardTextView.text == ""{
            contentScene.standardTextView.text = pasteValue
        }
        if pasteValue != pb.string ?? ""{
            if contentScene.standardTextView.text == "Paste the Standard Here"{
                contentScene.standardTextView.text = ""
            }
            if contentScene.standardTextView.text != ""{
                 contentScene.standardTextView.text += "\n"
            }
            contentScene.standardTextView.text += pb.string ?? ""
            contentScene.standardTextView.textColor = .black
            dataFlow?.contentStandard = contentScene.standardTextView.text
            updateCollectionViewAndTitleViewfromModel(from: dataFlow!, to: mainTableView)
            isStandardPasted = true
            for recognizer in mainTableView.cellForRow(at: IndexPath(row: 4, section: 0))?.gestureRecognizers ?? [] {
                mainTableView.cellForRow(at: IndexPath(row: 4, section: 0))!.removeGestureRecognizer(recognizer)
            }
            ContentStandardViewController.isRemindered = true
            contentScene.standardTextView.isUserInteractionEnabled = true
        }
        saveCurrentJsonDataToDiskAndBroadcastReminderUpdating(dataFlow:dataFlow, animated: true)
    }
}

// MARK: Text View Delegation
extension ContentStandardViewController:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView){
        if textView.text == "Paste the Standard Here"{
            for recognizer in mainTableView.cellForRow(at: IndexPath(row: 5, section: 0))?.gestureRecognizers ?? [] {
                mainTableView.cellForRow(at: IndexPath(row: 5, section: 0))!.removeGestureRecognizer(recognizer)
            }
            contentScene.standardTextView.isUserInteractionEnabled = true
            textView.text = ""
            textView.textColor = .black
        }
        isStandardPasted = true
        (mainTableView.cellForRow(at: IndexPath(item: 5, section: 0))?.subviews[1] as! Step).isComplete = true
    }
    func textViewDidChange(_ textView: UITextView) {
        dataFlow?.contentStandard = textView.text
        updateCollectionViewAndTitleViewfromModel(from: dataFlow!, to: mainTableView)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        saveCurrentJsonDataToDiskAndBroadcastReminderUpdating(dataFlow:dataFlow, animated: true)
        if textView.text == ""{
            textView.textColor = .lightGray
            textView.text = "Paste the Standard Here"
        }
    }
}

// MARK: Functions
extension ContentStandardViewController{
    private func updateCellHeights(){
        if self.view.frame.width > self.view.frame.height{
            // landscape
            // not ipad
            if traitCollection.horizontalSizeClass != .regular || traitCollection.verticalSizeClass != .regular{
                // 如果不是 ipad， 就把 roadmap 充满整个屏幕
                contentScene.cellHeights[0].height = self.view.frame.height - safeTop - navHeight - safeBottom - bottomViewFrame.height
            }else{
                // 如果是 ipad， landscape 500 足以
                contentScene.cellHeights[0].height = 500
            }
        }else{
            // Portrait
            // ipad only
            if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular{
                // 如果是 ipad， 就放大一点， 500 足以
                contentScene.cellHeights[0].height = 500
            }else{
                contentScene.cellHeights[0].height = 250
            }
        }
    }
    private func createObservers(){
        let name = Notification.Name(rawValue:NotificationName.broadcastToReloadReminderAndTitle.rawValue)
        NotificationCenter.default.addObserver(self, selector: #selector(updateDataflow), name:name, object: nil)
        
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [unowned self] notification in
            // 防止 present singleton instance 后 viewcontroller navigation bar 变色的问题
            // reset Navigation Bar
            self.setNavigationBar(title: "Content\nStandard")
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
                collectionView.scrollToItem(at:IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }
    @objc func questionMarkTapped(recognizer: UIGestureRecognizer){
        if recognizer.view!.tag == 0{
            animatedIn(self.setBlurView())
            animatedIn(self.setPopView(title: contentModel.popupTitleOnRoadMap, content:contentModel.popupContentOnRoadMap, textAlignment: .center))
        }else if recognizer.view!.tag == 1{
            animatedIn(self.setBlurView())
            animatedIn(self.setPopView(title: contentModel.popupTitleOnWhat[0], content:contentModel.popupContentOnWhat[0], title2:contentModel.popupTitleOnWhat[1], content2:contentModel.popupContentOnWhat[1], textAlignment: .justified))
        }else if recognizer.view!.tag == 2{
            animatedIn(self.setBlurView())
            animatedIn(self.setPopView(title: contentModel.popupTitleNextToPercentage, content:dataFlow!.wholeState, textAlignment: .left))
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
    @objc func tapDone(){
        self.view.endEditing(true)
    }
    @objc func tabPaste(){
        if contentScene.standardTextView.text == "Paste the Standard Here"{
            contentScene.standardTextView.text = ""
        }
        let pb: UIPasteboard = UIPasteboard.general
        contentScene.standardTextView.text += pb.string ?? ""
        contentScene.standardTextView.textColor = .black
        isStandardPasted = true
        dataFlow?.contentStandard = contentScene.standardTextView.text
//        (mainTableView.cellForRow(at: IndexPath(item: 4, section: 0))?.subviews[1] as! Step).isComplete = true
    }
    @objc func linkButtonClicked(){
        print("linkButtonClicked")
        ContentStandardViewController.isRemindered = true
        isLinkClicked = true
        mainTableView.reloadData()
        for recognizer in mainTableView.cellForRow(at: IndexPath(row: 5, section: 0))?.gestureRecognizers ?? [] {
            mainTableView.cellForRow(at: IndexPath(row: 5, section: 0))!.removeGestureRecognizer(recognizer)
        }
        contentScene.standardTextView.isUserInteractionEnabled = true
        // clean the paste info
        let pb: UIPasteboard = UIPasteboard.general
        pasteValue = pb.string ?? ""
        let safari = SFSafariViewController(url: URL(string: "http://www.hawaiipublicschools.org/TeachingAndLearning/StudentLearning/Pages/standards.aspx")!)
        safari.preferredBarTintColor = #colorLiteral(red: 0.5490196078, green: 0, blue: 0.05490196078, alpha: 1)
        safari.view.backgroundColor = .white
        safari.preferredControlTintColor = .white
        safari.delegate = self
        //safari.modalPresentationStyle = .custom
        present(safari, animated: true, completion: nil)
    }
    @objc func textViewTapped(){
        ContentStandardViewController.isRemindered = true
        mainTableView.reloadData()
        animatedIn(self.setBlurView())
        animatedIn(self.setPopView(title: "Reminder", content:"Try not to write the standard driectly.\nYou should copy the standard from the purple link, and then paste it here.", textAlignment: .center))
        for recognizer in mainTableView.cellForRow(at: IndexPath(row: 4, section: 0))?.gestureRecognizers ?? [] {
            mainTableView.cellForRow(at: IndexPath(row: 4, section: 0))!.removeGestureRecognizer(recognizer)
        }
         contentScene.standardTextView.isUserInteractionEnabled = true
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
extension ContentStandardViewController{
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
            return
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
        contentScene.objectivestv.addGestureRecognizer(objectivesGesture)
        let contentGesture = UITapGestureRecognizer(target: self, action: #selector(contentTyped))
        contentScene.contenttv.addGestureRecognizer(contentGesture)
        let summativeGesture = UITapGestureRecognizer(target: self, action: #selector(summativeTyped))
        contentScene.summativetv.addGestureRecognizer(summativeGesture)
        let anticipatoryGesture = UITapGestureRecognizer(target: self, action: #selector(anticipatoryTyped))
        contentScene.anticipatorytv.addGestureRecognizer(anticipatoryGesture)
        let closureGesture = UITapGestureRecognizer(target: self, action: #selector(closureTyped))
        contentScene.closuretv.addGestureRecognizer(closureGesture)
        let instructionGesture = UITapGestureRecognizer(target: self, action: #selector(instructionTyped))
        contentScene.instructiontv.addGestureRecognizer(instructionGesture)
        let backgroundGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTyped))
        contentScene.backgroundtv.addGestureRecognizer(backgroundGesture)
        let lessonGesture = UITapGestureRecognizer(target: self, action: #selector(lessonTyped))
        contentScene.lessontv.addGestureRecognizer(lessonGesture)
    }
}


