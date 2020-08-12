//
//  PostsFeed.swift
//  PostsFeed
//
//  Created by Dima on 06.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import Foundation

 struct PostsFeed {
    let postModels: [Post]

    init(model: [Post]) {
        self.postModels = model
    }
}

struct Post {
    let userName: String
    let likes: Int
    let views: Int
    let comments: Int
    let createdAt: Int
    var imageURLString: String? = nil
    var userText: String? = nil
    
    init(model: UserPostModel) {
        userName = model.author?.name ?? "unknown"
        likes = model.stats.likes.count ?? 0
        views = model.stats.views.count ?? 0
        comments = model.stats.comments.count ?? 0
        createdAt = model.createdAt
        imageURLString = getImageURL(model: model)
        userText = getText(model: model)
    }
    
    private func getImageURL(model: UserPostModel) -> String? {
        var imageURL: String?
     
           model.contents.forEach { (item) in
               guard let image = item.data.small else { return }
               imageURL = image.url
           }
           return imageURL
       }
    
    private func getText(model: UserPostModel) -> String {
         var userText = String()
         model.contents.forEach { (item) in
             guard let text = item.data.value else { return }
             userText = text
         }
         return userText
     }
}
