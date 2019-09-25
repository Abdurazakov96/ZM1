//
//  NetworkManager.swift
//  ZM
//
//  Created by Магомед Абдуразаков on 15/09/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import UIKit


class NetworkManager: Codable {
    
    
    //Mark: Public properties
    
    let baseURL = URL(string: "http://localhost:8090")
    
    
    //Mark: Public methods
    
    func getCategories(completion: @escaping([String]?,Error?) -> Void){
        let url = baseURL?.appendingPathComponent("categories")
        let task =  URLSession.shared.dataTask(with: url!) {data, _, error in
            guard let data = data else {return}
            let decoder = JSONDecoder()
            guard   let decoderData = try? decoder.decode(Categories.self, from: data) else {return}
            completion(decoderData.categories, nil)
        }
        task.resume()
    }
    
    func getMenuItems(for category: String, completion: @escaping([MenuItem]?, Error?) -> Void) {
        let initialUrl = baseURL?.appendingPathComponent("menu")
        guard let url = initialUrl?.withQueries(["category": category]) else {return}
        let task = URLSession.shared.dataTask(with: url) {data, _, Error in
            guard let data = data else {return}
            let decoder = JSONDecoder()
            guard   let decoderData = try? decoder.decode(MenuItems.self, from: data) else {return}
            completion(decoderData.items, nil)
        }
        task.resume()
        
    }
    
    func getImage(_ initialURL: URL, completion: @escaping (Data, Error?) -> Void) {
        var components = URLComponents(url: initialURL, resolvingAgainstBaseURL: true)
        components?.host = baseURL?.host
        guard let url = components?.url else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {return}
            completion(data, nil)
        }
        task.resume()
    }
    
    func submitOrder(forMenuIDs menuIDs: [Int], completion: @escaping (Int?, Error?) -> Void) {
        let url = baseURL!.appendingPathComponent("order")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data = ["menuIds": menuIDs]
        let encoder = JSONEncoder()
        let jsonData = try? encoder.encode(data)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data else {
                print(#line, #function, "ERROR: Data is nil")
                completion(nil, nil)
                return
            }
            let decoder = JSONDecoder()
            guard let preparationTime = try? decoder.decode(PreparationTime.self, from: data) else {
                print(#line, #function, "ERROR: Can't convert \(data) to preparationTime")
                completion(nil, nil)
                return
            }
            completion(preparationTime.prepTime, nil)
        }
        task.resume()
    }
    
}
