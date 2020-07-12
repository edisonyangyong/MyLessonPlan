//
//  ObjectivesViewController.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 4/19/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit
import GearRefreshControl

class ObjectivesViewController: UIViewController {
    var dataFlow:Model?
    var model = Model()
    var objectiveModel = ObjectiveModel()
    var objectiveScene = ObjectiveScene()
    let transition = Icon_view_transition()
    var sequenceTyped: Sequecne = .main
    private var currentSelect = ""
    private let verbTable = UITableView()
    private var currentTabedObjective = 0
    private let leftOutcomeContentView = UIView()
    private lazy var mainTableView = addAndGetMainTableView()
    private lazy var gearRefreshControl = GearRefreshControl(frame: self.view.bounds)
    private var firstVC:SubObjectiveViewController?
    private var secondVC:SubObjectiveViewController?
    let tabController = UITabBarController()
    static let objectivesViewControllerInstance = ObjectivesViewController()
    private var isRotated = false
    private var shouldAnimate = false
    static var isVisited = false
    private var continueButton = UIButton()
    
   deinit{
         NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
        // Navigation Bar
        self.setNavigationBar(title: "Learning\nObjectives")
        self.addBackNaviButton(title: "Back")
        
        self.title = "ObjectivesViewController"
        createObservers()
        updateCellHeights()
        addBottomView()
        addAndGetPDFButton().addTarget(self, action: #selector(pdfButtonClicked), for: .touchUpInside)
        if dataFlow?.summativeAssessment == "" {
            self.continueButton = addAndGetContinueButton(title:"Save and Continue to\nSummative Assessment →")
        }else{
            self.continueButton = addAndGetContinueButton(title:"Save and Continue to\nAnticipatory Set →")
        }
        self.continueButton.addTarget(self, action: #selector(continueButtonClicked), for: .touchUpInside)
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
            self.isRotated = true
            self.updateCellHeights()
            self.mainTableView.setContentOffset(.zero, animated:true)
            // 防止 present singleton instance 后 viewcontroller navigation bar 变色的问题
            // reset Navigation Bar
            self.setNavigationBar(title: "Learning\nObjectives")
            self.addBackNaviButton(title: "Back")
            self.mainTableView.reloadData()
        })
        super.viewWillTransition(to: size, with: coordinator)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // check continue button title
        if  dataFlow?.summativeAssessment == "" {
            self.continueButton.setTitle("Save and Continue to\nSummative Assessment →", for: .normal)
        }else{
            self.continueButton.setTitle("Save and Continue to\nAnticipatory Set →", for: .normal)
        }
        self.mainTableView.setContentOffset(.zero, animated:true)
        // 防止 present singleton instance 后 viewcontroller navigation bar 变色的问题
        // reset Navigation Bar
        self.setNavigationBar(title: "Learning\nObjectives")
        self.addBackNaviButton(title: "Back")
        self.mainTableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // showfocuseLinkBlurView
        if dataFlow!.learningObjectiveOne == "" && dataFlow!.learningObjectiveTwo == ""{
            // check whether community cell is complete visible
            let cellRect = mainTableView.rectForRow(at: IndexPath(row: 4, section: 0))
            let completelyVisible = mainTableView.bounds.contains(cellRect)
            if completelyVisible{
                // show hint animation
                objectiveScene.showfocuseLinkBlurView(view:self.view)
            }else{
                mainTableView.scrollToRow(at: IndexPath(row: 4, section: 0), at: .top, animated: true)
                shouldAnimate = true
            }
        }
    }
}

//MARK: Delegation
extension ObjectivesViewController:ObjectiveDataFlowUpdatingDelegation{
    func updateDataFlowFromSubObjective(viewController vc: SubObjectiveViewController, from endObjectiveText: String) {
        if vc.view.tag == 0 {
            dataFlow?.learningObjectiveOne = endObjectiveText
            updateCollectionViewAndTitleViewfromModel(from: dataFlow!, to: mainTableView)
        }else if vc.view.tag == 1{
            dataFlow?.learningObjectiveTwo = endObjectiveText
            updateCollectionViewAndTitleViewfromModel(from: dataFlow!, to: mainTableView)
        }
    }
    func saveToDiskAndUpdateReminer(){
        saveCurrentJsonDataToDiskAndBroadcastReminderUpdating(dataFlow:dataFlow, animated: true)
    }
}

