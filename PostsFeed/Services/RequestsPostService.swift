//
//  RequestsPostService.swift
//  PostsFeed
//
//  Created by Dima on 05.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit


final class RequestsPostService {
        
    func fetchData(completion: @escaping ([PostViewModel]?) -> Void) {
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
            
            if let requestModel = try? JSONDecoder().decode(Post.self, from: data) {
                let userPostsModel = requestModel.data.items.map { PostViewModel(model: $0) }
                completion(userPostsModel)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    func fetchImage(with model: PostsViewModel, index: Int, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = model.posts[index].imageURLString else { return }
        
        guard let url = URL(string: imageURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            #if DEBUG
            print(response.debugDescription)
            #endif
            
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
