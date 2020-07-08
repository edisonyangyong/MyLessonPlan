//
//  InspirationListUpdate.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/14/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import Foundation

enum Like_Update_Error:Error {
    case noDataAvailable
    case canNotProcessData
}

class InspirationListUpdate {
    var request = URLRequest(url: URL(string: "https://07zvqmu7qb.execute-api.us-east-2.amazonaws.com/test/MyLessonPlan/UpdateLikeNum")!)
    
    init() {
        let API_KEY = "7dSXGE5yDE9Cms3EEo5g02K3Akt1ukbZ11InYs0u"
        request.setValue(API_KEY, forHTTPHeaderField:"X-API-KEY")
        request.httpMethod = "POST"
    }
    
    func sendRequest(keyNum: String){
        let json: [String: Any] = ["Like": keyNum]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//        let jsonData = json.data(using: .utf8)!
        request.httpBody = jsonData
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
           guard let jsonData = data else {
//                DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 10) {
//                    self.sendRequest(keyNum: keyNum)
//                }
                return
           }
           do {
               if data == nil{
                    print(">>>>>>>>>>>>>>>>>>> no data")
                }else{
                    print(">>>>>>>>>>>>>>>>>>> \(String(describing: data)) downloaded")
                }
                let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                print(json)
           }catch{
               
           }
        })
        task.resume()
    }
}
