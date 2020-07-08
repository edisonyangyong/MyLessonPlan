//
//  PDFViewController.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/12/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit
import PDFKit
#if !os(iOS)
import Cocoa
#endif

class PDFViewController: UIViewController {
    var jsonModel: JsonModel?
    var pdfDocument: PDFDocument?
    var pdfData: Data?
    var pdfScene = PDFscene()
    var pdfCreator = PDFcreator()
    var lessonPlanCompletion: Int?
    var wholeState: String?
    
    private var shareRequest = ShareRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        print(">>>>>>>>>>>>>>>>>>> the JsonModel that sent to PDF ViewController ")
        print(">>>>>>>>>>>>>>>>>>> Presentation Lecture State: \(String(describing: self.jsonModel!.Item!.Presentation_Lecture_State?.S))")
        print(">>>>>>>>>>>>>>>>>>> Direct Instruction State: \(String(describing: self.jsonModel!.Item!.Direct_Instruction_State?.S))")
        print(">>>>>>>>>>>>>>>>>>> Cooperative Learning State: \(String(describing: self.jsonModel!.Item!.Cooperative_Learning_State?.S))")
        print(">>>>>>>>>>>>>>>>>>> Classroom Discussion State: \(String(describing: self.jsonModel!.Item!.Classroom_Discussion_State?.S))")
        print(">>>>>>>>>>>>>>>>>>> 5 Es (Science) State: \(String(describing: self.jsonModel!.Item!.FiveEs_State?.S))")
        print(">>>>>>>>>>>>>>>>>>> Language Support State: \(String(describing: self.jsonModel!.Item!.ELLP_State?.S))")
        // isCombined 已经在 convertJsonModelToRegularModel 里判断过，所以这里不做再次判断
        print(">>>>>>>>>>>>>>>>>>> isCombined: \(String(describing: self.jsonModel!.Item!.isCombined))")
        
        if let json = jsonModel?.json{
            if let jsonString = String(data: json, encoding: .utf8){
                print(jsonString)
            }
        }
        pdfCreator.jsonModel = self.jsonModel
        // Navigation Bar
        self.setNavigationBar(title: "My Lesson Plan PDF")
        self.addBackNaviButton(title: "Back")
        
        // PDF view
        self.view.addSubview(pdfScene.pdfView)
        pdfScene.pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfScene.pdfView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfScene.pdfView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: sdGap).isActive = true
        pdfScene.pdfView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -sdGap).isActive = true
        pdfScene.pdfView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -sdButtonHeight-2*sdGap).isActive = true
        pdfScene.pdfView.backgroundColor = UIColor.byuhMidGray
        
        // Buttons
        pdfScene.setButtonsLayout(vc: self)
        
        // Target
        pdfScene.saveButton.addTarget(self, action: #selector(saveClicked), for: .touchUpInside)
        pdfScene.exportButton.addTarget(self, action: #selector(exportOrDownloadClicked), for: .touchUpInside)
        pdfScene.shareButton.addTarget(self, action: #selector(shareClicked), for: .touchUpInside)

        // Read a PDF
        //        let url = Bundle.main.url(forResource: "pdf2", withExtension: "pdf")
        //        if let pdfDocument = PDFDocument(url: url!){
        //            pdfScene.pdfView.autoScales = true
        //            pdfScene.pdfView.displayMode = .singlePageContinuous
        //            pdfScene.pdfView.displayDirection = .vertical
        //            pdfScene.pdfView.document = pdfDocument
        //            pdfData  = NSData(contentsOf: url!)
        //        }
        
        //         Create a PDF
        pdfData = pdfCreator.createPDFdata()
        if let data = pdfData {
            pdfScene.pdfView.document = PDFDocument(data: data)
            pdfScene.pdfView.autoScales = true
            pdfScene.pdfView.displayMode = .singlePageContinuous
            pdfScene.pdfView.displayDirection = .vertical
        }
    }
}

// MARK: Functions
extension PDFViewController{
    @objc func shareClicked(){
        if self.lessonPlanCompletion! < 100{
            animatedIn(self.setBlurView())
            animatedIn(self.setPopView(title: "Opps! Please complete your lesson plan first!", content:"Your current lesson plan completion is \(self.lessonPlanCompletion!)%\n\(wholeState!)", textAlignment: .left))
        }else{
            // get the current date
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            let dateText = formatter.string(from: date)
            self.jsonModel?.Item?.Date?.S = dateText
            DispatchQueue.global(qos: .userInitiated).async {
                self.shareRequest.sendRequest(json:(self.jsonModel?.json!)!)
            }
            animatedIn(self.setBlurView())
            animatedIn(self.setPopView(title: "Shared Successfully!", content:"Your lesson plan is now on the cloud. \nYou can now go back to the home page and find your lesson plan in the community.", textAlignment:.center))
        }
    }
    @objc func saveClicked(){
        // get the current date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateText = formatter.string(from: date)
        // save PDF to disk
        // find (document) directory in the SandBox to start
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ).appendingPathComponent("MyLessonPlan-\(dateText).pdf"){
            do{
                try pdfData?.write(to: url)
                #if !targetEnvironment(macCatalyst)
                print(">>>>>>>>>>>>>>>>>> PDF Saved to the Disk Successfully")
                animatedIn(self.setBlurView())
                animatedIn(self.setPopView(title: "PDF Saved Successfully!", content:"This lesson plan PDF file is now saved as MyLessonPlan-\(dateText).pdf on your device.\n\nYou can now find this PDF file in the Files App on this device\n\nYou can also find this PDF file by clicking \"Browse My Lesson Plan PDFs\" in the main page.", textAlignment: .center))
                #else
                print(url)
                let controller = UIDocumentPickerViewController(url: url, in: UIDocumentPickerMode.exportToService)
                present(controller, animated: true)
                #endif
            }catch let error{
                print("couldn't save \(error)")
            }
        }
    }
    @objc func exportOrDownloadClicked(){
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
    
//    // download function
//    @objc func downloadButtonPressed(_ sender: Any) {
//        guard let url = URL(string: "https://www.tutorialspoint.com/swift/swift_tutorial.pdf") else { return }
//        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
//        let downloadTask = urlSession.downloadTask(with: url)
//        print(downloadTask)
//        downloadTask.resume()
//    }
}

// download function
//extension PDFViewController:  URLSessionDownloadDelegate {
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//        print("download Location:", location)
//        // create destination URL with the original pdf name
//        guard let url = downloadTask.originalRequest?.url else { return }
//        let documentsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
//        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
//        // delete original copy
//        try? FileManager.default.removeItem(at: destinationURL)
//        // copy from temp to Document
//        do {
//            try FileManager.default.copyItem(at: location, to: destinationURL)
//            print(destinationURL)
//        } catch let error {
//            print("Copy Error: \(error.localizedDescription)")
//        }
//    }
//}



