//
//  CommunityViewController.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 6/2/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit
import GearRefreshControl
import Highlighter

class CommunityViewController: UIViewController{
    let communityScene = CommunityScene()
    let communityModel = CommunityModel()
    var searchController = UISearchController()
    var resultController = UIViewController()
    var loadedData:GeneralInfo?
    var filteredData:GeneralInfo?
    var resultData:GeneralInfo?
    private lazy var gearRefreshControl = GearRefreshControl(frame: self.view.bounds)
    private var filterCondition = [
        "Subject" : "All Subjects",
        "Grade":"All Grades",
        "Sort":"Latest"
    ]
    private let generalListUpdate = GeneralListUpdate()
    private var lessonPlanRequest = LessonPlanRequest()
    private let resultControllerFilterLabel = UILabel()
    private let resultControllerTabelView = UITableView()
    private var hightlightText = ""
    private var viewPDFJsonModel = JsonModel()
    private var downloadJsonMolde = JsonModel()
    private var uniqueTeachers = Set<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.byuHlightGray

        // Navigation Bar
        self.addBackNaviButton(title: "Back")
        communityScene.setNavigationBar(navgationBar:self.navigationController!.navigationBar)
        
        // Set Layout
        communityScene.setButtonsLayout(view:self.view)
        setupSearch()
        
        // Gear
        communityScene.mainTableView.refreshControl = gearRefreshControl
        gearRefreshControl.gearTintColor = UIColor.byuHRed
        
        // Load Data
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let listRequest = GeneralListRequest()
            listRequest.getList{ [weak self] result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let list):
                    print(">>>>>>>>>>>>>>>>>>> debugDescription: \(self.debugDescription)")
//                    print(list[0])
                    self?.loadedData = list[0]
                    for _ in 0..<self!.loadedData!.Items.count{
                        self?.communityScene.cellheights.append(100)
                    }
                }
                DispatchQueue.main.async {
                    // Stop the Animation
                    self?.view.layer.removeAllAnimations()

                    // Set up the main table view layout and display it
                    self?.communityScene.setMainTableViewLayout(view:self!.view)
                    self?.communityScene.mainTableView.delegate = self
                    self?.communityScene.mainTableView.dataSource = self
                    self?.communityScene.mainTableView.register(CommunityTableViewCell.self, forCellReuseIdentifier: "CommunityTableViewCell")

                    // set date condition
                    let dateFormat = "MM-dd-yyyy"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = dateFormat
                    for i in 0..<self!.loadedData!.Items.count{
                        // get how many teachers in the community
                        if let name = self!.loadedData!.Items[i].Name?.S{
                            var components = name.components(separatedBy: " ")
                            components = components.filter{$0 != ""}
                            let initias = components.reduce("", { ($0 == "" ? "" : "\($0.first!).") + "\($1.first!)." })
                            self?.uniqueTeachers.insert(initias)
                        }
                        // convert string to date
                        if let data = self!.loadedData!.Items[i].Date?.S{
                            self!.loadedData!.Items[i].realDate = dateFormatter.date(from: (data))
                        }
                        // convert NumOfLikes to Int
                        if let num = self!.loadedData!.Items[i].NumOfLikes?.S{
                            self!.loadedData!.Items[i].realNumOfLikes = Int(num)
                        }
                         // handel comment num
                        if let comments = self!.loadedData!.Items[i].Comments?.S{
                            if comments == ""{
                                self!.loadedData!.Items[i].numOfComments = 0
                                self!.loadedData!.Items[i].commentList = []
                            }else{
                                self!.loadedData!.Items[i].commentList = self!.loadedData!.Items[i].Comments!.S.components(separatedBy: "$$$")
                                self!.loadedData!.Items[i].numOfComments = self!.loadedData!.Items[i].commentList!.count
                            }
                        }
                         // init set isCommentExpended
                        self!.loadedData!.Items[i].isCommentExpended = false
                        // init set isLiked
                        self!.loadedData!.Items[i].isLiked = false
                    }

                    self!.filterData()
                    // the data is now read to go
                    
                    // Set up header view
                    let headerView = UIView()
                    headerView.frame = CGRect(x: 0, y: 0, width: 0, height: 60)
                    self!.communityScene.mainTableView.tableHeaderView = headerView
                    print(">>>>>>>>>>>>>>>>>>> Unique Teachers' Initials: \(self!.uniqueTeachers)")
                    self!.communityScene.setupHeadViewLayout(headerView: headerView, numOfNames: (self?.uniqueTeachers.count)!)
                    self!.communityScene.initialNamesCollectionView.delegate = (self!)
                    self!.communityScene.initialNamesCollectionView.dataSource = (self!)
                }
            }
        }
        // Set buttons target
        communityScene.subjectButton.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
        communityScene.gradeButton.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
        communityScene.sortButton.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)

        // whenever user change the filter condition, the following method gets called
        communityModel.subjectMenu.anchorView = communityScene.subjectButton
        communityModel.subjectMenu.selectionAction = {index, subject in
            self.communityScene.subjectButton.setTitle(subject, for: .normal)
            self.filterCondition["Subject"] = subject
            self.filterData()
        }
        communityModel.gradeMenu.anchorView = communityScene.gradeButton
        communityModel.gradeMenu.selectionAction = {index, grade in
            self.communityScene.gradeButton.setTitle(grade, for: .normal)
            self.filterCondition["Grade"] = grade
            self.filterData()
        }
        communityModel.sortMenu.anchorView = communityScene.sortButton
        communityModel.sortMenu.selectionAction = {index,  sort in
            self.communityScene.sortButton.setTitle(sort, for: .normal)
            self.filterCondition["Sort"] = sort
            self.filterData()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        // Loading
        if loadedData == nil{
            self.view.addSubview(communityScene.loadingGear)
            communityScene.setLoadingGearLayout(view: self.view)
            communityScene.loadingGearStartAnimation()
        }
    }
}

