//
//  File.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 4/19/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit

extension UIViewController{
    var sdGap:CGFloat{ return 7 }
    var sdButtonHeight:CGFloat{ return 44}
    var bottomViewFrame: CGRect { return  CGRect(x: 0, y: self.view.frame.height-2*sdGap-sdButtonHeight-safeBottom, width: self.view.frame.width, height: 2*sdGap+sdButtonHeight)}
    var sdFontSize:CGFloat{ return 17}
    var navHeight: CGFloat{ return self.navigationController?.navigationBar.frame.size.height ?? 0}
    var sdQuestionMarkSize: CGFloat { return 25}
    var safeTop:CGFloat{
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return window?.safeAreaInsets.top ?? 0
        }else{
            return 0
        }
    }
    var safeBottom: CGFloat{
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return window?.safeAreaInsets.bottom ?? 0
        }else{
            return 0
        }
    }
    var safeLeft: CGFloat{
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return window?.safeAreaInsets.left ?? 0
        }else{
            return 0
        }
    }
    var safeRight: CGFloat{
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return window?.safeAreaInsets.right ?? 0
        }else{
            return 0
        }
    }
    func saveCurrentJsonDataToDiskAndBroadcastReminderUpdating(dataFlow: Model?, animated:Bool = false){
//        print("===========> check data before save")
//        print(dataFlow?.instructionSequence)
        // broadcast reminder and title updating
        let name = Notification.Name(rawValue:NotificationName.broadcastToReloadReminderAndTitle.rawValue)
        NotificationCenter.default.post(name:name, object:nil)
        print(">>>>>>>>>>>>>>>>>>> Broadcast Reminder and Completion Process updating")
        
        // also broadcast mainView update its dataflow
        let name2 = Notification.Name(rawValue:NotificationName.notifyMainViewToUpdateDataFlow.rawValue)
        NotificationCenter.default.post(name:name2, object:dataFlow)
        print(">>>>>>>>>>>>>>>>>>> Notified Main View to Update the Data Flow")
        
        if animated{
            // Changes Successfully Saved
            var saveButton:UIButton? = UIButton()
            self.view.addSubview(saveButton!)
            saveButton!.translatesAutoresizingMaskIntoConstraints = false
            saveButton!.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
            saveButton!.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
            saveButton!.widthAnchor.constraint(equalToConstant: 250).isActive = true
            saveButton!.heightAnchor.constraint(equalToConstant: 30).isActive = true
            saveButton!.backgroundColor = #colorLiteral(red: 0.3106759191, green: 0.6774330139, blue: 0.185857743, alpha: 1)
            saveButton!.layer.cornerRadius = 0.5*30
            saveButton!.setTitle("Changes Successfully Saved", for: .normal)
            saveButton!.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
            saveButton!.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            saveButton!.titleLabel?.adjustsFontSizeToFitWidth = true
            saveButton!.alpha = 0
            
            UIView.animate(
                withDuration: 0.25,
                animations: {
                    saveButton!.alpha = 1
            },
                completion: { finished in
                    UIView.animate(
                        withDuration: 1.5,
                        animations: {
                            saveButton!.alpha = 0
                    },
                        completion: { finished in
                            saveButton = nil
                    })
            })
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            dataFlow?.convertRegularModelToJsonModel()
            // save JSON to disk
            if let json = dataFlow?.jsonModel.json{
                // find (document) directory in the SandBox to start
                if let url = try? FileManager.default.url(
                    for: .documentDirectory,
                    in: .userDomainMask,
                    appropriateFor: nil,
                    create: true
                ).appendingPathComponent("MyCurrentLessonPlanBackUp.json"){
                    do{
                        try json.write(to: url)
                        print(">>>>>>>>>>>>>>>>>>> Save Json to the Disk Successfully")
//                        print(">>>>>>>>>>>>>>>>>> check saved Json File")
//                        print(dataFlow?.jsonModel.Item?.Language_Support_Content_Topic_One)
//                        print(dataFlow?.jsonModel.Item?.Combined_Content_Topic_Two)
//                        print(dataFlow?.jsonModel.Item?.Combined_Content_Topic_Three)
//                        print(dataFlow?.jsonModel.Item?.Combined_Meaningful_Activity_One)
//                        print(dataFlow?.jsonModel.Item?.Combined_Meaningful_Activity_Two)
//                        print(dataFlow?.jsonModel.Item?.Combined_Meaningful_Activity_Three)
//                        print(dataFlow?.jsonModel.Item?.Combined_Check_Understanding_One)
//                        print(dataFlow?.jsonModel.Item?.Combined_Check_Understanding_Two)
//                        print(dataFlow?.jsonModel.Item?.Combined_Check_Understanding_Three)
                    }catch let error{
                        print("couldn't save \(error)")
                    }
                }
            }
        }
    }
    func setAndGetQuestionMarkOnRoadMap(to cell: UITableViewCell) -> UIButton{
        let questionMarkOnRoadMap = UIButton()
        questionMarkOnRoadMap.tag = 0
        cell.addSubview(questionMarkOnRoadMap)
        questionMarkOnRoadMap.translatesAutoresizingMaskIntoConstraints = false
        questionMarkOnRoadMap.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -15-safeLeft).isActive = true
        questionMarkOnRoadMap.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -5-44).isActive = true
        questionMarkOnRoadMap.widthAnchor.constraint(equalToConstant: sdQuestionMarkSize).isActive = true
        questionMarkOnRoadMap.heightAnchor.constraint(equalToConstant: sdQuestionMarkSize).isActive = true
        questionMarkOnRoadMap.setImage(UIImage(named: "questionMark"), for: .normal)
        return questionMarkOnRoadMap
    }
    func addBottomView(){
        let bottomView = UIView()
        self.view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 2*sdGap+sdButtonHeight).isActive = true
        bottomView.backgroundColor = .white
    }
    func addAndGetPDFButton()->UIButton{
        let pdfButton = UIButton(type: .system)
        self.view.addSubview(pdfButton)
        pdfButton.translatesAutoresizingMaskIntoConstraints = false
        pdfButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: sdGap).isActive = true
        pdfButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/3, constant: -sdGap).isActive = true
        pdfButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -sdGap).isActive = true
        pdfButton.heightAnchor.constraint(equalToConstant: sdButtonHeight).isActive = true
        pdfButton.setTitle("Create PDF 📄", for: .normal)
        pdfButton.titleLabel?.adjustsFontSizeToFitWidth = true
        pdfButton.backgroundColor = #colorLiteral(red: 0.3106759191, green: 0.6774330139, blue: 0.185857743, alpha: 1)
        pdfButton.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pdfButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pdfButton.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        pdfButton.layer.cornerRadius = 4
        return pdfButton
    }
    func addAndGetContinueButton(title t:String) -> UIButton{
        let continueButton = UIButton(type: .system)
        self.view.addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -sdGap).isActive = true
        continueButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -sdGap).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: sdButtonHeight).isActive = true
        continueButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 2/3, constant: -2*sdGap).isActive = true
        continueButton.setTitle(t, for: .normal)
        continueButton.titleLabel?.numberOfLines = 0
        continueButton.titleLabel?.adjustsFontSizeToFitWidth = true
        continueButton.titleLabel?.textAlignment = .center
        continueButton.backgroundColor = #colorLiteral(red: 0.008629960939, green: 0.3736575246, blue: 0.7242882848, alpha: 1)
        continueButton.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        continueButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        continueButton.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        continueButton.layer.cornerRadius = 4
        return continueButton
    }
    func addAndGetMainTableView()->UITableView{
        let mainTableView = UITableView(frame: CGRect(), style: .plain)
        self.view.addSubview(mainTableView)
        mainTableView.backgroundColor = UIColor.byuHlightGray
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mainTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -2*sdGap-sdButtonHeight).isActive = true
        return mainTableView
    }
    func setNavigationBar(title t:String){
        let navTitleLable = UILabel()
        navTitleLable.font = UIFont(name: "GillSans-Bold", size: 25)
        navTitleLable.adjustsFontSizeToFitWidth = true
        navTitleLable.text = t
        navTitleLable.textAlignment = .center
        navTitleLable.numberOfLines = 2
        navTitleLable.textColor = .white
        self.navigationItem.titleView = navTitleLable
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.6058552265, green: 0.120728381, blue: 0.2143063247, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                                                                        NSAttributedString.Key.font: UIFont(name: "GillSans-Bold", size: 25)!]
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Home",
            style: .done,
            target: self,
            action: #selector(goHome))
    }
    func addBackNaviButton(title t:String){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: t,
            style: .done,
            target: self,
            action: #selector(navBack))
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    @objc func navBack(_ sender: UIButton) {
       switch self.title {
        case "InfoViewController":
            InfoViewController.isVisited = false
       case "ContentStandardViewController":
            ContentStandardViewController.isVisited = false
        case "ObjectivesViewController":
            ObjectivesViewController.isVisited = false
        case "SummativeViewController":
            SummativeViewController.isVisited = false
        case "AnticipatoryViewController":
            AnticipatoryViewController.isVisited = false
        case "InstructionViewController":
            InstructionViewController.isVisited = false
        case "ClosureViewController":
            ClosureViewController.isVisited = false
        case "BackgroundViewController":
            BackgroundViewController.isVisited = false
        case "LessonViewController":
            LessonViewController.isVisited = false
        default:
            print()
        }
        switch self.presentingViewController!.title {
        case "InfoViewController":
            if !InfoViewController.isVisited{
                self.goHome()
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        case "ContentStandardViewController":
            if !ContentStandardViewController.isVisited{
                self.goHome()
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        case "ObjectivesViewController":
            if !ObjectivesViewController.isVisited{
                self.goHome()
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        case "SummativeViewController":
            if !SummativeViewController.isVisited{
                self.goHome()
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        case "AnticipatoryViewController":
            if !AnticipatoryViewController.isVisited{
                self.goHome()
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        case "InstructionViewController":
            if !InstructionViewController.isVisited{
                self.goHome()
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        case "ClosureViewController":
            if !ClosureViewController.isVisited{
                self.goHome()
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        case "BackgroundViewController":
            if !BackgroundViewController.isVisited{
                self.goHome()
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        case "LessonViewController":
            if !LessonViewController.isVisited{
                self.goHome()
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        default:
            self.dismiss(animated: true, completion: nil)
        }
    }
    @objc func goHome(){
        InfoViewController.isVisited = false
        ObjectivesViewController.isVisited = false
        SummativeViewController.isVisited = false
        AnticipatoryViewController.isVisited = false
        InstructionViewController.isVisited = false
        ClosureViewController.isVisited = false
        BackgroundViewController.isVisited = false
        LessonViewController.isVisited = false
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: true)
    }
    func setBlurView() -> UIVisualEffectView{
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.tag = 810
        self.view.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        blurView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        return blurView
    }
    func setPopView(title t :String, content c :String, title2 t2:String = "", content2 c2: String = "", textAlignment:NSTextAlignment) -> UIView{
        let popView = UIView()
        popView.tag = 808
        popView.layer.cornerRadius = 4
        popView.clipsToBounds = true
        popView.translatesAutoresizingMaskIntoConstraints = false
        popView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        view.addSubview(popView)
//        popView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        popView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        popView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
//        popView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8).isActive = true
        
        popView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        popView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        #if targetEnvironment(macCatalyst)
        popView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75).isActive = true
        popView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        #else
        popView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        popView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        #endif
        
        let popButton = UIButton(type: .system)
        popButton.backgroundColor = #colorLiteral(red: 0.1809800863, green: 0.5333758593, blue: 0.9840556979, alpha: 1)
        popButton.setTitle("Done", for: .normal)
        popButton.titleLabel?.textAlignment = .center
        popButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        popView.addSubview(popButton)
        popButton.translatesAutoresizingMaskIntoConstraints = false
        popButton.leadingAnchor.constraint(equalTo: popView.leadingAnchor).isActive = true
        popButton.trailingAnchor.constraint(equalTo: popView.trailingAnchor).isActive = true
        popButton.bottomAnchor.constraint(equalTo: popView.bottomAnchor).isActive = true
        popButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        popButton.addTarget(self, action: #selector(dissmissClicked(_ :)), for: .touchUpInside)
        
        let popTopLabel = UILabel()
        popView.addSubview(popTopLabel)
        popTopLabel.translatesAutoresizingMaskIntoConstraints = false
        popTopLabel.topAnchor.constraint(equalTo: popView.topAnchor).isActive = true
        popTopLabel.leadingAnchor.constraint(equalTo: popView.leadingAnchor).isActive = true
        popTopLabel.trailingAnchor.constraint(equalTo: popView.trailingAnchor).isActive = true
        popTopLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        popTopLabel.text = t
        popTopLabel.textAlignment = .center
        #if targetEnvironment(macCatalyst)
        popTopLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        #else
        popTopLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        #endif
        popTopLabel.textColor = .black
        popTopLabel.adjustsFontSizeToFitWidth = true
        let popContentTextView1 = UITextView()
        popView.addSubview(popContentTextView1)
        popContentTextView1.translatesAutoresizingMaskIntoConstraints = false
        popContentTextView1.text = c
        popContentTextView1.textAlignment = textAlignment
        popContentTextView1.backgroundColor = .white
        popContentTextView1.textColor = .black
        popContentTextView1.isEditable = false
        #if targetEnvironment(macCatalyst)
        popContentTextView1.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        #else
        popContentTextView1.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17)
        #endif
        popContentTextView1.scrollRangeToVisible(NSMakeRange(0, 0))
        
        if t2 == ""{
            popContentTextView1.topAnchor.constraint(equalTo: popTopLabel.bottomAnchor).isActive = true
            popContentTextView1.bottomAnchor.constraint(equalTo: popView.bottomAnchor, constant: -40).isActive = true
            popContentTextView1.leadingAnchor.constraint(equalTo: popView.leadingAnchor,constant: sdGap).isActive = true
            popContentTextView1.trailingAnchor.constraint(equalTo: popView.trailingAnchor, constant: -sdGap).isActive = true
        }else{
            popContentTextView1.topAnchor.constraint(equalTo: popTopLabel.bottomAnchor).isActive = true
            popContentTextView1.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1).isActive = true
            popContentTextView1.leadingAnchor.constraint(equalTo: popView.leadingAnchor,constant: sdGap).isActive = true
            popContentTextView1.trailingAnchor.constraint(equalTo: popView.trailingAnchor, constant: -sdGap).isActive = true
            
            let popTopLabel2 = UILabel()
            popView.addSubview(popTopLabel2)
            popTopLabel2.text = t2
            popTopLabel2.textAlignment = .center
            #if targetEnvironment(macCatalyst)
            popTopLabel2.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
            #else
            popTopLabel2.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
            #endif
            popTopLabel2.textColor = .black
            popTopLabel2.adjustsFontSizeToFitWidth = true
            popTopLabel2.translatesAutoresizingMaskIntoConstraints = false
            popTopLabel2.topAnchor.constraint(equalTo: popContentTextView1.bottomAnchor).isActive = true
            popTopLabel2.leadingAnchor.constraint(equalTo: popView.leadingAnchor).isActive = true
            popTopLabel2.trailingAnchor.constraint(equalTo: popView.trailingAnchor).isActive = true
            popTopLabel2.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            let popContentTextView2 = UITextView()
            popView.addSubview(popContentTextView2)
            popContentTextView2.translatesAutoresizingMaskIntoConstraints = false
            popContentTextView2.text = c2
            popContentTextView2.textAlignment = textAlignment
            popContentTextView2.backgroundColor = .white
            popContentTextView2.textColor = .black
            popContentTextView2.isEditable = false
            popContentTextView2.scrollRangeToVisible(NSMakeRange(0, 0))
            #if targetEnvironment(macCatalyst)
            popContentTextView2.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
            #else
            popContentTextView2.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17)
            #endif
            popContentTextView2.topAnchor.constraint(equalTo: popTopLabel2.bottomAnchor).isActive = true
            popContentTextView2.bottomAnchor.constraint(equalTo: popView.bottomAnchor, constant: -40).isActive = true
            popContentTextView2.leadingAnchor.constraint(equalTo: popView.leadingAnchor,constant: sdGap).isActive = true
            popContentTextView2.trailingAnchor.constraint(equalTo: popView.trailingAnchor, constant: -sdGap).isActive = true
        }
        return popView
    }

    @objc func dissmissClicked( _ : UIButton){
        for view in self.view.subviews{
            if view.tag == 808 || view.tag == 810{
                animatedout(view)
            }
        }
    }
    func animatedIn(_ desiredView:UIView){
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.3,
            delay: 0,
            options: [],
            animations: {desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                desiredView.alpha = 1}
        )
    }
    func animatedout(_ desiredView:UIView){
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.3,
            delay: 0,
            options: [],
            animations: {desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                desiredView.alpha = 0
        },
            completion: { _ in
                desiredView.removeFromSuperview()
        })
    }
    func setAnimatedChose(to view:UIView){
        let animatedChose = UIImageView()
        animatedChose.image = #imageLiteral(resourceName: "chose")
        view.addSubview(animatedChose)
        animatedChose.translatesAutoresizingMaskIntoConstraints = false
        animatedChose.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5-safeLeft).isActive = true
        animatedChose.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        animatedChose.widthAnchor.constraint(equalToConstant: 44).isActive = true
        animatedChose.heightAnchor.constraint(equalToConstant: 44).isActive = true
        UIImageView.animate(
            withDuration: 2,
            delay: 0,
            options: [],
            animations: {
                UIImageView.modifyAnimations(
                    withRepeatCount: CGFloat.infinity,
                    autoreverses: true,
                    animations: {
                        animatedChose.alpha = 0
                })
        })
    }
    func addAnimatedIcon(to view:UIView, in f:CGRect, image:UIImage){
        for subview in view.subviews{
            if subview.tag == 1359{
                subview.removeFromSuperview()
            }
        }
        let animatedPoint = UIImageView()
        animatedPoint.tag = 1359
        animatedPoint.image = image
        view.addSubview(animatedPoint)
        animatedPoint.frame = f
        UIImageView.animate(
            withDuration: 2,
            delay: 0,
            options: [],
            animations: {
                UIImageView.modifyAnimations(
                    withRepeatCount: CGFloat.infinity,
                    autoreverses: true,
                    animations: {
                        animatedPoint.alpha = 0
                })
        })
    }
    func setAnimatedSwipe(to view:UIView, in f:CGRect, offset:Int){
        for subview in view.subviews{
            if subview.tag == 12345{
                subview.removeFromSuperview()
            }
        }
        let animatedSwipe = UIImageView()
        animatedSwipe.image = #imageLiteral(resourceName: "swipe")
        animatedSwipe.tag = 12345
        view.addSubview(animatedSwipe)
        animatedSwipe.frame = f
        UIImageView.animate(
            withDuration: 2,
            delay: 0,
            options: [],
            animations: {
                UIImageView.modifyAnimations(
                    withRepeatCount: CGFloat.infinity,
                    autoreverses: true,
                    animations: {
                        animatedSwipe.frame = CGRect(x: f.minX, y: f.minY+view.frame.height/CGFloat(offset)-f.height, width: f.width, height: f.height)
                })
        })
    }
    func setReminderCollectionView() -> UICollectionView{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let collectionView = UICollectionView(frame: CGRect(x: sdGap, y: 0, width: self.view.frame.width-sdGap, height: 200), collectionViewLayout: layout)
        collectionView.register(ReminderCollectionViewCell.self, forCellWithReuseIdentifier: "ReminderCollectionViewCell")
        collectionView.backgroundColor = UIColor.byuHlightGray
        return collectionView
    }
    func setReminderTitleAndGetQuestionMark(percentage: Int = 0, cell:UITableViewCell) -> UIImageView{
        let titleView = UIView()
        let titleLabel = UILabel()
        titleView.addSubview(titleLabel)
        let attributedText = NSMutableAttributedString(string: "My Lesson Plan Completion: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedText.append(NSAttributedString(string: "\(percentage)%", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0.7114645243, blue: 0, alpha: 1)]))
        titleLabel.attributedText = attributedText
        titleLabel.tag = 0
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect(x: 0, y: sdGap, width: 0, height: 35)
        titleLabel.sizeToFit()
        titleLabel.center.x = self.view.frame.width/2
        let questionMark = UIImageView()
        questionMark.image = #imageLiteral(resourceName: "questionMark")
        questionMark.tag = 2
        questionMark.isUserInteractionEnabled = true
        questionMark.frame = CGRect(x: titleLabel.frame.maxX+sdGap, y:  titleLabel.frame.minY+5, width: sdQuestionMarkSize, height: sdQuestionMarkSize)
        
        let pathView = PathView()
        pathView.tag = 1
        pathView.percentage = CGFloat(percentage)
        pathView.backgroundColor = UIColor.byuHlightGray
        pathView.frame = CGRect(x:  titleLabel.frame.minX-50, y: titleLabel.frame.maxY + sdGap, width: titleLabel.frame.width+100, height: 10)
        titleView.addSubview(pathView)
        cell.addSubview(titleView)
        cell.addSubview(questionMark)
        return questionMark
    }
    class PathView: UIView {
        var percentage = CGFloat(0)
        override func draw(_ rect: CGRect) {
            let path1 = UIBezierPath()
            path1.move(to: CGPoint(x: 0, y: 0))
            path1.addLine(to: CGPoint(x: self.frame.width, y: 0))
            UIColor.gray.setStroke()
            path1.lineWidth = 10
            path1.stroke(with: .normal, alpha: 0.5)
            
            let path2 = UIBezierPath()
            path2.move(to: CGPoint(x: 0, y: 0))
            path2.addLine(to: CGPoint(x: self.frame.width*percentage/100, y: 0))
           #colorLiteral(red: 0, green: 0.7114645243, blue: 0, alpha: 1).setStroke()
            path2.lineWidth = 8
            path2.stroke()
        }
    }
    func updateCellfromModel(from model: Model, to cell: ReminderCollectionViewCell, indexPath: IndexPath){
        cell.textView.text = model.reminderCardsTextViewContent[indexPath.item]
    }
    func updateCollectionViewAndTitleViewfromModel(from model: Model, to tableView: UITableView){
        var shouldReload = false
        if let tableViewCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)){
            if let pathView = tableViewCell.subviews[2].viewWithTag(1) as? PathView{
                shouldReload = (pathView.percentage == CGFloat(model.lessonPlanCompletion)) ? false:true
                pathView.percentage = CGFloat(model.lessonPlanCompletion)
            }
            if let titleView = tableViewCell.subviews[2].viewWithTag(0) as? UILabel{
                let attributedText = NSMutableAttributedString(string: "My Lesson Plan Completion: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.black])
                attributedText.append(NSAttributedString(string: "\(model.lessonPlanCompletion)%", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.3106759191, green: 0.6774330139, blue: 0.185857743, alpha: 1)]))
                titleView.attributedText = attributedText
            }
            if shouldReload{
                tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
            }
        }
        if let tableViewCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)){
            let reminderCollectionView = tableViewCell.subviews[1] as! UICollectionView
            for cell in reminderCollectionView.visibleCells{
                self.updateCellfromModel(from: model, to: cell as! ReminderCollectionViewCell, indexPath: reminderCollectionView.indexPath(for: cell)!)
                reminderCollectionView.reloadItems(at: [reminderCollectionView.indexPath(for: cell)!])
            }
        }
    }
}