extension ObjectivesViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataFlow!.reminderTitle.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ReminderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReminderCollectionViewCell", for: indexPath) as! ReminderCollectionViewCell
        cell.titleLabel.text = dataFlow!.reminderTitle[indexPath.item]
        if indexPath.item == 2{
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
        return CGSize(width: 300, height: objectiveScene.cellHeights[2].height*0.9)
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

extension ObjectivesViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        gearRefreshControl.scrollViewDidScroll(scrollView)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
        self.gearRefreshControl.endRefreshing()
    }
}

extension ObjectivesViewController:UITableViewDelegate,UITableViewDataSource{
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if shouldAnimate{
            objectiveScene.showfocuseLinkBlurView(view:self.view)
            shouldAnimate = false
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == mainTableView{
            return objectiveScene.cellHeights.count
        }else if tableView == verbTable{
            switch currentSelect {
            case "Analysis":
                return objectiveModel.verbs["Analysis"]!.count
            case "Application":
                return objectiveModel.verbs["Application"]!.count
            case "Comprehension":
                return objectiveModel.verbs["Comprehension"]!.count
            case "Knowledge":
                return objectiveModel.verbs["Knowledge"]!.count
            case "Synthesis":
                return objectiveModel.verbs["Synthesis"]!.count
            case "Evaluation":
                return objectiveModel.verbs["Evaluation"]!.count
            default:
                return objectiveModel.verbs["Analysis"]!.count
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if tableView == mainTableView{
            for i in 0..<objectiveScene.cellHeights.count{
                if indexPath.row == i{
                    return objectiveScene.cellHeights[i].height
                }
            }
        }else if tableView == verbTable{
            return 44
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableView == mainTableView{
            cell.backgroundColor = UIColor.byuHlightGray
            cell.selectionStyle = .none
            if indexPath.row == 0{
                let row = 0
                // Road Map
                cell.addSubview(objectiveScene.roadMap)
                objectiveScene.setRoadMapLayout(height: objectiveScene.cellHeights[row].height, to: cell, view:self.view)
                setUpTabViews()
                setAnimatedChose(to: cell)
                let tap = UITapGestureRecognizer(target: self, action: #selector(questionMarkTapped))
                setAndGetQuestionMarkOnRoadMap(to: cell).addGestureRecognizer(tap)
            }else if indexPath.row == 1{
                let row = 1
                // Curve
                cell.addSubview(objectiveScene.curve)
                objectiveScene.setCurveLayout(height: objectiveScene.cellHeights[row].height, view:self.view)
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
               reminder.scrollToItem(at: IndexPath(item: 2, section: 0), at: .centeredHorizontally, animated: false)
            }else if indexPath.row == 3{
                let row = 3
                // Title & Question Mark
                cell.addSubview(objectiveScene.titleView)
                objectiveScene.setTitleViewLayout(height: objectiveScene.cellHeights[row].height, view:self.view)
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(questionMarkTapped))
                objectiveScene.questionMark.addGestureRecognizer(tapGesture)
            }else if indexPath.row == 4{
                let row = 4
                // Right Verb View
                objectiveScene.rightVerbView.frame = CGRect(x: safeLeft+3*sdGap+(self.view.frame.width-safeLeft-safeRight-5*sdGap)*3/4, y: 0, width: (self.view.frame.width-safeLeft-safeRight-5*sdGap)/4, height: objectiveScene.cellHeights[row].height)
                cell.addSubview(objectiveScene.rightVerbView)
    
                // VerbPicker
                let verbPickerView = UIPickerView()
                verbPickerView.frame = CGRect(x: objectiveScene.rightVerbView.frame.minX, y: objectiveScene.rightVerbView.frame.minY, width: objectiveScene.rightVerbView.frame.width, height: objectiveScene.rightVerbView.frame.height/4)
                verbPickerView.backgroundColor = #colorLiteral(red: 0.00213491777, green: 0.2139303088, blue: 0.3914119005, alpha: 1)
                verbPickerView.delegate = self
                cell.addSubview(verbPickerView)
                
                // Verb Table View
                verbTable.frame = CGRect(x: verbPickerView.frame.minX, y: verbPickerView.frame.maxY, width: verbPickerView.frame.width, height: (objectiveScene.rightVerbView.frame.height*3/4)-6)
                verbTable.backgroundColor = #colorLiteral(red: 0.008816614747, green: 0.3569524586, blue: 0.7242920995, alpha: 1)
                verbTable.delegate = self
                verbTable.dataSource = self
                verbTable.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
                cell.addSubview(verbTable)
                
                // Left Outcomes View
                leftOutcomeContentView.frame = CGRect(x: 2*sdGap+safeLeft, y: 0, width: self.view.frame.width-5*sdGap-objectiveScene.rightVerbView.frame.width-safeLeft-safeRight, height: objectiveScene.cellHeights[row].height)
                leftOutcomeContentView.backgroundColor = UIColor.byuHlightGray
                cell.addSubview(leftOutcomeContentView)
                
                // Animated Rect
                if dataFlow!.learningObjectiveOne == "" && dataFlow!.learningObjectiveTwo == "" && !isRotated{
                    objectiveScene.animatedRect.frame = objectiveScene.rightVerbView.frame
                    cell.addSubview(objectiveScene.animatedRect)
                    UIView.animate(
                        withDuration: 2,
                        delay: 3.5,
                        options: [.allowUserInteraction],
                        animations: {
                            let temp = self.sdGap+13+(self.leftOutcomeContentView.frame.width-30)*2/3
                            self.objectiveScene.animatedRect.frame = CGRect(
                                x: temp + self.safeLeft,
                                y: 50 + 17,
                                width: self.leftOutcomeContentView.frame.width/3+7+self.sdGap,
                                height: ((self.leftOutcomeContentView.frame.height-40.0-17*3)/4)/3)
                    }
                    )
                }else{
                    let temp = self.sdGap+13+(self.leftOutcomeContentView.frame.width-30)*2/3
                    objectiveScene.animatedRect.frame = CGRect(
                        x: temp + self.safeLeft,
                        y: 50 + 17,
                        width: self.leftOutcomeContentView.frame.width/3+7+self.sdGap,
                        height: ((self.leftOutcomeContentView.frame.height-40.0-17*3)/4)/3)
                    cell.addSubview(objectiveScene.animatedRect)
                }
                
                // Embeded ViewController
                tabController.delegate = self
                tabController.view.frame = CGRect(x: 0, y: 0, width: leftOutcomeContentView.frame.width, height: objectiveScene.cellHeights[row].height)
                tabController.view.backgroundColor = UIColor.byuHlightGray
                tabController.tabBar.barTintColor = UIColor.byuhMidGray
                self.addChild(tabController)
                leftOutcomeContentView.addSubview(tabController.view)
                tabController.didMove(toParent: self)
                
                // Tab bar
                let item1 = UITabBarItem(title: "Objective 1", image: UIImage(named: "logo_Unselect")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "AppIcon"))
                let item2 = UITabBarItem(title: "Objective 2", image: UIImage(named: "logo_Unselect")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "AppIcon"))
                let selectedColor   =  UIColor.byuHRed
                let unselectedColor = UIColor.byuHlightGray
                UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
                UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
                
//                if isRotated || firstVC == nil{
//                    firstVC = SubObjectiveViewController()
//                    secondVC = SubObjectiveViewController()
//                    isRotated = false
//                }
                firstVC = SubObjectiveViewController()
                secondVC = SubObjectiveViewController()
                firstVC!.delegate = self
                secondVC!.delegate = self
                firstVC!.tabBarItem = item1
                secondVC!.tabBarItem = item2
                firstVC!.subContentWidth = leftOutcomeContentView.frame.width
                firstVC!.subContentHeight = leftOutcomeContentView.frame.height
                firstVC!.objectiveData = dataFlow!.learningObjectiveOne
                secondVC!.subContentWidth = leftOutcomeContentView.frame.width
                secondVC!.subContentHeight = leftOutcomeContentView.frame.height
                secondVC!.objectiveData = dataFlow!.learningObjectiveTwo
                firstVC!.view.tag = 0
                secondVC!.view.tag = 1
                tabController.viewControllers = [firstVC!, secondVC!]
            }
        }else if tableView == verbTable{
            cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
            cell.backgroundColor = #colorLiteral(red: 0.008816614747, green: 0.3569524586, blue: 0.7242920995, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: sdFontSize)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            switch currentSelect {
            case "Analysis":
                cell.textLabel?.text = objectiveModel.verbs["Analysis"]![indexPath.row]
            case "Application":
                cell.textLabel?.text = objectiveModel.verbs["Application"]![indexPath.row]
            case "Comprehension":
                cell.textLabel?.text = objectiveModel.verbs["Comprehension"]![indexPath.row]
            case "Knowledge":
                cell.textLabel?.text = objectiveModel.verbs["Knowledge"]![indexPath.row]
            case "Synthesis":
                cell.textLabel?.text = objectiveModel.verbs["Synthesis"]![indexPath.row]
            case "Evaluation":
                cell.textLabel?.text = objectiveModel.verbs["Evaluation"]![indexPath.row]
            default:
                cell.textLabel?.text = objectiveModel.verbs["Analysis"]![indexPath.row]
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if tableView == verbTable{
            objectiveScene.animatedRect.layer.removeAllAnimations()
            var selectedVerb = ""
            switch currentSelect {
            case "Analysis":
                selectedVerb = objectiveModel.verbs["Analysis"]![indexPath.row]
            case "Application":
                selectedVerb = objectiveModel.verbs["Application"]![indexPath.row]
            case "Comprehension":
                selectedVerb = objectiveModel.verbs["Comprehension"]![indexPath.row]
            case "Knowledge":
                selectedVerb = objectiveModel.verbs["Knowledge"]![indexPath.row]
            case "Synthesis":
                selectedVerb = objectiveModel.verbs["Synthesis"]![indexPath.row]
            case "Evaluation":
                selectedVerb = objectiveModel.verbs["Evaluation"]![indexPath.row]
            default:
                selectedVerb = objectiveModel.verbs["Analysis"]![indexPath.row]
            }
            if currentTabedObjective == 0{
                firstVC!.getVerb(selected: selectedVerb)
            }else{
                secondVC!.getVerb(selected: selectedVerb)
            }
        }
        saveCurrentJsonDataToDiskAndBroadcastReminderUpdating(dataFlow: dataFlow, animated: true)
    }
}

// MARK: Picker Delegation
extension ObjectivesViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return objectiveModel.verbs.keys.count
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var list = [String](objectiveModel.verbs.keys)
        list.sort{$0 < $1}
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: sdFontSize)
        label.text =  list[row]
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        var list = [String](objectiveModel.verbs.keys)
        list.sort{$0 < $1}
        currentSelect = list[row]
        verbTable.reloadData()
    }
}

