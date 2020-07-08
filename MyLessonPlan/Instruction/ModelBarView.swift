//
//  ModleBarView.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 7/6/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import Foundation

import UIKit

class ModelBarView: UIView {
    var defaultColor = UIColor()
    var barWidth:CGFloat = CGFloat(0){
        didSet{
             setNeedsDisplay()
        }
    }
    var barTitle = String()
    private var label:UILabel={
        return UILabel()
    }()
    var percentage: UILabel={
        return UILabel()
    }()
    var stepTableView:UITableView={
        return UITableView()
    }()
    var plusImageView:UIImageView={
        let plusImageView = UIImageView()
        plusImageView.alpha = 0
        return plusImageView
    }()
    var doneImageView:UIImageView={
        let checkImageView = UIImageView()
        checkImageView.alpha = 0
        return checkImageView
    }()
    var editImageView:UIImageView={
        let editImageView = UIImageView()
        editImageView.isUserInteractionEnabled = true
        return editImageView
    }()
    var data = [(step:String, content:String)](){
        didSet{
            updatePercentage()
            stepTableView.reloadData()
        }
    }
    var objectiveData = ""{
        didSet{
            updatePercentage()
            stepTableView.reloadData()
        }
    }
    private var percentNum = 0
    
    override func draw(_ rect: CGRect) {
        setupLayout()
        setStepTableView()
        setProcess()
        setPercentage()
        setPlusImageView()
        setCheckImageLayout()
        setEditImageViewLayout()
    }
    
    func setupLayout(){
        label.frame = CGRect(x: sdGap, y: sdGap, width: barWidth-2*sdGap, height: barWidth*0.2)
        #if targetEnvironment(macCatalyst)
        label.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 35)
        #else
        label.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        #endif
        label.text = barTitle
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 0)
        label.textAlignment = .center
        label.textColor = .white
        self.addSubview(label)
    }
    func setStepTableView(){
        stepTableView.delegate = self
        stepTableView.dataSource = self
        stepTableView.register(ModelBarCell.self, forCellReuseIdentifier: "barCell")
        stepTableView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 0)
        stepTableView.separatorStyle = .none
        stepTableView.frame = CGRect(x: sdGap, y: label.frame.maxY, width: barWidth-2*sdGap, height: barWidth*0.6)
        self.addSubview(stepTableView)
    }
    func setProcess(){
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: sdGap, y: barWidth*0.9))
        path1.addLine(to: CGPoint(x: sdGap+barWidth*0.5, y: barWidth*0.9))
        UIColor.white.setStroke()
        path1.lineWidth = barWidth/20
        path1.stroke(with: .normal, alpha: 0.5)
        
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: sdGap, y: barWidth*0.9))
        path2.addLine(to: CGPoint(x: sdGap+barWidth*0.5*CGFloat(percentNum)/100, y: barWidth*0.9))
        UIColor.white.setStroke()
        path2.lineWidth = barWidth/20
        path2.stroke()
    }
    func setPercentage(){
        percentage.frame = CGRect(x: barWidth*0.58, y: barWidth*0.82, width: barWidth*2.5/10, height: barWidth/6)
        #if targetEnvironment(macCatalyst)
        percentage.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 30)
        #else
        percentage.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        #endif
        percentage.textColor = .white
        percentage.adjustsFontSizeToFitWidth = true
        percentage.text = String(self.percentNum) + "%"
        self.addSubview(percentage)
    }
    func setPlusImageView(){
        plusImageView.image = #imageLiteral(resourceName: "file add-office-color")
        plusImageView.contentMode = .scaleAspectFit
        plusImageView.frame =  CGRect(x: barWidth/4, y: barWidth/4, width: barWidth/2, height: barWidth/2)
        self.addSubview(plusImageView)
    }
    func setCheckImageLayout(){
        doneImageView.image = #imageLiteral(resourceName: "check-flow")
        doneImageView.contentMode = .scaleAspectFit
        doneImageView.frame =  CGRect(x: barWidth/4, y: barWidth/4, width: barWidth/2, height: barWidth/2)
        self.addSubview(doneImageView)
    }
    func setEditImageViewLayout(){
        editImageView.frame = CGRect(x: barWidth-(barWidth*0.17), y: barWidth-(barWidth*0.17), width:  barWidth*0.17, height:  barWidth*0.17)
        editImageView.image = #imageLiteral(resourceName: "edit")
        self.addSubview(editImageView)
    }
    func addBorder(){
        self.addDashedBorder(width: barWidth, height: barWidth, lineWidth: 10, lineDashPattern:[10,10] , strokeColor: UIColor.white)
    }
    func removeBorder(){
        if self.layer.sublayers != nil{
            for layer in self.layer.sublayers!{
                if layer.name == "kShapeDashed"{
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
    private func updatePercentage(){
        var counter = 0
        counter = (objectiveData == "") ? 0:1
        for d in data{
            counter += (d.content == "") ? 0:1
        }
        if data.count != 0 {
            percentNum = Int(Double(counter)/Double(data.count+1)*100)
        }
    }
}
extension ModelBarView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return barWidth*0.15
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "barCell") as! ModelBarCell
        cell.layout(width: barWidth-2*sdGap, height:barWidth*0.15)
        cell.selectionStyle = .none
        cell.backgroundColor = #colorLiteral(red: 0.2354720533, green: 0.8087568283, blue: 0.4411867857, alpha: 0)
        if indexPath.row == 0{
            cell.label.text = "State Objective"
            if objectiveData != ""{
                cell.checkBox.image = #imageLiteral(resourceName: "check-filled")
            }else{
                cell.checkBox.image = nil
            }
        }else{
            cell.label.text = data[indexPath.row-1].step
            if data[indexPath.row-1].content != ""{
                cell.checkBox.image = #imageLiteral(resourceName: "check-filled")
            }else{
                 cell.checkBox.image = nil
            }
        }
        return cell
    }
}