extension UIView{
    var sdGap:CGFloat{ return 7 }
    var sdButtonHeight:CGFloat{ return 44}
    var bottomViewFrame: CGRect {
        let temp = UIScreen.main.bounds.height-2*sdGap-sdButtonHeight-safeBottom
        return  CGRect(x: 0, y: temp, width: UIScreen.main.bounds.width, height: 2*sdGap+sdButtonHeight)}
    var sdFontSize:CGFloat{ return 17}
    var safeTop:CGFloat{
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return window?.safeAreaInsets.top ?? 0
        }else{
            return 0
        }
    }
    var safeBottom: CGFloat{
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return window?.safeAreaInsets.bottom ?? 0
        }else{
            return 0
        }
    }
    var safeLeft: CGFloat{
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return window?.safeAreaInsets.left ?? 0
        }else{
            return 0
        }
    }
    var safeRight: CGFloat{
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return window?.safeAreaInsets.right ?? 0
        }else{
            return 0
        }
    }
    func pin(to superView: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
    func addDashedBorder(width: CGFloat? = nil, height: CGFloat? = nil, lineWidth: CGFloat = 2, lineDashPattern:[NSNumber]? = [6,3], strokeColor: UIColor = UIColor.red, fillColor: UIColor = UIColor.clear) {
        var fWidth: CGFloat? = width
        var fHeight: CGFloat? = height
        if fWidth == nil {
            fWidth = self.frame.width
        }
        if fHeight == nil {
            fHeight = self.frame.height
        }
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let shapeRect = CGRect(x: 0, y: 0, width: fWidth!, height: fHeight!)
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: fWidth!/2, y: fHeight!/2)
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = lineDashPattern
        shapeLayer.name = "kShapeDashed"
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        self.layer.addSublayer(shapeLayer)
    }
    // Draw Star
    func degree2radian(a:CGFloat)->CGFloat {
        let b = CGFloat(Double.pi) * a/180
        return b
    }
    func polygonPointArray(sides:Int,x:CGFloat,y:CGFloat,radius:CGFloat,adjustment:CGFloat=0)->[CGPoint] {
        let angle = degree2radian(a: 360/CGFloat(sides))
        let cx = x // x origin
        let cy = y // y origin
        let r  = radius // radius of circle
        var i = sides
        var points = [CGPoint]()
        while points.count <= sides {
            let xpo = cx - r * cos(angle * CGFloat(i)+degree2radian(a: adjustment))
            let ypo = cy - r * sin(angle * CGFloat(i)+degree2radian(a: adjustment))
            points.append(CGPoint(x: xpo, y: ypo))
            i -= 1;
        }
        return points
    }
    func starPath(x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, pointyness:CGFloat, startAngle:CGFloat=0) -> CGPath {
        let adjustment = startAngle + CGFloat(360/sides/2)
        let path = CGMutablePath.init()
        let points = polygonPointArray(sides: sides,x: x,y: y,radius: radius, adjustment: startAngle)
        let cpg = points[0]
        let points2 = polygonPointArray(sides: sides,x: x,y: y,radius: radius*pointyness,adjustment:CGFloat(adjustment))
        var i = 0
        path.move(to: CGPoint(x:cpg.x,y:cpg.y))
        for p in points {
            path.addLine(to: CGPoint(x:points2[i].x, y:points2[i].y))
            path.addLine(to: CGPoint(x:p.x, y:p.y))
            i += 1
        }
        path.closeSubpath()
        return path
    }
    func drawStarBezier(x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, pointyness:CGFloat) -> UIBezierPath {
        let startAngle = CGFloat(-1*(360/sides/4)) //start the star off rotated left a quarter of the angle of the sides so that its bottom points appear flat (at least for 5 sided stars)
        let path = starPath(x: x, y: y, radius: radius, sides: sides, pointyness: pointyness, startAngle: startAngle)
        let bez = UIBezierPath(cgPath: path)
        return bez
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.circleColor = .white
        switch sequenceTyped {
        case .pdf:
            transition.startingPoint = CGPoint(x: sdGap+UIScreen.main.bounds.width/6, y: UIScreen.main.bounds.height-safeBottom-sdButtonHeight/2-sdGap)
        case .content:
            transition.startingPoint = CGPoint(x: mainScene.contenttv.center.x, y: mainScene.contenttv.center.y+safeTop+navHeight)
        //            transition.startingPoint = contenttv.center
        case .objectives:
            transition.startingPoint = CGPoint(x: mainScene.objectivestv.center.x, y: mainScene.objectivestv.center.y+safeTop+navHeight)
        case .summative:
            transition.startingPoint = CGPoint(x: mainScene.summativetv.center.x, y: mainScene.summativetv.center.y+safeTop+navHeight)
        //            transition.startingPoint = summativetv.center
        case .anticipatory:
            transition.startingPoint = CGPoint(x: mainScene.anticipatorytv.center.x, y: mainScene.anticipatorytv.center.y+safeTop+navHeight)
        //            transition.startingPoint = anticipatorytv.center
        case .instruction:
            transition.startingPoint = CGPoint(x: mainScene.instructiontv.center.x, y: mainScene.instructiontv.center.y+safeTop+navHeight)
        //            transition.startingPoint = instructiontv.center
        case .closure:
            transition.startingPoint = CGPoint(x: mainScene.closuretv.center.x, y: mainScene.closuretv.center.y+safeTop+navHeight)
        //            transition.startingPoint = closuretv.center
        case .background:
            transition.startingPoint = CGPoint(x: mainScene.backgroundtv.center.x, y: mainScene.backgroundtv.center.y+safeTop+navHeight)
        //            transition.startingPoint = backgroundtv.center
        case .lesson:
            transition.startingPoint = CGPoint(x: mainScene.lessontv.center.x, y: mainScene.lessontv.center.y+safeTop+navHeight)
        //            transition.startingPoint = lessontv.center
        default:
            transition.startingPoint = CGPoint(x: 0, y: 0)
        }
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = CGPoint(x: 0, y: 0)
        transition.circleColor = .white
        return transition
    }
}

