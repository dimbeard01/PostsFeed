//
//  RequestsPostService.swift
//  PostsFeed
//
//  Created by Dima on 05.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit


final class RequestsPostService {
        
    func fetchData(completion: @escaping ([PostViewModel]?,_ cursor: String?) -> Void) {
        guard let url = URL(string: "http://stage.apianon.ru:3000/fs-posts/v1/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                completion(nil, nil)
                return
            }
            
            #if DEBUG
            print(response.debugDescription)
            #endif
            
            guard let data = data else { return completion(nil, nil) }
            
            if let requestModel = try? JSONDecoder().decode(Post.self, from: data) {
                print(requestModel.data.cursor)
                
                let userPostsModel = requestModel.data.items.map { PostViewModel(model: $0) }
                
                completion(userPostsModel, requestModel.data.cursor)
            } else {
                completion(nil, nil)
            }
        }.resume()
    }
    
    func fetchNextPageImagesURL(cursor: String?, completion: @escaping ([PostViewModel]?) -> Void) {
        guard let url = URL(string: "http://stage.apianon.ru:3000/fs-posts/v1/posts") else { return }
        guard let cursor = cursor else { return }
        
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
//
//            if let networkModel = try? JSONDecoder().decode(NetworkImageModel.self, from: data) {
//                self.pageCout += 1
//                completion(networkModel)
                
            if let requestModel = try? JSONDecoder().decode(Post.self, from: data) {
                print(requestModel.data.cursor)
                let userPostsModel = requestModel.data.items.map { PostViewModel(model: $0) }
                completion(userPostsModel)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
