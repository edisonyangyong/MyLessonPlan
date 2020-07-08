//
//  InspirationViewController.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/13/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit
import Highlighter
import GearRefreshControl

class InspirationViewController: UIViewController{
    
    var searchController = UISearchController()
    var resultController = UITableViewController()
    private let inspirationScene = InspirationScene()
    private var myList:[InspiritionalIdea] = []
    private var resultList:[InspiritionalIdea] = []
    var delegate:InspirationViewControllerDataFlowUpdatingDelegation?
    var hightlightText = ""
    private lazy var gearRefreshControl = GearRefreshControl(frame: self.view.bounds)
    private let likeUpdate = InspirationListUpdate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.byuHlightGray
        
        // Navigation Bar
        self.addBackNaviButton(title: "Back")
        inspirationScene.setNavigationBar(navgationBar:self.navigationController!.navigationBar)
        self.title = "InspirationViewController"
        
        // search
        setupSearch()
        
        // gear
        inspirationScene.inspirationTableView.refreshControl = gearRefreshControl
        gearRefreshControl.gearTintColor = UIColor.byuHRed
        
        // load List data
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let listRequest = InspirationList_Request()
            listRequest.getList{ [weak self] result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let list):
                   print(">>>>>>>>>>>>>>>>>>> debugDescription: \(self.debugDescription)")
                    self?.myList = list
                    self?.myList.remove(at: 0)
                    if self != nil{
                        for i in self!.myList.indices{
                            self!.myList[i].Item?.isLiked = false
                        }
                    }
                }
                DispatchQueue.main.async {
                    // stop the animation
                    self?.view.layer.removeAllAnimations()
                    // display the table
                    self?.view.addSubview((self?.inspirationScene.inspirationTableView)!)
                    self?.inspirationScene.setinspirationListLayout(view: (self?.view)!)
                    self?.inspirationScene.inspirationTableView.delegate = self
                    self?.inspirationScene.inspirationTableView.dataSource = self
                    self?.inspirationScene.inspirationTableView.register(InspirationTableViewCell.self, forCellReuseIdentifier: "InspirationTableViewCell")
                }
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        // Loading
        if myList.count == 0{
            self.view.addSubview(inspirationScene.loadingGear)
            inspirationScene.setLoadingGearLayout(view: self.view)
            inspirationScene.loadingGearStartAnimation()
        }
    }
}

// MARK: Delegation
extension InspirationViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        gearRefreshControl.scrollViewDidScroll(scrollView)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
        self.gearRefreshControl.endRefreshing()
    }
}

extension InspirationViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0{
            return myList.count
        }else{
            return resultList.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var list:[InspiritionalIdea] = []
        list = (tableView.tag == 0) ? myList : resultList
        let cell = inspirationScene.inspirationTableView.dequeueReusableCell(withIdentifier: "InspirationTableViewCell") as! InspirationTableViewCell
        cell.cellTitle.text = list[indexPath.row].Item?.Title?.S
        cell.cellLabel.text = list[indexPath.row].Item?.Idea?.S
        cell.likeNum = Int((list[indexPath.row].Item?.Likes?.S)!) ?? 0
        cell.likeImageView.tag = indexPath.row
        if list[indexPath.row].Item?.isLiked == false{
            cell.cellLike.setTitle(String(cell.likeNum) + " Teachers Liked This Idea", for: .normal)
            cell.likeImageView.image = #imageLiteral(resourceName: "like_unselect")
        }else{
            cell.cellLike.setTitle(String(cell.likeNum + 1) + " Teachers Liked This Idea", for: .normal)
            cell.likeImageView.image = #imageLiteral(resourceName: "like_selected")
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(likeClicked))
        cell.likeImageView.addGestureRecognizer(tapGesture)
        cell.insertButton.addTarget(self, action: #selector(insertButtonClicked), for: .touchUpInside)
        cell.insertButton.tag = indexPath.row
        
        // hightlight
        let hightlightAttributes: [NSAttributedString.Key: Any] = [
            .backgroundColor: #colorLiteral(red: 0.9713376164, green: 0.973821938, blue: 0.03123214096, alpha: 1)
        ]
        cell.cellTitle.highlight(text: hightlightText, normal: [NSAttributedString.Key: Any](), highlight: hightlightAttributes)
        cell.cellLabel.highlight(text: hightlightText, normal: [NSAttributedString.Key: Any](), highlight: hightlightAttributes)
        cell.backgroundColor = UIColor.byuHlightGray
        return cell
    }
}