extension InfoViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.circleColor = .white
        switch sequenceTyped {
        case .pdf:
            transition.startingPoint = CGPoint(x: sdGap+UIScreen.main.bounds.width/6, y: UIScreen.main.bounds.height-safeBottom-sdButtonHeight/2-sdGap)
        case .content:
            transition.startingPoint = CGPoint(x: infoScene.contenttv.center.x, y: infoScene.contenttv.center.y+safeTop+navHeight)
        case .objectives:
            transition.startingPoint = CGPoint(x: infoScene.objectivestv.center.x, y: infoScene.objectivestv.center.y+safeTop+navHeight)
        case .summative:
            transition.startingPoint = CGPoint(x: infoScene.summativetv.center.x, y: infoScene.summativetv.center.y+safeTop+navHeight)
        case .anticipatory:
            transition.startingPoint = CGPoint(x: infoScene.anticipatorytv.center.x, y: infoScene.anticipatorytv.center.y+safeTop+navHeight)
        case .instruction:
            transition.startingPoint = CGPoint(x: infoScene.instructiontv.center.x, y: infoScene.instructiontv.center.y+safeTop+navHeight)
        case .closure:
            transition.startingPoint = CGPoint(x: infoScene.closuretv.center.x, y: infoScene.closuretv.center.y+safeTop+navHeight)
        case .background:
            transition.startingPoint = CGPoint(x: infoScene.backgroundtv.center.x, y: infoScene.backgroundtv.center.y+safeTop+navHeight)
        case .lesson:
            transition.startingPoint = CGPoint(x: infoScene.lessontv.center.x, y: infoScene.lessontv.center.y+safeTop+navHeight)
        default:
            transition.startingPoint = CGPoint(x: 0, y: 0)
        }
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = CGPoint(x: 0, y: 0)
        transition.circleColor = .white
        return transition
    }
}

