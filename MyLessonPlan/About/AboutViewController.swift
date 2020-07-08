//
//  AboutViewController.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 6/10/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit
import GearRefreshControl
import MessageUI
import youtube_ios_player_helper

class AboutViewController: UIViewController {
    
    private var aboutModel = AboutModel()
    private var aboutScene = AboutScene()
    private lazy var gearRefreshControl = GearRefreshControl(frame: self.view.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        updateCellHeights()
        
        // Navigation Bar
        self.setNavigationBar(title: aboutModel.navTitle)
        self.addBackNaviButton(title: "Back")
        
        aboutScene.setLayout(view:self.view)
        aboutScene.mainTableView.delegate = self
        aboutScene.mainTableView.dataSource = self
        aboutScene.mainTableView.separatorStyle = .none
        aboutScene.mainTableView.refreshControl = gearRefreshControl
        aboutScene.mainTableView.register(AboutTableViewCell.self, forCellReuseIdentifier: "AboutTableViewCell")
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
            self.aboutScene.mainTableView.reloadData()
        })
        super.viewWillTransition(to: size, with: coordinator)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.updateCellHeights()
        self.aboutScene.mainTableView.reloadData()
    }
}

// MARK: Delegation
extension AboutViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return aboutScene.cellHeights[indexPath.row].height
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aboutScene.cellHeights.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.row == 0{
            aboutScene.setTitleCell(cell: cell)
            aboutScene.introductionLable.text = aboutModel.introduction
            return cell
        }else if indexPath.row == 1{
            aboutScene.setYoutubePlayerLaytou(view: cell)
            aboutScene.youtubePlayerView.load(withVideoId: "2YyEJzRL1g4",
                                              playerVars: ["playsinline":1])
            return cell
        }else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutTableViewCell") as! AboutTableViewCell
            cell.photo.image = #imageLiteral(resourceName: "Jon_Shute")
            cell.backgroundColor = #colorLiteral(red: 0.9245321155, green: 0.2970695496, blue: 0.2045861781, alpha: 1)
            cell.c1.backgroundColor = #colorLiteral(red: 0.9245321155, green: 0.2970695496, blue: 0.2045861781, alpha: 1)
            cell.icon.image = #imageLiteral(resourceName: "idea-user")
            cell.nameLabel.text = "Jonathan W. Shute, Ph.D."
            cell.nameTitleLable.text = "Project Founder"
            cell.infoLable.text = "Associate Professor\nTeacher Education Program\nBrigham Young University Hawai’i"
            cell.emailLable.text = ": jon.shute@byuh.edu"
            return cell
        }else if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutTableViewCell") as! AboutTableViewCell
            cell.photo.image = #imageLiteral(resourceName: "DSC_1392")
            cell.backgroundColor = #colorLiteral(red: 0.2750054002, green: 0.4223390222, blue: 0.8662335277, alpha: 1)
            cell.c1.backgroundColor = #colorLiteral(red: 0.2750054002, green: 0.4223390222, blue: 0.8662335277, alpha: 1)
            cell.icon.image = #imageLiteral(resourceName: "apple-512")
            cell.nameLabel.text = "Yong (Edison) Yang"
            cell.nameTitleLable.text = "iOS Developer"
            cell.infoLable.text = "Double major in Computer Science and Applied Mathematics.\nHaving an extensive programming background in C, C#, C++, R, Swift, Python, and Java.\nSELF-DEVELOPED THIS APP FROM SCRATCH."
            cell.emailLable.text = ": edison.yangyong@gmail.com"
            return cell
        }else{
            cell.backgroundColor = .white
            aboutScene.setCommentLayout(cell:cell)
            aboutScene.commentTextView.delegate = self
            aboutScene.sendButton.addTarget(self, action: #selector(send), for: .touchUpInside)
            return cell
        }
    }
}

extension AboutViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        gearRefreshControl.scrollViewDidScroll(scrollView)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
        self.gearRefreshControl.endRefreshing()
    }
}

extension AboutViewController:UITextViewDelegate{
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == "comment"{
            textView.text = ""
            textView.textColor = .black
        }
        return true
    }
}

extension AboutViewController:MFMailComposeViewControllerDelegate{
    func sendEmail() {
        if MFMailComposeViewController.canSendMail(){
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("Feedback From My Lesson Plan App")
            mail.setToRecipients(["jon.shute@byuh.edu","edison.yangyong@gmail.com"])
            mail.setMessageBody("\(aboutScene.commentTextView.text ?? "")", isHTML: false)
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

// MARK: Functions
extension AboutViewController{
    private func updateCellHeights(){
        //  var cellHeights: [(name:String,height:CGFloat)] = [("title", 100),("youtu", 150),("shute",200),("edison", 200), ("comment", 200)]
        aboutScene.cellHeights[1].height = (self.view.frame.width*9/16 > self.view.frame.height) ? (self.view.frame.height-navHeight-safeBottom): self.view.frame.width*9/16
        aboutScene.cellHeights[4].height = self.view.frame.height - navHeight - bottomViewFrame.height - 100 - 200 - 200 - self.view.frame.width*9/16
        aboutScene.cellHeights[4].height = (aboutScene.cellHeights[4].height < 0) ? 200:aboutScene.cellHeights[3].height
    }
    @objc func send(){
        if aboutScene.commentTextView.text != "comment" && aboutScene.commentTextView.text != ""{
            sendEmail()
            aboutScene.commentTextView.text = "comment"
            aboutScene.commentTextView.textColor = .lightGray
        }
    }
}
