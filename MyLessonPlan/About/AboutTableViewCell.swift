//
//  AboutTableViewCell.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 6/10/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

class AboutTableViewCell: UITableViewCell {
    
    let photo = UIImageView()
    let c1 = UIView()
    let c2 = UIView()
    let icon = UIImageView()
    let nameLabel = UILabel()
    let nameTitleLable = UILabel()
    let infoLable = UILabel()
    let emailIcon = UIImageView()
    let emailLable = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCellLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCellLayout(){
        self.backgroundColor = .green
        addSubview(photo)
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        photo.widthAnchor.constraint(equalToConstant: 140).isActive = true
        photo.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        photo.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        photo.contentMode = .scaleToFill
        
        addSubview(c1)
        c1.translatesAutoresizingMaskIntoConstraints = false
        c1.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant:120).isActive = true
        c1.widthAnchor.constraint(equalToConstant: 80).isActive = true
        c1.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        c1.heightAnchor.constraint(equalToConstant: 80).isActive = true
        c1.layer.cornerRadius = 0.5*80
        c1.layer.masksToBounds = false
        
        addSubview(c2)
        c2.translatesAutoresizingMaskIntoConstraints = false
        c2.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant:130).isActive = true
        c2.widthAnchor.constraint(equalToConstant: 70).isActive = true
        c2.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        c2.heightAnchor.constraint(equalToConstant: 70).isActive = true
        c2.layer.cornerRadius = 0.5*70
        c2.layer.masksToBounds = false
        c2.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        c2.layer.borderWidth = 3
        c2.backgroundColor = .black
        
        addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant:147).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 35).isActive = true
        icon.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 42).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant:210).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont(name: "MarkerFelt-Wide", size: 30)!
        nameLabel.adjustsFontSizeToFitWidth = true
        
        addSubview(nameTitleLable)
        nameTitleLable.translatesAutoresizingMaskIntoConstraints = false
        nameTitleLable.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant:210).isActive = true
        nameTitleLable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        nameTitleLable.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTitleLable.heightAnchor.constraint(equalToConstant: 25).isActive = true
        nameTitleLable.textColor = .white
        nameTitleLable.textAlignment = .left
        nameTitleLable.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)!
        nameTitleLable.adjustsFontSizeToFitWidth = true
        
        addSubview(infoLable)
        infoLable.translatesAutoresizingMaskIntoConstraints = false
        infoLable.leadingAnchor.constraint(equalTo: photo.trailingAnchor, constant:10).isActive = true
        infoLable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        infoLable.topAnchor.constraint(equalTo: nameTitleLable.bottomAnchor).isActive = true
        infoLable.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
        infoLable.textColor = .white
        infoLable.textAlignment = .left
        infoLable.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)!
        infoLable.numberOfLines = 0
        infoLable.adjustsFontSizeToFitWidth = true
        
        addSubview(emailIcon)
        emailIcon.translatesAutoresizingMaskIntoConstraints = false
        emailIcon.leadingAnchor.constraint(equalTo: infoLable.leadingAnchor).isActive = true
        emailIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        emailIcon.topAnchor.constraint(equalTo: infoLable.bottomAnchor).isActive = true
        emailIcon.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        emailIcon.image = #imageLiteral(resourceName: "email-filled")
        emailIcon.contentMode = .scaleAspectFit
        
        addSubview(emailLable)
        emailLable.translatesAutoresizingMaskIntoConstraints = false
        emailLable.leadingAnchor.constraint(equalTo: emailIcon.trailingAnchor, constant: 5).isActive = true
        emailLable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        emailLable.topAnchor.constraint(equalTo: infoLable.bottomAnchor).isActive = true
        emailLable.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        emailLable.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)!
        emailLable.adjustsFontSizeToFitWidth = true
        emailLable.textColor = .white
    }
}