extension ContentStandardViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.circleColor = .white
        switch sequenceTyped {
        case .pdf:
            transition.startingPoint = CGPoint(x: sdGap+UIScreen.main.bounds.width/6, y: UIScreen.main.bounds.height-safeBottom-sdButtonHeight/2-sdGap)
        case .content:
            transition.startingPoint = CGPoint(x: contentScene.contenttv.center.x, y: contentScene.contenttv.center.y+safeTop+navHeight)
        case .objectives:
            transition.startingPoint = CGPoint(x: contentScene.objectivestv.center.x, y: contentScene.summativetv.center.y+safeTop+navHeight)
        case .anticipatory:
            transition.startingPoint = CGPoint(x: contentScene.anticipatorytv.center.x, y: contentScene.anticipatorytv.center.y+safeTop+navHeight)
        case .instruction:
            transition.startingPoint = CGPoint(x: contentScene.instructiontv.center.x, y: contentScene.instructiontv.center.y+safeTop+navHeight)
        case .closure:
            transition.startingPoint = CGPoint(x: contentScene.closuretv.center.x, y: contentScene.closuretv.center.y+safeTop+navHeight)
        case .background:
            transition.startingPoint = CGPoint(x: contentScene.backgroundtv.center.x, y: contentScene.backgroundtv.center.y+safeTop+navHeight)
        case .lesson:
            transition.startingPoint = CGPoint(x: contentScene.lessontv.center.x, y: contentScene.lessontv.center.y+safeTop+navHeight)
        default:
            transition.startingPoint = CGPoint(x: 0, y: 0)
        }
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = CGPoint(x: 0, y: 0)
        transition.circleColor = .white
        return transition
    }
}

