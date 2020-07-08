//
//  PDFModel.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/16/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import PDFKit
import UIKit

class PDFscene:UIView{
    var pdfView:PDFView = {
        let pdfView = PDFView()
        pdfView.backgroundColor = .byuHRed
        return pdfView
    }()
    var exportButton:UIButton = {
        let exportButton = UIButton(type: .system)
        return exportButton
    }()
    var shareButton:UIButton = {
        let shareButton = UIButton(type: .system)
        return shareButton
    }()
    var saveButton:UIButton = {
        let saveButton = UIButton(type: .system)
        return saveButton
    }()
    
    func setButtonsLayout(vc:UIViewController){
        vc.view.addSubview(saveButton)
        vc.view.addSubview(shareButton)
        vc.view.addSubview(exportButton)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.leadingAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.leadingAnchor, constant: sdGap).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.bottomAnchor, constant: -sdGap).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: sdButtonHeight).isActive = true
        saveButton.widthAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.adjustsFontSizeToFitWidth = true
        saveButton.backgroundColor = #colorLiteral(red: 0.3106759191, green: 0.6774330139, blue: 0.185857743, alpha: 1)
        saveButton.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        saveButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        saveButton.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        saveButton.layer.cornerRadius = 4
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.leadingAnchor.constraint(equalTo: saveButton.trailingAnchor, constant: sdGap).isActive = true
        shareButton.bottomAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.bottomAnchor, constant: -sdGap).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: sdButtonHeight).isActive = true
        shareButton.trailingAnchor.constraint(equalTo: exportButton.leadingAnchor, constant: -sdGap).isActive = true
        shareButton.setTitle("Share", for: .normal)
        shareButton.titleLabel?.adjustsFontSizeToFitWidth = true
        shareButton.backgroundColor = #colorLiteral(red: 0.6881580949, green: 0.5196806788, blue: 0.1224777326, alpha: 1)
        shareButton.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        shareButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        shareButton.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        shareButton.layer.cornerRadius = 4
        
        exportButton.translatesAutoresizingMaskIntoConstraints = false
        exportButton.bottomAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.bottomAnchor, constant: -sdGap).isActive = true
        exportButton.heightAnchor.constraint(equalToConstant: sdButtonHeight).isActive = true
        exportButton.trailingAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.trailingAnchor, constant: -sdGap).isActive = true
        exportButton.widthAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
        #if targetEnvironment(macCatalyst)
             exportButton.setTitle("Download", for: .normal)
        #else
            exportButton.setTitle("Export", for: .normal)
        #endif
        exportButton.titleLabel?.adjustsFontSizeToFitWidth = true
        exportButton.backgroundColor = #colorLiteral(red: 0.008629960939, green: 0.3736575246, blue: 0.7242882848, alpha: 1)
        exportButton.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        exportButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        exportButton.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        exportButton.layer.cornerRadius = 4
    }
}
