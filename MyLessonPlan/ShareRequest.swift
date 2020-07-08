//
//  ShareRequest.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 6/11/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import Foundation

class ShareRequest{
    var request = URLRequest(url: URL(string: "https://07zvqmu7qb.execute-api.us-east-2.amazonaws.com/test/MyLessonPlan/GeneralList")!)
    
    init() {
        let API_KEY = "7dSXGE5yDE9Cms3EEo5g02K3Akt1ukbZ11InYs0u"
        request.setValue(API_KEY, forHTTPHeaderField:"X-API-KEY")
        request.httpMethod = "PUT"
    }
    
    func sendRequest(json:Data){
        print(">>>>>>>>>>>>>>>>>>> Json Data Sent to the Cloud")
        print(String(data: json, encoding: .utf8) as Any)
        request.httpBody = json
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {responseData, response, error -> Void in
           guard let jsonData = responseData else { return }
           do {
                let responseJson = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                print(responseJson)
           }catch{

           }
        })
        task.resume()
    }
}