// MARK: Delegation
extension CommunityViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return uniqueTeachers.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InitialNamesCollectionViewCell", for: indexPath) as! InitialNamesCollectionViewCell
        cell.nameLabel.text = uniqueTeachers.sorted()[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 27, height: 27)
    }
}
extension CommunityViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        gearRefreshControl.scrollViewDidScroll(scrollView)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
        self.gearRefreshControl.endRefreshing()
    }
}
extension CommunityViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var data = (filteredData == nil) ? loadedData:filteredData
        data = (resultData == nil) ? filteredData:resultData
        return data?.Items.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return communityScene.cellheights[indexPath.row]
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityTableViewCell") as! CommunityTableViewCell
        var data = (filteredData == nil) ? loadedData:filteredData
        data = (resultData == nil) ? filteredData:resultData
        cell.selectionStyle = .none
        cell.lessonTitleLabel.text = (data!.Items[indexPath.row].Title?.S) ?? ""
        cell.infoLable.text = "\(data!.Items[indexPath.row].Subject?.S ?? "Subject") • \(data!.Items[indexPath.row].Grade?.S ?? "Grade") • \(data!.Items[indexPath.row].Date?.S ?? "Date")"
        cell.likeButton.setTitle("👍 \(data!.Items[indexPath.row].realNumOfLikes ?? 0)", for: .normal)
        cell.likeButton.alpha = (data!.Items[indexPath.row].isLiked!) ? 0.5 : 1
        cell.likeButton.isUserInteractionEnabled = (data!.Items[indexPath.row].isLiked!) ? false : true
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        cell.likeButton.tag = indexPath.row
        cell.commentButton.setTitle("💬 \(data!.Items[indexPath.row].numOfComments!)", for: .normal)
        cell.commentButton.tag = indexPath.row
        cell.commentButton.addTarget(self, action: #selector(commentButtonClicked), for: .touchUpInside)
        cell.commentList = data!.Items[indexPath.row].commentList
        cell.numOfComments = data!.Items[indexPath.row].numOfComments
        cell.commentInputTextView.isHidden = (data!.Items[indexPath.row].isCommentExpended!) ? false : true
        cell.commentTableView.isHidden = (data!.Items[indexPath.row].isCommentExpended!) ? false : true
        cell.uploadIcon.isHidden = (data!.Items[indexPath.row].isCommentExpended!) ? false : true
        cell.noCommentLabel.isHidden = (data!.Items[indexPath.row].isCommentExpended! && (data!.Items[indexPath.row].commentList == [])) ? false : true
        let tap = UITapGestureRecognizer(target: self, action: #selector(upload))
        cell.uploadIcon.tag = indexPath.row
        cell.uploadIcon.addGestureRecognizer(tap)
        cell.commentInputTextView.text = "Write a comment..."
        cell.commentInputTextView.textColor = UIColor.byuHGray
        cell.commentTableView.reloadData()
        cell.pdfButton.addTarget(self, action: #selector(pdfButtonClicked), for: .touchUpInside)
        cell.pdfButton.tag = indexPath.row
        cell.downloadButton.addTarget(self, action: #selector(downlaodButtonClicked), for: .touchUpInside)
        cell.downloadButton.tag = indexPath.row
        if let name = data!.Items[indexPath.row].Name?.S{
            var components = name.components(separatedBy: " ")
            components = components.filter{$0 != ""}
            cell.nameInitial.text = components.reduce("", { ($0 == "" ? "" : "\($0.first!).") + "\($1.first!)." })
        }
        // hightlight
        let hightlightAttributes: [NSAttributedString.Key: Any] = [
            .backgroundColor: #colorLiteral(red: 0.9713376164, green: 0.973821938, blue: 0.03123214096, alpha: 1)
        ]
        cell.lessonTitleLabel.highlight(text: hightlightText, normal: [NSAttributedString.Key: Any](), highlight: hightlightAttributes)
        cell.infoLable.highlight(text: hightlightText, normal: [NSAttributedString.Key: Any](), highlight: hightlightAttributes)
        cell.nameInitial.highlight(text: hightlightText, normal: [NSAttributedString.Key: Any](), highlight: hightlightAttributes)
        cell.backgroundColor = UIColor.byuHlightGray
        return cell
    }
}
extension CommunityViewController:  UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if filteredData != nil{
            resultData = GeneralInfo(Items: [])
            resultData?.Items = filteredData!.Items.filter{
                ($0.Title?.S.caseInsensitiveSearch(searchController.searchBar.text!))! ||
                    ($0.Subject?.S.caseInsensitiveSearch(searchController.searchBar.text!))! ||
                    ($0.Date?.S.caseInsensitiveSearch(searchController.searchBar.text!))! ||
                    ($0.Grade?.S.caseInsensitiveSearch(searchController.searchBar.text!))! ||
                    ($0.Name?.S.caseInsensitiveSearch(searchController.searchBar.text!))!
            }
            hightlightText = searchController.searchBar.text!
            self.resultControllerTabelView.reloadData()
            if searchController.searchBar.text! == ""{
                resultData = nil
            }
        }
    }
    func willPresentSearchController(_ searchController: UISearchController) {
        navigationItem.leftBarButtonItem = nil
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        resultControllerFilterLabel.text = "Filter by:  \(self.filterCondition["Subject"]!) • \(self.filterCondition["Grade"]!) • \(self.filterCondition["Sort"]!)"
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.addBackNaviButton(title: "Done")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
       if searchController.searchBar.text! == ""{
            resultData = nil
        }
        updateViewFromModel()
    }
}

