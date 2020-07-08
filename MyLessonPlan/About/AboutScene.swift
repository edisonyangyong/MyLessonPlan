//
//  AboutScene.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 6/10/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import youtube_ios_player_helper
import Foundation
import UIKit

class AboutScene{
    var cellHeights: [(name:String,height:CGFloat)] = [("title", 100),("youtu", 150),("shute",200),("edison", 200), ("comment", 200)]
    var mainTableView:UITableView = {
        let mainTableView = UITableView()
        return mainTableView
    }()
    var introductionLable: UILabel = {
        let titleLable = UILabel()
        return titleLable
    }()
    var commentTextView: UITextView = {
        let commentTextView = UITextView()
        return commentTextView
    }()
    var sendButton:UIButton = {
        let sendButton = UIButton(type: .system)
        return sendButton
    }()
    var youtubePlayerView:YTPlayerView = {
        let youtubePlayerView = YTPlayerView()
        return youtubePlayerView
    }()
    
    func setLayout(view:UIView){
        view.addSubview(mainTableView)
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mainTableView.backgroundColor = .white
        mainTableView.allowsSelection = false
    }
    
    func setYoutubePlayerLaytou(view:UIView){
        view.addSubview(youtubePlayerView)
        youtubePlayerView.translatesAutoresizingMaskIntoConstraints = false
        youtubePlayerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        youtubePlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        youtubePlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        youtubePlayerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setTitleCell(cell:UIView){
        let logo = UIImageView()
        cell.addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.leadingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.leadingAnchor, constant: 7).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 50).isActive = true
        logo.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor, constant: 7).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logo.image = #imageLiteral(resourceName: "logo")
        
        cell.backgroundColor = .white
        cell.addSubview(introductionLable)
        introductionLable.translatesAutoresizingMaskIntoConstraints = false
        introductionLable.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 7).isActive = true
        introductionLable.trailingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        introductionLable.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        introductionLable.bottomAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.bottomAnchor, constant: -7).isActive = true
        introductionLable.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        introductionLable.textAlignment = .left
        introductionLable.textColor = .black
        introductionLable.numberOfLines = 0
        introductionLable.adjustsFontSizeToFitWidth = true
    }
    
    func setCommentLayout(cell:UIView){
        cell.addSubview(commentTextView)
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        commentTextView.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor, constant: 7).isActive = true
        commentTextView.leadingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.leadingAnchor,constant: 7).isActive = true
        commentTextView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -44-7-7).isActive = true
        commentTextView.trailingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.trailingAnchor,constant: -7).isActive = true
        commentTextView.backgroundColor = UIColor.sdTextFieldColor()
        commentTextView.text = "comment"
        commentTextView.textColor = .lightGray
        
        cell.addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.topAnchor.constraint(equalTo: commentTextView.bottomAnchor, constant: 7).isActive = true
        sendButton.leadingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.leadingAnchor,constant: 7).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -7).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.trailingAnchor,constant: -7).isActive = true
        sendButton.setTitle("Send to us", for: .normal)
        sendButton.titleLabel?.numberOfLines = 0
        sendButton.titleLabel?.adjustsFontSizeToFitWidth = true
        sendButton.titleLabel?.textAlignment = .center
        sendButton.backgroundColor = #colorLiteral(red: 0.008629960939, green: 0.3736575246, blue: 0.7242882848, alpha: 1)
        sendButton.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        sendButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        sendButton.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        sendButton.layer.cornerRadius = 4
    }
}
