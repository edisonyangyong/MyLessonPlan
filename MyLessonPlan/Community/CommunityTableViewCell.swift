//
//  CommunityTableViewCell.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 6/2/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

class CommunityTableViewCell: UITableViewCell {
    
    var logo = UIImageView()
    var lessonTitleLabel = UILabel()
    var likeImageView = UIImageView()
    var likeButton = UIButton()
    var commentButton = UIButton()
    var previewButton = UIButton()
    var infoLable = UILabel()
    var pdfButton = UIButton(type: .system)
    var downloadButton = UIButton(type: .system)
    var commentTableView = UITableView()
    var commentList: [String]?
    var numOfComments: Int?
    var commentInputTextView = UITextView()
    var uploadIcon = UIImageView()
    var noCommentLabel = UILabel()
    var nameInitial = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.byuHlightGray
        setCellLabelLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellLabelLayout(){
        addSubview(logo)
        addSubview(lessonTitleLabel)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(previewButton)
        addSubview(downloadButton)
        addSubview(infoLable)
        addSubview(pdfButton)
        addSubview(downloadButton)
        addSubview(commentTableView)
        addSubview(commentInputTextView)
        addSubview(uploadIcon)
        addSubview(noCommentLabel)
        addSubview(nameInitial)
        
        logo.image = #imageLiteral(resourceName: "logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: sdGap).isActive = true
        logo.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 4).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 50).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        nameInitial.translatesAutoresizingMaskIntoConstraints = false
        nameInitial.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: sdGap).isActive = true
        nameInitial.heightAnchor.constraint(equalToConstant: 17).isActive = true
        nameInitial.leadingAnchor.constraint(equalTo: logo.leadingAnchor).isActive = true
        nameInitial.trailingAnchor.constraint(equalTo: logo.trailingAnchor).isActive = true
        nameInitial.font = UIFont(name: "Optima-Bold", size: 17)
        nameInitial.adjustsFontSizeToFitWidth = true
        nameInitial.textAlignment = .center
        nameInitial.textColor = .black
        
        let titleHint = UILabel()
        addSubview(titleHint)
        titleHint.translatesAutoresizingMaskIntoConstraints = false
        titleHint.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: sdGap).isActive = true
        titleHint.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        titleHint.heightAnchor.constraint(equalToConstant: 17).isActive = true
        titleHint.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -sdGap).isActive = true
        titleHint.text = "Lesson Plan Title:"
        titleHint.textColor = UIColor.byuhMidGray
        titleHint.font = UIFont(name: "AppleSDGothicNeo-Bold", size: sdFontSize*2/3)
        titleHint.backgroundColor = UIColor.byuHlightGray
        titleHint.sizeToFit()
        
        lessonTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        lessonTitleLabel.topAnchor.constraint(equalTo: titleHint.bottomAnchor).isActive = true
        lessonTitleLabel.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: sdGap).isActive = true
        lessonTitleLabel.heightAnchor.constraint(equalToConstant: 50-17).isActive = true
        lessonTitleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -sdGap).isActive = true
        lessonTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        lessonTitleLabel.adjustsFontSizeToFitWidth = true
        lessonTitleLabel.textColor = .black
        lessonTitleLabel.numberOfLines = 0
        
        infoLable.translatesAutoresizingMaskIntoConstraints = false
        infoLable.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: sdGap).isActive = true
        infoLable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -sdGap).isActive = true
        infoLable.topAnchor.constraint(equalTo: lessonTitleLabel.bottomAnchor).isActive = true
        infoLable.heightAnchor.constraint(equalToConstant: 17).isActive = true
        infoLable.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17)
        infoLable.textColor = UIColor.byuhMidGray
        infoLable.adjustsFontSizeToFitWidth = true
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: sdGap).isActive = true
        likeButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.15).isActive = true
//        likeButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        likeButton.topAnchor.constraint(equalTo: infoLable.bottomAnchor, constant: sdGap).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 17).isActive = true
        likeButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        likeButton.titleLabel!.adjustsFontSizeToFitWidth = true
        likeButton.sizeToFit()
        likeButton.contentHorizontalAlignment = .left
        likeButton.setTitleColor(UIColor.byuHDarkGray, for: .normal)
        
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        commentButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: sdGap).isActive = true
//        commentButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        commentButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.15).isActive = true
        commentButton.topAnchor.constraint(equalTo: infoLable.bottomAnchor, constant: sdGap).isActive = true
        commentButton.heightAnchor.constraint(equalToConstant: 17).isActive = true
        commentButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        commentButton.titleLabel!.adjustsFontSizeToFitWidth = true
        commentButton.contentHorizontalAlignment = .left
        commentButton.setTitleColor(UIColor.byuHDarkGray, for: .normal)
        
        pdfButton.translatesAutoresizingMaskIntoConstraints = false
        pdfButton.topAnchor.constraint(equalTo: infoLable.bottomAnchor, constant: 5).isActive = true