extension ObjectivesViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.circleColor = .white
        switch sequenceTyped {
        case .pdf:
            transition.startingPoint = CGPoint(x: sdGap+UIScreen.main.bounds.width/6, y: UIScreen.main.bounds.height-safeBottom-sdButtonHeight/2-sdGap)
        case .content:
            transition.startingPoint = CGPoint(x: objectiveScene.contenttv.center.x, y: objectiveScene.contenttv.center.y+safeTop+navHeight)
        case .objectives:
            transition.startingPoint = CGPoint(x: objectiveScene.objectivestv.center.x, y: objectiveScene.objectivestv.center.y+safeTop+navHeight)
        case .summative:
            transition.startingPoint = CGPoint(x: objectiveScene.summativetv.center.x, y: objectiveScene.summativetv.center.y+safeTop+navHeight)
        case .anticipatory:
            transition.startingPoint = CGPoint(x: objectiveScene.anticipatorytv.center.x, y: objectiveScene.anticipatorytv.center.y+safeTop+navHeight)
        case .instruction:
            transition.startingPoint = CGPoint(x: objectiveScene.instructiontv.center.x, y: objectiveScene.instructiontv.center.y+safeTop+navHeight)
        case .closure:
            transition.startingPoint = CGPoint(x: objectiveScene.closuretv.center.x, y: objectiveScene.closuretv.center.y+safeTop+navHeight)
        case .background:
            transition.startingPoint = CGPoint(x: objectiveScene.backgroundtv.center.x, y: objectiveScene.backgroundtv.center.y+safeTop+navHeight)
        case .lesson:
            transition.startingPoint = CGPoint(x: objectiveScene.lessontv.center.x, y: objectiveScene.lessontv.center.y+safeTop+navHeight)
        default:
            transition.startingPoint = CGPoint(x: 0, y: 0)
        }
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = CGPoint(x: 0, y: 0)
        transition.circleColor = .white
        return transition
    }
}