// MARK: Tab Bar Delegation
extension ObjectivesViewController:UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        currentTabedObjective = viewController.view.tag
    }
}
extension UITabBarController{
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:  self.tabBar.frame.height)
    }
}

// MARK: Functions
extension ObjectivesViewController{
    private func updateCellHeights(){
        if self.view.frame.width > self.view.frame.height{
            // landscape
            // not ipad
            if traitCollection.horizontalSizeClass != .regular || traitCollection.verticalSizeClass != .regular{
                // 如果不是 ipad， 就把 roadmap 充满整个屏幕
                objectiveScene.cellHeights[0].height = self.view.frame.height - safeTop - navHeight - safeBottom - bottomViewFrame.height
            }else{
                // 如果是 ipad， landscape 500 足以
                objectiveScene.cellHeights[0].height = 500
            }
        }else{
            // Portrait
            // ipad only
            if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular{
                // 如果是 ipad， 就放大一点， 500 足以
                objectiveScene.cellHeights[0].height = 500
            }else{
                objectiveScene.cellHeights[0].height = 250
            }
        }
    }
    private func createObservers(){
        let name = Notification.Name(rawValue:NotificationName.broadcastToReloadReminderAndTitle.rawValue)
        NotificationCenter.default.addObserver(self, selector: #selector(updateDataflow), name:name, object: nil)
        
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [unowned self] notification in
            // 防止 present singleton instance 后 viewcontroller navigation bar 变色的问题
            // reset Navigation Bar
            self.setNavigationBar(title: "Learning\nObjectives")
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
                collectionView.scrollToItem(at:IndexPath(item: 2, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }
    @objc func questionMarkTapped(recognizer: UIGestureRecognizer){
        if recognizer.view!.tag == 0{
            animatedIn(self.setBlurView())
            animatedIn(self.setPopView(title: objectiveModel.popupTitleOnRoadMap, content:objectiveModel.popupContentOnRoadMap, textAlignment: .center))
        }else if recognizer.view!.tag == 1{
            animatedIn(self.setBlurView())
            animatedIn(self.setPopView(title: objectiveModel.popupTitleOnWhat[0], content:objectiveModel.popupContentOnWhat[0],title2: objectiveModel.popupTitleOnWhat[1], content2:objectiveModel.popupContentOnWhat[1], textAlignment: .justified))
        }else if recognizer.view!.tag == 2{
            animatedIn(self.setBlurView())
            animatedIn(self.setPopView(title: objectiveModel.popupTitleNextToPercentage, content:dataFlow!.wholeState, textAlignment: .left))
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
        if  dataFlow?.summativeAssessment == "" {
            sequenceTyped = .summative
            let vc = SummativeViewController.summativeViewControllerInstance
            vc.dataFlow = dataFlow
            SummativeViewController.isVisited = true
            let nc = UINavigationController(rootViewController: vc)
            #if !targetEnvironment(macCatalyst)
            nc.transitioningDelegate = self
            nc.modalPresentationStyle = .custom
            #else
            nc.modalPresentationStyle = .fullScreen
            #endif
            present(nc, animated: true, completion: nil)
        }else{
            sequenceTyped = .anticipatory
            let vc = AnticipatoryViewController.anticipatoryViewControllerInstance
            vc.dataFlow = dataFlow
            AnticipatoryViewController.isVisited = true
            let nc = UINavigationController(rootViewController: vc)
            #if !targetEnvironment(macCatalyst)
            nc.transitioningDelegate = self
            nc.modalPresentationStyle = .custom
            #else
            nc.modalPresentationStyle = .fullScreen
            #endif
            present(nc, animated: true, completion: nil)
        }
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
extension ObjectivesViewController{
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
            return
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
        objectiveScene.objectivestv.addGestureRecognizer(objectivesGesture)
        let contentGesture = UITapGestureRecognizer(target: self, action: #selector(contentTyped))
        objectiveScene.contenttv.addGestureRecognizer(contentGesture)
        let summativeGesture = UITapGestureRecognizer(target: self, action: #selector(summativeTyped))
        objectiveScene.summativetv.addGestureRecognizer(summativeGesture)
        let anticipatoryGesture = UITapGestureRecognizer(target: self, action: #selector(anticipatoryTyped))
        objectiveScene.anticipatorytv.addGestureRecognizer(anticipatoryGesture)
        let closureGesture = UITapGestureRecognizer(target: self, action: #selector(closureTyped))
        objectiveScene.closuretv.addGestureRecognizer(closureGesture)
        let instructionGesture = UITapGestureRecognizer(target: self, action: #selector(instructionTyped))
        objectiveScene.instructiontv.addGestureRecognizer(instructionGesture)
        let backgroundGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTyped))
        objectiveScene.backgroundtv.addGestureRecognizer(backgroundGesture)
        let lessonGesture = UITapGestureRecognizer(target: self, action: #selector(lessonTyped))
        objectiveScene.lessontv.addGestureRecognizer(lessonGesture)
    }
}

