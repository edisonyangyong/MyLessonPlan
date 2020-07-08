//
//  GeneralListUpdate.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 6/7/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import Foundation

class GeneralListUpdate {
    var request = URLRequest(url: URL(string: "https://07zvqmu7qb.execute-api.us-east-2.amazonaws.com/test/MyLessonPlan/GeneralList")!)
    
    init() {
        let API_KEY = "7dSXGE5yDE9Cms3EEo5g02K3Akt1ukbZ11InYs0u"
        request.setValue(API_KEY, forHTTPHeaderField:"X-API-KEY")
        request.httpMethod = "POST"
    }
    
    func sendRequest(ID: String, isLiked:Bool = false, newComment:String = ""){
//        let json: [String: Any] = ["ID": ID,
//                                   "isLiked": isLiked,
//                                   "comment": newComment]
        
        let json = TestingJson(ID: ID, isLiked: isLiked, comment: newComment)
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        let jsonData = try? JSONEncoder().encode(json)
        request.httpBody = jsonData
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

struct TestingJson:Codable{
    var ID: String
    var isLiked: Bool
    var comment: String
}
