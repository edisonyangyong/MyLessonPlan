//
//  GeneralListRequest.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 6/4/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import Foundation

enum GeneralIist_Request_Error:Error {
    case noDataAvailable
    case canNotProcessData
}

struct GeneralListRequest {
    var request = URLRequest(url: URL(string: "https://07zvqmu7qb.execute-api.us-east-2.amazonaws.com/test/MyLessonPlan/generallist")!)
    
    init() {
        let API_KEY = "7dSXGE5yDE9Cms3EEo5g02K3Akt1ukbZ11InYs0u"
        request.setValue(API_KEY, forHTTPHeaderField:"X-API-KEY")
        request.httpMethod = "GET"
    }
    
    func getList(completion: @escaping(Result<[GeneralInfo], InspirationList_Request_Error>) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
           guard let jsonData = data else {
               completion(.failure(.noDataAvailable))
               return
           }
            do {
                if data == nil{
                    print(">>>>>>>>>>>>>>>>>>> No Data Downloaded")
                }else{
                     print(">>>>>>>>>>>>>>>>>>> \(String(describing: data)) Genreal List Data Downloaded")
                }
//                 check out the original received json data
//                let jsonString = String(data: jsonData, encoding: .utf8)
//                print(jsonString)
                let decoder = JSONDecoder()
                let list_Response = try decoder.decode([GeneralInfo].self, from: jsonData)
                completion(.success(list_Response))
            }catch{
                completion(.failure(.canNotProcessData))
            }
        })
        task.resume()
    }
}

