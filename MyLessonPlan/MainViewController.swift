//
//  MainViewController.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 4/9/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit
import GearRefreshControl
import MobileCoreServices
import PDFKit

class MainViewController: UIViewController{
    // MARK: Global Var
    private var mainModel = MainModel()
    var mainScene = MainScene()
    let transition = Icon_view_transition()
    var sequenceTyped: Sequecne = .main
    private lazy var mainTableView = addAndGetMainTableView()
    private lazy var gearRefreshControl = GearRefreshControl(frame: self.view.bounds)
    var dataFlow: Model?
    private var pdfData:Data?
    private lazy var numOfRows = 0
    private lazy var numOfCols = 0
    private var barWidth = CGFloat(0)
    private var shouldAnimate = false
    
    #if targetEnvironment(macCatalyst)
        var hasDisabledZoom = false
    #endif
    
    deinit{
         NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.title = "MainViewController"
        
        #if targetEnvironment(macCatalyst)
        if !hasDisabledZoom {
            hasDisabledZoom = true
            CatalystAppManager.configureMacAppWindow()
        }
        #endif
        
        updateCellHeights()
        createObservers()
        mainScene.barWidth = self.barWidth
        
        // Navigation Bar
        self.setNavigationBar(title: mainModel.navTilte)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "About",
            style: .done,
            target: self,
            action: #selector(aboutClicked))
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        addBottomView()
        addAndGetPDFButton().addTarget(self, action: #selector(pdfButtonClicked), for: .touchUpInside)
        addAndGetContinueButton(title:mainModel.continueButtonTitle).addTarget(self, action: #selector(continueButtonClicked), for: .touchUpInside)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
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
            self.mainTableView.reloadData()
        })
        super.viewWillTransition(to: size, with: coordinator)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if dataFlow == nil{
            dataFlow = Model()
        }
        // read data from disk
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ).appendingPathComponent("MyCurrentLessonPlanBackUp.json"){
            if let jsonData = try? Data(contentsOf: url){
                print(">>>>>>>>>>>>>>>>>>> Backup File Loaded Successfully ")
                self.dataFlow?.jsonModel = JsonModel(json: jsonData)!
                self.dataFlow?.convertJsonModelToRegularModel()
            }
        }
        self.mainTableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // check whether community cell is complete visible
        let cellRect = mainTableView.rectForRow(at: IndexPath(row: 5, section: 0))
        let completelyVisible = mainTableView.bounds.contains(cellRect)
        if completelyVisible{
            // show hint animation
            mainScene.showfocuseCommunityBlurView(view:self.view,barWidth:barWidth)
        }else{
            mainTableView.scrollToRow(at: IndexPath(row: 4, section: 0), at: .top, animated: true)
        }
        shouldAnimate = true
    }
}

//MARK: Delegation
extension MainViewController:UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        mainScene.setpdfViewLayout(to:self.view)
        mainScene.pdfView.isHidden = false
        
         // Read a PDF
        let url = urls.first
        if let pdfDocument = PDFDocument(url: url!){
            mainScene.pdfView.autoScales = true
            mainScene.pdfView.displayMode = .singlePageContinuous
            mainScene.pdfView.displayDirection = .vertical
            mainScene.pdfView.document = pdfDocument
            self.pdfData  = NSData(contentsOf: url!) as Data?
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
        title: "Back",
        style: .done,
        target: self,
        action: #selector(backFromPDF))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
        title: "Export",
        style: .done,
        target: self,
        action: #selector(PDFexport))
    }
}
extension MainViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        gearRefreshControl.scrollViewDidScroll(scrollView)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
        self.gearRefreshControl.endRefreshing()
    }
}

