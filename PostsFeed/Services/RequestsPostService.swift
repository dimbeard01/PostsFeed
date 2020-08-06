//
//  RequestsPostService.swift
//  PostsFeed
//
//  Created by Dima on 05.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import Foundation


final class RequestsPostService {
    
    static let shared = RequestsPostService()

    func fetchData(completion: @escaping (RequestModel?) -> Void) {
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
            
            if let requestModel = try? JSONDecoder().decode(RequestModel.self, from: data) {
                completion(requestModel)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    func getImage(model: RequestModel, index: Int) -> String {
        var imageURL = String()
        model.data.items[index].contents.forEach { (item) in
            guard let image = item.data.small else { return }
            imageURL = image.url
        }
        return imageURL
    }
    
    func getText(model: RequestModel, index: Int) -> String {
        var userText = String()
        model.data.items[index].contents.forEach { (item) in
            guard let text = item.data.value else { return }
            userText = text
        }
        return userText
    }

}
