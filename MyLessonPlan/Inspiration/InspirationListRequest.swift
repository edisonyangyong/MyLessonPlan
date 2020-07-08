//
//  InspirationListRequest.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 5/13/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//



import Foundation

enum InspirationList_Request_Error:Error {
    case noDataAvailable
    case canNotProcessData
}

struct InspirationList_Request {
    var request = URLRequest(url: URL(string: "https://07zvqmu7qb.execute-api.us-east-2.amazonaws.com/test/MyLessonPlan/InspirationalList")!)
    
    init() {
        let API_KEY = "7dSXGE5yDE9Cms3EEo5g02K3Akt1ukbZ11InYs0u"
        request.setValue(API_KEY, forHTTPHeaderField:"X-API-KEY")
        request.httpMethod = "GET"
    }
    
    // 最好把 [] 写在这里
    func getList (completion: @escaping(Result<[InspiritionalIdea], InspirationList_Request_Error>) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
           guard let jsonData = data else {
               completion(.failure(.noDataAvailable))
            return
            }
            do {
                if data == nil{
                    print(">>>>>>>>>>>>>>>>>>> no data")
                }else{
                    print(">>>>>>>>>>>>>>>>>>> \(String(describing: data)) downloaded")
                }
                let decoder = JSONDecoder()
                let list_Response = try decoder.decode([InspiritionalIdea].self, from: jsonData)
                completion(.success(list_Response))
            }catch{
                completion(.failure(.canNotProcessData))
            }
        })
        task.resume()
    }
}