extension SummativeViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.circleColor = .white
        switch sequenceTyped {
        case .pdf:
            transition.startingPoint = CGPoint(x: sdGap+UIScreen.main.bounds.width/6, y: UIScreen.main.bounds.height-safeBottom-sdButtonHeight/2-sdGap)
        case .content:
            transition.startingPoint = CGPoint(x: summativeScene.contenttv.center.x, y: summativeScene.contenttv.center.y+safeTop+navHeight)
        case .objectives:
            transition.startingPoint = CGPoint(x: summativeScene.objectivestv.center.x, y: summativeScene.objectivestv.center.y+safeTop+navHeight)
        case .summative:
            transition.startingPoint = CGPoint(x: summativeScene.summativetv.center.x, y: summativeScene.summativetv.center.y+safeTop+navHeight)
        case .anticipatory:
            transition.startingPoint = CGPoint(x: summativeScene.anticipatorytv.center.x, y: summativeScene.anticipatorytv.center.y+safeTop+navHeight)
        case .instruction:
            transition.startingPoint = CGPoint(x: summativeScene.instructiontv.center.x, y: summativeScene.instructiontv.center.y+safeTop+navHeight)
        case .closure:
            transition.startingPoint = CGPoint(x: summativeScene.closuretv.center.x, y: summativeScene.closuretv.center.y+safeTop+navHeight)
        case .background:
            transition.startingPoint = CGPoint(x: summativeScene.backgroundtv.center.x, y: summativeScene.backgroundtv.center.y+safeTop+navHeight)
        case .lesson:
            transition.startingPoint = CGPoint(x: summativeScene.lessontv.center.x, y: summativeScene.lessontv.center.y+safeTop+navHeight)
        default:
            transition.startingPoint = CGPoint(x: 0, y: 0)
        }
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = CGPoint(x: 0, y: 0)
        transition.circleColor = .white
        return transition
    }
}