extension InspirationViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //searchBar.resignFirstResponder()
    }
}

extension InspirationViewController: UISearchControllerDelegate{
    func willPresentSearchController(_ searchController: UISearchController) {
        navigationItem.leftBarButtonItem = nil
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.addBackNaviButton(title: "Back")
    }
}

extension InspirationViewController: UISearchResultsUpdating{
    public func updateSearchResults(for searchController: UISearchController) {
        resultList = myList.filter{ ($0.Item?.Title?.S.caseInsensitiveSearch(searchController.searchBar.text!))! || ($0.Item?.Idea?.S.caseInsensitiveSearch(searchController.searchBar.text!))!}
        hightlightText = searchController.searchBar.text!
        self.resultController.tableView.reloadData()
    }
}

// MARK: Functions
extension InspirationViewController{
    @objc override func navBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func likeClicked(_ recognizer: UITapGestureRecognizer){
        let cell = recognizer.view?.superview as! InspirationTableViewCell
        if resultList.count > 0 {
            if resultList[cell.likeImageView.tag].Item?.isLiked == false{
                cell.likeImageView.image = #imageLiteral(resourceName: "like_selected")
                cell.cellLike.setTitle(String(cell.likeNum + 1) + " Teachers Liked This Idea", for: .normal)
                // find cell from resultList in myList
                for i in myList.indices{
                    if myList[i].Item?.Title?.S == cell.cellTitle.text{
                        myList[i].Item?.isLiked = true
                        DispatchQueue.global(qos: .userInitiated).async {
                            self.likeUpdate.sendRequest(keyNum: (self.myList[i].Item?.Id?.S)!)
                        }
                        inspirationScene.inspirationTableView.reloadData()
                    }
                }
            }
        }else{
            if myList[cell.likeImageView.tag].Item?.isLiked == false{
                cell.likeImageView.image = #imageLiteral(resourceName: "like_selected")
                cell.cellLike.setTitle(String(cell.likeNum + 1) + " Teachers Liked This Idea", for: .normal)
                myList[cell.likeImageView.tag].Item?.isLiked = true
                let tag = cell.likeImageView.tag
                DispatchQueue.global(qos: .userInitiated).async {
                    self.likeUpdate.sendRequest(keyNum: (self.myList[tag].Item?.Id?.S)!)
                }
            }
        }
    }
    @objc func insertButtonClicked(_ recognizer: UIButton){
        if resultList.count > 0{
            let idea = (resultList[recognizer.tag].Item?.Title?.S)! + "\n" + (resultList[recognizer.tag].Item?.Idea?.S)!
            delegate?.updateDataFlowFromInspirationVC(idea: idea)
            resultController.dismiss(animated: false)
//            searchController.view.endEditing(true)
            if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField{
                textField.resignFirstResponder()
            }
        }else{
            let idea = (myList[recognizer.tag].Item?.Title?.S)! + "\n" + (myList[recognizer.tag].Item?.Idea?.S)!
            delegate?.updateDataFlowFromInspirationVC(idea: idea)
        }
        self.view.endEditing(true)
        animatedIn(self.setBlurView())
        animatedIn(self.setPopView(title: "Success!", content:"You have successfully inserted this idea into your Anticipatory Set of your lesson plan.\n\nFeel free to edit this idea to fit your content\n\nDon't forget to like this idea!", textAlignment: .center))
    }
    
    func setupSearch(){
        // Result Controller
        navigationController?.extendedLayoutIncludesOpaqueBars = true
        resultController.view.frame = CGRect(x: sdGap, y: navHeight, width: view.frame.width-2*sdGap, height: view.frame.height-safeTop-navHeight-safeBottom)
        resultController.tableView.register(InspirationTableViewCell.self, forCellReuseIdentifier: "InspirationTableViewCell")
        resultController.tableView.tag = 1
        resultController.tableView.dataSource = self
        resultController.tableView.backgroundColor = UIColor.byuHlightGray
        
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

extension String {
    func caseInsensitiveSearch(_ string: String) -> Bool {
        return self ~= string
    }
}

extension String {
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs,options: .caseInsensitive) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
}
