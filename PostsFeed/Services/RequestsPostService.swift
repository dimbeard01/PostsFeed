//
//  RequestsPostService.swift
//  PostsFeed
//
//  Created by Dima on 05.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

final class RequestsPostService {
    private let baseURLString = "http://stage.apianon.ru:3000/fs-posts/v1/posts"
    private var cursor: String?
    
    func fetchData(completion: @escaping ([Post]?) -> Void) {
        guard let url = URL(string: baseURLString) else { return }
        
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
            
            if let requestModel = try? JSONDecoder().decode(PostData.self, from: data) {
                let userPostsModel = requestModel.data.items.map { Post(model: $0) }
                
                if let cursor = requestModel.data.cursor {
                    let encodedCursor = cursor.replacingOccurrences(of: "+", with: "%2B")
                    self.cursor = encodedCursor
                }
                completion(userPostsModel)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    func fetchNextPageImagesURL(completion: @escaping ([Post]?) -> Void) {
        guard var url = URL(string: baseURLString) else { return }
        if let correctCursor = cursor {
            guard let urlWithQuery = URL(string: "\(baseURLString)?after=\(correctCursor)") else { return }
            url = urlWithQuery
        } else {
            return
        }
        
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
            
            if let requestModel = try? JSONDecoder().decode(PostData.self, from: data) {
                let userPostsModel = requestModel.data.items.map { Post(model: $0) }
                
                if let cursor = requestModel.data.cursor {
                    let encodedCursor = cursor.replacingOccurrences(of: "+", with: "%2B")
                    self.cursor = encodedCursor
                }
                
                completion(userPostsModel)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