extension AnticipatoryViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.circleColor = .white
        switch sequenceTyped {
        case .pdf:
            transition.startingPoint = CGPoint(x: sdGap+UIScreen.main.bounds.width/6, y: UIScreen.main.bounds.height-safeBottom-sdButtonHeight/2-sdGap)
        case .content:
            transition.startingPoint = CGPoint(x:anticipatoryScene.contenttv.center.x, y: anticipatoryScene.contenttv.center.y+safeTop+navHeight)
        case .objectives:
            transition.startingPoint = CGPoint(x: anticipatoryScene.objectivestv.center.x, y: anticipatoryScene.objectivestv.center.y+safeTop+navHeight)
        case .summative:
            transition.startingPoint = CGPoint(x: anticipatoryScene.summativetv.center.x, y: anticipatoryScene.summativetv.center.y+safeTop+navHeight)
        case .anticipatory:
            transition.startingPoint = CGPoint(x: anticipatoryScene.anticipatorytv.center.x, y: anticipatoryScene.anticipatorytv.center.y+safeTop+navHeight)
        case .instruction:
            transition.startingPoint = CGPoint(x: anticipatoryScene.instructiontv.center.x, y: anticipatoryScene.instructiontv.center.y+safeTop+navHeight)
        case .closure:
            transition.startingPoint = CGPoint(x: anticipatoryScene.closuretv.center.x, y: anticipatoryScene.closuretv.center.y+safeTop+navHeight)
        case .background:
            transition.startingPoint = CGPoint(x: anticipatoryScene.backgroundtv.center.x, y: anticipatoryScene.backgroundtv.center.y+safeTop+navHeight)
        case .lesson:
            transition.startingPoint = CGPoint(x: anticipatoryScene.lessontv.center.x, y: anticipatoryScene.lessontv.center.y+safeTop+navHeight)
        default:
            transition.startingPoint = CGPoint(x: 0, y: 0)
        }
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = CGPoint(x: 0, y: 0)
        transition.circleColor = .white
        return transition
    }
}

extension InstructionViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.circleColor = .white
        switch sequenceTyped {
        case .pdf:
            transition.startingPoint = CGPoint(x: sdGap+UIScreen.main.bounds.width/6, y: UIScreen.main.bounds.height-safeBottom-sdButtonHeight/2-sdGap)
        case .content:
            transition.startingPoint = CGPoint(x: instructionScene.contenttv.center.x, y: instructionScene.contenttv.center.y+safeTop+navHeight)
        case .objectives:
            transition.startingPoint = CGPoint(x: instructionScene.objectivestv.center.x, y: instructionScene.objectivestv.center.y+safeTop+navHeight)
        case .summative:
            transition.startingPoint = CGPoint(x: instructionScene.summativetv.center.x, y: instructionScene.summativetv.center.y+safeTop+navHeight)
        case .anticipatory:
            transition.startingPoint = CGPoint(x: instructionScene.anticipatorytv.center.x, y: instructionScene.anticipatorytv.center.y+safeTop+navHeight)
        case .instruction:
            transition.startingPoint = CGPoint(x: instructionScene.instructiontv.center.x, y: instructionScene.instructiontv.center.y+safeTop+navHeight)
        case .closure:
            transition.startingPoint = CGPoint(x: instructionScene.closuretv.center.x, y: instructionScene.closuretv.center.y+safeTop+navHeight)
        case .background:
            transition.startingPoint = CGPoint(x: instructionScene.backgroundtv.center.x, y: instructionScene.backgroundtv.center.y+safeTop+navHeight)
        case .lesson:
            transition.startingPoint = CGPoint(x: instructionScene.lessontv.center.x, y: instructionScene.lessontv.center.y+safeTop+navHeight)
        default:
            transition.startingPoint = CGPoint(x: 0, y: 0)
        }
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = CGPoint(x: 0, y: 0)
        transition.circleColor = .white
        return transition
    }
}

extension ClosureViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.circleColor = .white
        switch sequenceTyped {
        case .pdf:
            transition.startingPoint = CGPoint(x: sdGap+UIScreen.main.bounds.width/6, y: UIScreen.main.bounds.height-safeBottom-sdButtonHeight/2-sdGap)
        case .content:
            transition.startingPoint = CGPoint(x: closureScene.contenttv.center.x, y: closureScene.contenttv.center.y+safeTop+navHeight)
        case .objectives:
            transition.startingPoint = CGPoint(x: closureScene.objectivestv.center.x, y: closureScene.objectivestv.center.y+safeTop+navHeight)
        case .summative:
            transition.startingPoint = CGPoint(x: closureScene.summativetv.center.x, y: closureScene.summativetv.center.y+safeTop+navHeight)
        case .anticipatory:
            transition.startingPoint = CGPoint(x: closureScene.anticipatorytv.center.x, y: closureScene.anticipatorytv.center.y+safeTop+navHeight)
        case .instruction:
            transition.startingPoint = CGPoint(x: closureScene.instructiontv.center.x, y: closureScene.instructiontv.center.y+safeTop+navHeight)
        case .closure:
            transition.startingPoint = CGPoint(x: closureScene.closuretv.center.x, y: closureScene.closuretv.center.y+safeTop+navHeight)
        case .background:
            transition.startingPoint = CGPoint(x: closureScene.backgroundtv.center.x, y: closureScene.backgroundtv.center.y+safeTop+navHeight)
        case .lesson:
            transition.startingPoint = CGPoint(x: closureScene.lessontv.center.x, y: closureScene.lessontv.center.y+safeTop+navHeight)
        default:
            transition.startingPoint = CGPoint(x: 0, y: 0)
        }
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = CGPoint(x: 0, y: 0)
        transition.circleColor = .white
        return transition
    }
}

extension BackgroundViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.circleColor = .white
        switch sequenceTyped {
        case .pdf:
            transition.startingPoint = CGPoint(x: sdGap+UIScreen.main.bounds.width/6, y: UIScreen.main.bounds.height-safeBottom-sdButtonHeight/2-sdGap)
        case .content:
            transition.startingPoint = CGPoint(x: backgroundScene.contenttv.center.x, y: backgroundScene.contenttv.center.y+safeTop+navHeight)
        case .objectives:
            transition.startingPoint = CGPoint(x: backgroundScene.objectivestv.center.x, y: backgroundScene.objectivestv.center.y+safeTop+navHeight)
        case .summative:
            transition.startingPoint = CGPoint(x: backgroundScene.summativetv.center.x, y: backgroundScene.summativetv.center.y+safeTop+navHeight)
        case .anticipatory:
            transition.startingPoint = CGPoint(x: backgroundScene.anticipatorytv.center.x, y: backgroundScene.anticipatorytv.center.y+safeTop+navHeight)
        case .instruction:
            transition.startingPoint = CGPoint(x: backgroundScene.instructiontv.center.x, y: backgroundScene.instructiontv.center.y+safeTop+navHeight)
        case .closure:
            transition.startingPoint = CGPoint(x: backgroundScene.closuretv.center.x, y: backgroundScene.closuretv.center.y+safeTop+navHeight)
        case .background:
            transition.startingPoint = CGPoint(x: backgroundScene.backgroundtv.center.x, y: backgroundScene.backgroundtv.center.y+safeTop+navHeight)
        case .lesson:
            transition.startingPoint = CGPoint(x: backgroundScene.lessontv.center.x, y: backgroundScene.lessontv.center.y+safeTop+navHeight)
        default:
            transition.startingPoint = CGPoint(x: 0, y: 0)
        }
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = CGPoint(x: 0, y: 0)
        transition.circleColor = .white
        return transition
    }
}