//        pdfButton.leadingAnchor.constraint(equalTo: commentButton.trailingAnchor, constant: sdGap).isActive = true
        pdfButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.24).isActive = true
        pdfButton.trailingAnchor.constraint(equalTo: downloadButton.leadingAnchor, constant: -sdGap).isActive = true
        pdfButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        pdfButton.setTitle("View PDF", for: .normal)
        pdfButton.titleLabel?.adjustsFontSizeToFitWidth = true
        pdfButton.backgroundColor = #colorLiteral(red: 0.3106759191, green: 0.6774330139, blue: 0.185857743, alpha: 1)
        pdfButton.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pdfButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pdfButton.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        pdfButton.layer.cornerRadius = 4
        pdfButton.layer.cornerRadius = 4
        pdfButton.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        pdfButton.layer.shadowRadius = 2.5
        pdfButton.layer.shadowOpacity = 0.9
        pdfButton.layer.shadowColor = UIColor.darkGray.cgColor
        
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        downloadButton.topAnchor.constraint(equalTo: infoLable.bottomAnchor, constant: 5).isActive = true
        downloadButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.24).isActive = true
//        downloadButton.leadingAnchor.constraint(equalTo: pdfButton.trailingAnchor, constant: sdGap).isActive = true
        downloadButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -sdGap).isActive = true
        downloadButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        downloadButton.setTitle("Download", for: .normal)
        downloadButton.layer.cornerRadius = 4
        downloadButton.backgroundColor = #colorLiteral(red: 0, green: 0.3587287962, blue: 0.7226245999, alpha: 1)
        downloadButton.tintColor = .white
        downloadButton.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        downloadButton.titleLabel?.adjustsFontSizeToFitWidth = true
        downloadButton.titleLabel?.textAlignment = .center
        downloadButton.layer.cornerRadius = 4
        downloadButton.layer.cornerRadius = 4
        downloadButton.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        downloadButton.layer.shadowRadius = 2.5
        downloadButton.layer.shadowOpacity = 0.9
        downloadButton.layer.shadowColor = UIColor.darkGray.cgColor
        
        commentTableView.translatesAutoresizingMaskIntoConstraints = false
        commentTableView.topAnchor.constraint(equalTo: downloadButton.bottomAnchor, constant: sdGap).isActive = true
        commentTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        commentTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -sdGap).isActive = true
        commentTableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        commentTableView.isHidden = true
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentTableViewCell")
        commentTableView.backgroundColor = UIColor.byuHlightGray
        
        noCommentLabel.translatesAutoresizingMaskIntoConstraints = false
        noCommentLabel.topAnchor.constraint(equalTo: downloadButton.bottomAnchor, constant: sdGap).isActive = true
        noCommentLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        noCommentLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -sdGap).isActive = true
        noCommentLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        noCommentLabel.isHidden = true
        noCommentLabel.text = "Be the first to comment"
        noCommentLabel.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        noCommentLabel.textAlignment = .center
        noCommentLabel.textColor = UIColor.byuHGray
        self.bringSubviewToFront(noCommentLabel)
        
        commentInputTextView.translatesAutoresizingMaskIntoConstraints = false
        commentInputTextView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -sdGap).isActive = true
        commentInputTextView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -sdGap-50).isActive = true
        commentInputTextView.leadingAnchor.constraint(equalTo: logo.trailingAnchor).isActive = true
        commentInputTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 35).isActive = true
        commentInputTextView.isScrollEnabled = false
        commentInputTextView.sizeToFit()
//        commentInputTextView.frame = CGRect(x:safeRight+50, y: 310, width: 300, height: 35)
        commentInputTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17)
        commentInputTextView.text = "Write a comment..."
        commentInputTextView.textColor = UIColor.byuHGray
        commentInputTextView.backgroundColor = .white
        commentInputTextView.isHidden = true
        commentInputTextView.textAlignment = .left
        commentInputTextView.layer.cornerRadius = 0.5*35
        commentInputTextView.clipsToBounds = false
        commentInputTextView.layer.shadowOpacity=0.4
        commentInputTextView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        commentInputTextView.delegate = self
        
        uploadIcon.translatesAutoresizingMaskIntoConstraints = false
        uploadIcon.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -sdGap).isActive = true
        uploadIcon.widthAnchor.constraint(equalToConstant: 44).isActive = true
        uploadIcon.bottomAnchor.constraint(equalTo: commentInputTextView.bottomAnchor).isActive = true
        uploadIcon.heightAnchor.constraint(equalToConstant: 44).isActive = true
        uploadIcon.image = #imageLiteral(resourceName: "upload-filled")
        uploadIcon.contentMode = .scaleAspectFit
        uploadIcon.isHidden = true
        uploadIcon.isUserInteractionEnabled = true
    }
}

// MARK: Delegation
extension CommunityTableViewCell:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView){
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Write a comment..."{
            textView.text = ""
            textView.textColor = .black
        }
    }
    
}
extension CommunityTableViewCell:UITableViewDataSource, UITableViewDelegate{
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        UIView.transition(
//            with: cell,
//            duration: 0.5,
//            options: .transitionFlipFromBottom, animations: {
//        })
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numOfComments!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell
        let realComment = self.commentList![indexPath.row].components(separatedBy: "@@@")
        if realComment.count > 1{
            cell.commentLabel.text = realComment[0]
            cell.dateLabel.text = realComment[1]
        }
        return cell
    }
}