// MARK: Functions
extension CommunityViewController{
    @objc override func navBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func pdfButtonClicked(button: UIButton){
        // add spinner
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.color = UIColor.byuHRed
        button.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        let ID = self.filteredData!.Items[button.tag].ID!.S
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self!.lessonPlanRequest.getLessonPlan(ID: ID){[weak self] result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let list):
                    print(">>>>>>>>>>>>>>>>>>> debugDescription: \(self.debugDescription)")
//                    print(list)
                    self!.viewPDFJsonModel = list
                }
                DispatchQueue.main.async {
                    // Stop the Spinner
                    spinner.stopAnimating()
                    let vc = ViewPDFViewController()
                    vc.jsonModel = self!.viewPDFJsonModel
                    vc.jsonModel?.Item?.Name?.S = "hidden"
//                    print(">>>>>>>>>>>>>>>>>>> View PDF")
//                    print(vc.jsonModel)
                    let nc = UINavigationController(rootViewController: vc)
                    self!.present(nc, animated: true, completion: nil)
                }
            }
        }
    }
    @objc func downlaodButtonClicked(button:UIButton){        
        // add spinner
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.color = UIColor.byuHRed
        button.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        let ID = self.filteredData!.Items[button.tag].ID!.S
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self!.lessonPlanRequest.getLessonPlan(ID: ID){[weak self] result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let list):
                    print(">>>>>>>>>>>>>>>>>>> debugDescription:\(self.debugDescription)")
                    //                    print(list)
                    self!.downloadJsonMolde = list
                }
                DispatchQueue.main.async {
                    // Stop the Spinner
                    spinner.stopAnimating()
                    let vc = InfoViewController.InfoViewControllerInstance
                    vc.dataFlow = Model()
                    vc.dataFlow!.jsonModel = self!.downloadJsonMolde
                    vc.dataFlow!.convertJsonModelToRegularModel()
                    vc.dataFlow!.name = "hidden"
                    vc.dataFlow!.email = "hidden"
                    let nc = UINavigationController(rootViewController: vc)
                        nc.modalPresentationStyle = .overFullScreen
                    self!.present(nc, animated: true, completion: nil)
//                    #if targetEnvironment(macCatalyst)
//                    self?.navigationController?.pushViewController(vc, animated: true)
//                    #else
//                    let nc = UINavigationController(rootViewController: vc)
//                        nc.modalPresentationStyle = .overFullScreen
//                    self!.present(nc, animated: true, completion: nil)
//                    #endif
                }
            }
        }
    }
    func updateLoadedGeneralListFromFilteredData(){
        for i in 0..<filteredData!.Items.count{
            label: for j in 0..<loadedData!.Items.count{
                if filteredData!.Items[i].ID?.S == loadedData!.Items[j].ID?.S{
                    loadedData!.Items[j] = filteredData!.Items[i]
                    break label
                }
            }
        }
    }
    @objc func upload(recognizer: UITapGestureRecognizer){
        if let cell = communityScene.mainTableView.cellForRow(at: IndexPath(row: recognizer.view!.tag, section: 0)) as? CommunityTableViewCell{
            if cell.commentInputTextView.text != "" && cell.commentInputTextView.text != "Write a comment..."{
                // get the current date
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd/yyyy"
                let dateText = formatter.string(from: date)
                // update the model
                let newComment = cell.commentInputTextView.text + "@@@\(dateText)"
                filteredData!.Items[recognizer.view!.tag].commentList!.insert(newComment, at: 0)
                filteredData!.Items[recognizer.view!.tag].numOfComments! += 1
                // update the AWS
                let temp = recognizer.view!.tag
                DispatchQueue.global(qos: .userInitiated).async {
                    self.generalListUpdate.sendRequest(ID: (self.filteredData!.Items[temp].ID!.S), newComment: newComment)
                }
                // update the view
                communityScene.mainTableView.reloadData()
                cell.commentTableView.reloadData()
                if cell.numOfComments != 0{
                    cell.commentTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)

                }
                cell.noCommentLabel.isHidden = true
                cell.commentInputTextView.text = ""
            }
        }
        updateLoadedGeneralListFromFilteredData()
    }
    func updateViewFromModel(){
        // 注意这个 func 会把所有的 comment 收回去
        for i in 0..<communityScene.cellheights.count{
            communityScene.cellheights[i] = 100
        }
        for i in 0..<filteredData!.Items.count{
            filteredData!.Items[i].isCommentExpended = false
        }
        communityScene.mainTableView.reloadData()
//        for visibleCell in communityScene.mainTableView.visibleCells{
//            if let cell = visibleCell as? CommunityTableViewCell{
//                cell.commentTableView.reloadData()
//            }
//        }
    }
    func filterData(){
        filteredData = loadedData
        if filteredData != nil{
            if filterCondition["Subject"] != "All Subjects"{
                let temp = filteredData!.Items.filter{ ($0.Subject?.S) == filterCondition["Subject"]}
                filteredData?.Items = temp
            }
            if filterCondition["Grade"] != "All Grades"{
                let temp = filteredData!.Items.filter{ ($0.Grade?.S) == filterCondition["Grade"]}
                filteredData?.Items = temp
            }
            if filterCondition["Sort"] == "Latest"{
                let temp = filteredData!.Items.sorted(by: { ($0.realDate ?? Date()).compare(($1.realDate ?? Date())) == .orderedDescending })
                filteredData?.Items = temp
            }else if filterCondition["Sort"] == "by Likes"{
                filteredData!.Items.sort{ $0.realNumOfLikes! > $1.realNumOfLikes!}
            }else if filterCondition["Sort"] == "by Comments"{
                filteredData!.Items.sort{ $0.numOfComments! > $1.numOfComments!}
            }
        }
        updateViewFromModel()
    }
    @objc func filterTapped(_ button: UIButton){
        switch button.tag {
        case 0:
            communityModel.subjectMenu.show()
        case 1:
            communityModel.gradeMenu.show()
        default:
            communityModel.sortMenu.show()
        }
    }
    @objc func likeButtonClicked(_ button: UIButton){
        if self.filteredData!.Items[button.tag].realNumOfLikes != nil{
            self.filteredData!.Items[button.tag].realNumOfLikes! += 1
            self.filteredData!.Items[button.tag].isLiked = true
            UIView.animate(withDuration: 0.25, animations: {
                button.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, -50, 0)
            },
                           completion: {finished in
                            UIView.animate(withDuration: 0.5, animations: {
                                button.layer.transform = CATransform3DIdentity
                                button.alpha = 0.5
                                button.setTitle("👍 \(self.filteredData!.Items[button.tag].realNumOfLikes!)", for: .normal)
                            },
                                           completion: {finished in
                                            button.isUserInteractionEnabled = false
                            })
            })
        }
        updateLoadedGeneralListFromFilteredData()
        // send request to AWS
        let temp = button.tag
        DispatchQueue.global(qos: .userInitiated).async {
            self.generalListUpdate.sendRequest(ID: (self.filteredData!.Items[temp].ID!.S), isLiked: true)
        }
    }
    @objc func commentButtonClicked(_ button: UIButton){
        // 展开
        if communityScene.cellheights[button.tag] == 100{
            communityScene.cellheights[button.tag] = 350
            filteredData!.Items[button.tag].isCommentExpended = true
        // 收缩
        }else{
            communityScene.cellheights[button.tag] = 100
            filteredData!.Items[button.tag].isCommentExpended = false
        }
        communityScene.mainTableView.beginUpdates()
        communityScene.mainTableView.endUpdates()
        communityScene.mainTableView.reloadRows(at: [IndexPath(row: button.tag, section: 0)], with: .automatic)
        updateLoadedGeneralListFromFilteredData()
    }
    func setupSearch(){
        // Result Controller
        navigationController?.extendedLayoutIncludesOpaqueBars = true

        resultController.view.addSubview(resultControllerFilterLabel)
        resultControllerFilterLabel.backgroundColor = UIColor.byuHlightGray
        resultControllerFilterLabel.translatesAutoresizingMaskIntoConstraints = false
        resultControllerFilterLabel.leadingAnchor.constraint(equalTo: resultController.view.leadingAnchor).isActive = true
        resultControllerFilterLabel.trailingAnchor.constraint(equalTo: resultController.view.trailingAnchor).isActive = true
        resultControllerFilterLabel.topAnchor.constraint(equalTo: resultController.view.safeAreaLayoutGuide.topAnchor).isActive = true
        resultControllerFilterLabel.heightAnchor.constraint(equalToConstant: 60+44+2*sdGap).isActive = true
        resultControllerFilterLabel.textColor = .black
        resultControllerFilterLabel.text = "Filter by:  Subject • Grade • Sort"
        resultControllerFilterLabel.textAlignment = .center
        resultControllerFilterLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        resultControllerFilterLabel.adjustsFontSizeToFitWidth = true

        resultController.view.addSubview(resultControllerTabelView)
        resultControllerTabelView.backgroundColor = UIColor.byuHlightGray
        resultControllerTabelView.translatesAutoresizingMaskIntoConstraints = false
        resultControllerTabelView.leadingAnchor.constraint(equalTo: resultController.view.leadingAnchor).isActive = true
        resultControllerTabelView.trailingAnchor.constraint(equalTo: resultController.view.trailingAnchor).isActive = true
        resultControllerTabelView.topAnchor.constraint(equalTo: resultController.view.safeAreaLayoutGuide.topAnchor, constant: 60+44+2*sdGap).isActive = true
        resultControllerTabelView.bottomAnchor.constraint(equalTo: resultController.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        resultControllerTabelView.register(CommunityTableViewCell.self, forCellReuseIdentifier: "CommunityTableViewCell")
        resultControllerTabelView.tag = 1
        resultControllerTabelView.delegate = self
        resultControllerTabelView.dataSource = self
        resultControllerTabelView.backgroundColor = UIColor.byuHlightGray
        resultControllerTabelView.backgroundColor = UIColor.byuhMidGray

        // Search Controller
        searchController = UISearchController(searchResultsController: resultController)
        searchController.hidesNavigationBarDuringPresentation = false
        // 注意，这里有三个delegate
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.returnKeyType = .done
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
//         navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        // customize color
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField{
            textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            textField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        searchController.searchBar.tintColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}