extension LessonViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.circleColor = .white
        switch sequenceTyped {
        case .pdf:
            transition.startingPoint = CGPoint(x: sdGap+UIScreen.main.bounds.width/6, y: UIScreen.main.bounds.height-safeBottom-sdButtonHeight/2-sdGap)
        case .content:
            transition.startingPoint = CGPoint(x: lessonScene.contenttv.center.x, y: lessonScene.contenttv.center.y+safeTop+navHeight)
        case .objectives:
            transition.startingPoint = CGPoint(x: lessonScene.objectivestv.center.x, y: lessonScene.objectivestv.center.y+safeTop+navHeight)
        case .summative:
            transition.startingPoint = CGPoint(x: lessonScene.summativetv.center.x, y: lessonScene.summativetv.center.y+safeTop+navHeight)
        case .anticipatory:
            transition.startingPoint = CGPoint(x: lessonScene.anticipatorytv.center.x, y: lessonScene.anticipatorytv.center.y+safeTop+navHeight)
        case .instruction:
            transition.startingPoint = CGPoint(x: lessonScene.instructiontv.center.x, y: lessonScene.instructiontv.center.y+safeTop+navHeight)
        case .closure:
            transition.startingPoint = CGPoint(x: lessonScene.closuretv.center.x, y: lessonScene.closuretv.center.y+safeTop+navHeight)
        case .background:
            transition.startingPoint = CGPoint(x: lessonScene.backgroundtv.center.x, y: lessonScene.backgroundtv.center.y+safeTop+navHeight)
        case .lesson:
            transition.startingPoint = CGPoint(x: lessonScene.lessontv.center.x, y: lessonScene.lessontv.center.y+safeTop+navHeight)
        default:
            transition.startingPoint = CGPoint(x: 0, y: 0)
        }
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = CGPoint(x: 0, y: 0)
        transition.circleColor = .white
        return transition
    }
}

extension UITextView{
    func addTwoBarButtons(leftTitle: String, rightTitle: String, target: Any, leftSelector: Selector, rightSelector: Selector){
        let toolBar = UIToolbar()
        toolBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44)
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let leftBarButton = UIBarButtonItem(title: leftTitle, style: .plain, target: target, action: leftSelector)
        let rightbarButton = UIBarButtonItem(title: rightTitle, style: .plain, target: target, action: rightSelector)
        toolBar.setItems([leftBarButton, flexible,rightbarButton], animated: false)
        self.inputAccessoryView = toolBar
    }
    func addThreeBarButtons(title1: String, title2: String, title3: String, target: Any, selector1: Selector, selector2: Selector, selector3: Selector){
        let toolBar = UIToolbar()
        toolBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44)
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton1 = UIBarButtonItem(title: title1, style: .plain, target: target, action: selector1)
        let barButton2 = UIBarButtonItem(title: title2, style: .plain, target: target, action: selector2)
        let barButton3 = UIBarButtonItem(title: title3, style: .plain, target: target, action: selector3)
        toolBar.setItems([barButton1, barButton2,flexible, barButton3], animated: false)
        self.inputAccessoryView = toolBar
    }
}

extension UIColor{
    static var byuhPurple: UIColor{
        return #colorLiteral(red: 0.742426753, green: 0.1857207716, blue: 0.7242348194, alpha: 1)
    }
    static func sdTextFieldColor() -> UIColor{
        return #colorLiteral(red: 0.8062470555, green: 0.8279613256, blue: 0.8380290866, alpha: 1)
    }
    static var byuHlightGray:UIColor{
        return #colorLiteral(red: 0.9554883838, green: 0.9596452117, blue: 0.9521929622, alpha: 1)
    }
    static var byuHGray: UIColor{
        return #colorLiteral(red: 0.8097864985, green: 0.827958405, blue: 0.8415374756, alpha: 1)
    }
    static var byuHRed: UIColor{
        return #colorLiteral(red: 0.6058552265, green: 0.120728381, blue: 0.2143063247, alpha: 1)
    }
    static var byuHDarkGray: UIColor{
        return #colorLiteral(red: 0.2683390379, green: 0.2685706615, blue: 0.2683749199, alpha: 1)
    }
    static var byuhMidGray:UIColor{
        return #colorLiteral(red: 0.6545551419, green: 0.6587786078, blue: 0.6509450078, alpha: 1)
    }
    static var byuhGold:UIColor{
        return #colorLiteral(red: 0.6802838445, green: 0.5117569566, blue: 0.1192237809, alpha: 1)
    }
    static var pdfGreen:UIColor{
        return #colorLiteral(red: 0.3106759191, green: 0.6774330139, blue: 0.185857743, alpha: 1)
    }
}

extension UIView{
    func roundedTopCorner(radius: Int){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topLeft , .topRight],
                                     cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}

#if targetEnvironment(macCatalyst)
   class CatalystAppManager {
       class func configureMacAppWindow() {
           guard let appBundleUrl = Bundle.main.builtInPlugInsURL else {
               return
           }
           
           let helperBundleUrl = appBundleUrl.appendingPathComponent("AppBundle.bundle")
           
           guard let bundle = Bundle(url: helperBundleUrl) else {
               return
           }

           bundle.load()
           
           guard let object = NSClassFromString("MacApp") as? NSObjectProtocol else {
               return
           }
           
           let selector = NSSelectorFromString("disableMaximizeButton")
           object.perform(selector)
       }
   }
   #endif
