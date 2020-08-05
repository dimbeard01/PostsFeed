//
//  Network.swift
//  PostsFeed
//
//  Created by Dima on 05.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import Foundation


final class Network {
    
    static let shared = Network()

    
    func fetchData(completion: @escaping (NetworkModel?) -> Void) {
        guard let url = URL(string: "http://stage.apianon.ru:3000/fs-posts/v1/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                completion(nil)
                return
            }
            
            #if DEBUG
            print(response.debugDescription)
            #endif
            
            guard let data = data else { return completion(nil) }
            
            if let networkModel = try? JSONDecoder().decode(NetworkModel.self, from: data) {
                completion(networkModel)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
}
