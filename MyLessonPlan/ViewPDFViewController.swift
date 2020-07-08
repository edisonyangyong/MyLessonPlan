//
//  ViewPDFViewController.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 6/14/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit
import PDFKit

class ViewPDFViewController: UIViewController {
    
    var jsonModel: JsonModel?
    var pdfDocument: PDFDocument?
    var pdfData: Data?
    var pdfScene = PDFscene()
    var pdfCreator = PDFcreator()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // Navigation Bar
        self.setNavigationBar(title: self.jsonModel!.Item!.LessonTitle!.S)
        self.addBackNaviButton(title: "Back")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
        title: "Export",
        style: .done,
        target: self,
        action: #selector(export))
        
        print(">>>>>>>>>>>>>>>>>>> the JsonModel that sent to PDF ViewController ")
        print(">>>>>>>>>>>>>>>>>>> Presentation Lecture State: \(String(describing: self.jsonModel!.Item!.Presentation_Lecture_State?.S))")
        print(">>>>>>>>>>>>>>>>>>> Direct Instruction State: \(String(describing: self.jsonModel!.Item!.Direct_Instruction_State?.S))")
        print(">>>>>>>>>>>>>>>>>>> Cooperative Learning State: \(String(describing: self.jsonModel!.Item!.Cooperative_Learning_State?.S))")
        print(">>>>>>>>>>>>>>>>>>> Classroom Discussion State: \(String(describing: self.jsonModel!.Item!.Classroom_Discussion_State?.S))")
        print(">>>>>>>>>>>>>>>>>>> 5 Es (Science) State: \(String(describing: self.jsonModel!.Item!.FiveEs_State?.S))")
        print(">>>>>>>>>>>>>>>>>>> Language Support State: \(String(describing: self.jsonModel!.Item!.ELLP_State?.S))")
        
        if jsonModel?.Item?.Presentation_Lecture_State?.S == "combined" ||
            jsonModel?.Item?.Direct_Instruction_State?.S == "combined" ||
            jsonModel?.Item?.Cooperative_Learning_State?.S == "combined" ||
            jsonModel?.Item?.Classroom_Discussion_State?.S == "combined" ||
            jsonModel?.Item?.FiveEs_State?.S == "combined" ||
            jsonModel?.Item?.ELLP_State?.S == "combined"{
            jsonModel?.Item!.isCombined = true
        }else{
            jsonModel?.Item!.isCombined = false
        }
        print(">>>>>>>>>>>>>>>>>>> isCombined: \(String(describing: self.jsonModel!.Item!.isCombined))")
        
        if let json = jsonModel?.json{
            if let jsonString = String(data: json, encoding: .utf8){
                print(jsonString)
            }
        }
        
        // PDF view
        self.view.addSubview(pdfScene.pdfView)
        pdfScene.pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfScene.pdfView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfScene.pdfView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: sdGap).isActive = true
        pdfScene.pdfView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -sdGap).isActive = true
        pdfScene.pdfView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        pdfScene.pdfView.backgroundColor = UIColor.byuhMidGray
        
        pdfCreator.jsonModel = self.jsonModel
        pdfData = pdfCreator.createPDFdata()
        if let data = pdfData {
            pdfScene.pdfView.document = PDFDocument(data: data)
            pdfScene.pdfView.autoScales = true
            pdfScene.pdfView.displayMode = .singlePageContinuous
            pdfScene.pdfView.displayDirection = .vertical
        }
    }
}

// MARK: Function
extension ViewPDFViewController{
    @objc override func navBack(_ sender: UIButton) {
        print("checking!!!!!!!!!!!!!!!!!!")
        self.dismiss(animated: true, completion: nil)
    }
    @objc func export(){
       #if targetEnvironment(macCatalyst)
        // save PDF to disk
        // find (document) directory in the SandBox to start
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ).appendingPathComponent("MyLessonPlan.pdf"){
            do{
                try pdfData?.write(to: url)
                let controller = UIDocumentPickerViewController(url: url, in: UIDocumentPickerMode.exportToService)
                present(controller, animated: true)
            }catch let error{
                print("couldn't save \(error)")
            }
        }
        #else
        let activityViewController = UIActivityViewController(activityItems: [pdfData as Any], applicationActivities: nil)
        if UIDevice.current.userInterfaceIdiom == .pad {
            activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        }
        present(activityViewController,animated: true)
        #endif
    }
}
