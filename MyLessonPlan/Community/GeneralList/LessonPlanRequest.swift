//
//  LessonPlanRequest.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 6/14/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import Foundation

enum LessonPlan_Request_Error:Error {
    case noDataAvailable
    case canNotProcessData
}

struct LessonPlanRequest {
    lazy var request = URLRequest(url: URL(string: "https://07zvqmu7qb.execute-api.us-east-2.amazonaws.com/test/MyLessonPlan/LessonPlans?ID=")!)
    
    init() {
        let API_KEY = "7dSXGE5yDE9Cms3EEo5g02K3Akt1ukbZ11InYs0u"
        request.setValue(API_KEY, forHTTPHeaderField:"X-API-KEY")
        request.httpMethod = "GET"
    }
    
    mutating func getLessonPlan(ID:String, completion: @escaping(Result<JsonModel, InspirationList_Request_Error>) -> Void) {
        let session = URLSession.shared
        self.request.url = URL(string: "https://07zvqmu7qb.execute-api.us-east-2.amazonaws.com/test/MyLessonPlan/LessonPlans?ID=\(ID)")
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
           guard let jsonData = data else {
               completion(.failure(.noDataAvailable))
               return
           }
            do {
                if data == nil{
                    print(">>>>>>>>>>>>>>>>>>> No Data downloaded")
                }else{
                    print(">>>>>>>>>>>>>>>>>>> \(String(describing: data)) Lesson Plan Data Downloaded")
                }
//                // check out the original received json data
//                print("=================== original received json data ===================")
//                let jsonString = String(data: jsonData, encoding: .utf8)
//                print(jsonString)
                let decoder = JSONDecoder()
                let list_Response = try decoder.decode(JsonModel.self, from: jsonData)
                completion(.success(list_Response))
            }catch{
                completion(.failure(.canNotProcessData))
            }
        })
        task.resume()
    }
}