extension MainViewController:UITableViewDelegate,UITableViewDataSource{
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if shouldAnimate{
            mainScene.showfocuseCommunityBlurView(view:self.view,barWidth:barWidth)
            shouldAnimate = false
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainScene.cellHeights.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        for i in 0..<mainScene.cellHeights.count{
            if indexPath.row == i{
                return mainScene.cellHeights[i].height
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewTableViewCell") as! MainViewTableViewCell
        let cell = UITableViewCell()
        cell.frame.size.width = self.view.frame.width
        cell.backgroundColor = UIColor.byuHlightGray
        cell.selectionStyle = .none
        if indexPath.row == 0{
            let row = 0
            // Road Map
            cell.addSubview(mainScene.roadMap)
            mainScene.setRoadMapLayout(height: mainScene.cellHeights[row].height, to: cell)
            setUpTabViews()
            setAnimatedChose(to: cell)
        }else if indexPath.row == 1{
            // Curve
            cell.addSubview(mainScene.curve)
            mainScene.setCurveLayout(height: mainScene.cellHeights[indexPath.row].height, view:self.view)
            cell.backgroundColor = UIColor.byuHRed
            // Question Mark
            cell.addSubview(mainScene.questionMark)
            mainScene.setQuestionMarkLayout(safeRight: safeLeft, view:self.view, markSize: sdQuestionMarkSize)
            mainScene.questionMark.addTarget(self, action: #selector(questionButtonClicked), for: .touchUpInside)
        }else if indexPath.row == 2{
            // Logo
            cell.addSubview(mainScene.logo)
            mainScene.setLogoLayout(height: mainScene.cellHeights[indexPath.row].height, view: self.view)
        }else if indexPath.row == 3{
            // Aloha Label
            cell.addSubview(mainScene.alohaHint)
            mainScene.setAlohaHintLayout(height: mainScene.cellHeights[indexPath.row].height, view:self.view)
        }else if indexPath.row == 4{
            // Optional Label
            cell.addSubview(mainScene.optionalHint)
            mainScene.setOptionalHintLayout(height: mainScene.cellHeights[indexPath.row].height, view:self.view)
        }else if indexPath.row == 5{
            cell.addSubview(mainScene.newCreatView)
            let createTap = UITapGestureRecognizer(target: self, action: #selector(createButtonClicked))
            mainScene.newCreatView.addGestureRecognizer(createTap)
            cell.addSubview(mainScene.newInspireView)
            let inspireTap = UITapGestureRecognizer(target: self, action: #selector(communityButtonClicked))
            mainScene.newInspireView.addGestureRecognizer(inspireTap)
            if mainScene._newInspireView != nil{
                 mainScene._newInspireView!.addGestureRecognizer(inspireTap)
            }
            cell.addSubview(mainScene.newRestoreView)
            let restoreTap = UITapGestureRecognizer(target: self, action: #selector(restoreButtonClicked))
            mainScene.newRestoreView.addGestureRecognizer(restoreTap)
            cell.addSubview(mainScene.newBrowseView)
            let browseTap = UITapGestureRecognizer(target: self, action: #selector(browseButtonClicked))
            mainScene.newBrowseView.addGestureRecognizer(browseTap)
            if numOfRows == 1{
                mainScene.setBlocksLayoutForOneLine(to: cell, barWidth:barWidth)
            }else{
                 mainScene.setBlocksLayoutForTwoLine(to: cell, barWidth:barWidth)
            }
            mainScene.setBlockLayout(barWidth:barWidth)
        }
        return cell
    }
}

// MARK: Functions
extension MainViewController{
    private func createObservers(){
         let name = Notification.Name(rawValue:NotificationName.notifyMainViewToUpdateDataFlow.rawValue)
         NotificationCenter.default.addObserver(self, selector: #selector(updateDataflow), name:name, object: dataFlow)
    }
    @objc private func updateDataflow(notification:NSNotification){
         self.dataFlow = (notification.object as! Model)
         print(">>>>>>>>>>>>>>>>>>> Main View Got Notificed")
    }
    private func updateCellHeights(){
        if self.view.frame.width > self.view.frame.height{
            // landscape
            numOfCols = 4
            numOfRows = 1
            barWidth = (self.view.frame.width-safeRight-safeLeft)*2/13
            mainScene.cellHeights[5].height = sdGap+barWidth+sdGap
            // not ipad
            if traitCollection.horizontalSizeClass != .regular || traitCollection.verticalSizeClass != .regular{
                // 如果不是 ipad， 就把 roadmap 充满整个屏幕
                 mainScene.cellHeights[0].height = self.view.frame.height - safeTop - navHeight - safeBottom - bottomViewFrame.height
            }else{
                // 如果是 ipad， landscape 400 足以
                 mainScene.cellHeights[0].height = 400
            }
        }else{
            // Portrait
            // ipad only
            if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular{
                // 如果是 ipad， 就放大一点， 400 足以
                mainScene.cellHeights[0].height = 400
            }else{
                mainScene.cellHeights[0].height = 250
            }
            if traitCollection.horizontalSizeClass == .regular{
                numOfCols = 4
                numOfRows = 1
                barWidth = (self.view.frame.width-safeRight-safeLeft)*2/13
                mainScene.cellHeights[5].height = sdGap+barWidth+sdGap
            }else{
                numOfCols = 2
                numOfRows = 2
                barWidth = (self.view.frame.width-safeRight-safeLeft)*2/7
                mainScene.cellHeights[5].height = sdGap+2*barWidth+barWidth/2
            }
        }
//        print("numOfCols: \(numOfCols), numOfRows: \(numOfRows)")
    }
    @objc func aboutClicked(){
        let vc = AboutViewController()
        #if targetEnvironment(macCatalyst)
            let nc = UINavigationController(rootViewController: vc)
            nc.modalPresentationStyle = .overFullScreen
            self.present(nc, animated: true, completion: nil)
        #else
            let nc = UINavigationController(rootViewController: vc)
            sequenceTyped = .main
            nc.transitioningDelegate = self
            nc.modalPresentationStyle = .custom
            present(nc, animated: true, completion: nil)
        #endif
    }
    @objc func PDFexport(){
        #if targetEnvironment(macCatalyst)
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent("myLessonPlan.pdf")
            do {
                try pdfData?.write(to: fileURL)
                animatedIn(self.setBlurView())
                animatedIn(self.setPopView(title: "Download Successful!", content:"Your lesson plan PDF file is now at  \(fileURL).\n\nType myLessonPlan.pdf in Command–Space bar to find the file.", textAlignment: .center))
            }
            catch {print("error")}
        }
        #else
        let activityViewController = UIActivityViewController(activityItems: [self.pdfData as Any], applicationActivities: nil)
        present(activityViewController,animated: true)
        #endif
    }
    @objc func backFromPDF(){
        mainScene.pdfView.isHidden = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "About",
            style: .done,
            target: self,
            action: #selector(aboutClicked))
        
        self.navigationItem.rightBarButtonItem = nil
    }
    @objc func browseButtonClicked(_ : UIButton){
        #if !targetEnvironment(macCatalyst)
        let documentPicker = UIDocumentPickerViewController(documentTypes:[String(kUTTypePDF)], in: .open)
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            documentPicker.directoryURL = dir
        }
        
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
        #else
        animatedIn(self.setBlurView())
        animatedIn(self.setPopView(title: "Opps!", content:"Sorry, this functionality is now only supported on IPhone or IPad Devices.\n Please type myLessonPlan in Command–Space bar to find your files.", textAlignment: .center))
        #endif
    }
    @objc func restoreButtonClicked(_ : UIButton){
        dataFlow = Model()
        // read data from disk
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ).appendingPathComponent("MyCurrentLessonPlanBackUp.json"){
            if let jsonData = try? Data(contentsOf: url){
               print(">>>>>>>>>>>>>>>>>>> Backup File Loaded Successfully ")
                self.dataFlow?.jsonModel = JsonModel(json: jsonData)!
                self.dataFlow?.convertJsonModelToRegularModel()
                if self.dataFlow?.jsonModel != nil{
                    // go to info directly
                    sequenceTyped = .main
                    let vc = InfoViewController.InfoViewControllerInstance
                    vc.dataFlow = dataFlow
                    vc.shouldPopResotrePopView = true
                    InfoViewController.isVisited = true
                    let nc = UINavigationController(rootViewController: vc)
                    #if !targetEnvironment(macCatalyst)
                    nc.transitioningDelegate = self
                    nc.modalPresentationStyle = .custom
                    #else
                    nc.modalPresentationStyle = .fullScreen
                    #endif
                    present(nc, animated: true, completion: nil)
                }
            }else{
                animatedIn(self.setBlurView())
                animatedIn(self.setPopView(title: "Failed to load the file", content:"Oops! Seems like you havn't started creating any lesson plan on this device yet", textAlignment: .center))
            }
        }
    }
    @objc func createButtonClicked(_ : UIButton){
        dataFlow = Model()
        continueButtonClicked()
//        print(">>>>>>>>>>>>> check new model instance")
//        print(dataFlow?.instructionSequence)
    }
    @objc func communityButtonClicked(_ : UIButton){
        // go to community
        let communityVC = CommunityViewController()
        let communityNC = UINavigationController(rootViewController: communityVC)
        communityNC.modalPresentationStyle = .overFullScreen
        present(communityNC,animated:true)
    }
    @objc func continueButtonClicked(){
        if dataFlow == nil{
            dataFlow = Model()
        }
        sequenceTyped = .main
        let vc = InfoViewController.InfoViewControllerInstance
        vc.dataFlow = dataFlow
        InfoViewController.isVisited = true
        let nc = UINavigationController(rootViewController: vc)
        #if !targetEnvironment(macCatalyst)
        nc.transitioningDelegate = self
        nc.modalPresentationStyle = .custom
        #else
        nc.modalPresentationStyle = .fullScreen
        #endif
        present(nc, animated: true, completion: nil)
    }
    @objc func questionButtonClicked(_ : UIButton){
        animatedIn(self.setBlurView())
        animatedIn(self.setPopView(title: mainModel.popupTitle, content:mainModel.popupContent, textAlignment: .center))
    }
    @objc func pdfButtonClicked(){
       if dataFlow == nil{
            dataFlow = Model()
        }
//        print("==============================")
//        for (key, val) in dataFlow!.instructionSequenceState{
//            print("\(key): \(val)")
//        }
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
}

// MARK: Tab Views On Road Map
extension MainViewController{
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
        self.mainTableView.setContentOffset(.zero, animated:true)
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
        mainScene.objectivestv.addGestureRecognizer(objectivesGesture)
        let contentGesture = UITapGestureRecognizer(target: self, action: #selector(contentTyped))
        mainScene.contenttv.addGestureRecognizer(contentGesture)
        let summativeGesture = UITapGestureRecognizer(target: self, action: #selector(summativeTyped))
        mainScene.summativetv.addGestureRecognizer(summativeGesture)
        let anticipatoryGesture = UITapGestureRecognizer(target: self, action: #selector(anticipatoryTyped))
        mainScene.anticipatorytv.addGestureRecognizer(anticipatoryGesture)
        let closureGesture = UITapGestureRecognizer(target: self, action: #selector(closureTyped))
        mainScene.closuretv.addGestureRecognizer(closureGesture)
        let instructionGesture = UITapGestureRecognizer(target: self, action: #selector(instructionTyped))
        mainScene.instructiontv.addGestureRecognizer(instructionGesture)
        let backgroundGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTyped))
        mainScene.backgroundtv.addGestureRecognizer(backgroundGesture)
        let lessonGesture = UITapGestureRecognizer(target: self, action: #selector(lessonTyped))
        mainScene.lessontv.addGestureRecognizer(lessonGesture)
    }
}
