//
//  RequestModel.swift
//  PostsFeed
//
//  Created by Dima on 05.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

struct Post: Decodable {
    var data: RequestPostsModel
}

struct RequestPostsModel: Decodable {
    var items: [RequestUserPostModel]
    var cursor: String?
}

struct RequestUserPostModel: Decodable {
    var contents: [Content]
    var createdAt: Int
    var author: AuthorModel?
    var stats: StatisticsModel
}

   struct Content: Decodable {
       let data: ContentData
   }

   struct ContentData: Decodable {
       let value: String?
       let small: Small?
   }

   struct Small: Decodable {
       let url: String
   }

struct AuthorModel: Decodable {
    var name: String?
}

struct StatisticsModel: Decodable {
    var likes: LikesModel
    var views: ViewsModel
    var comments: CommentsModel
    
    struct LikesModel: Decodable {
        var count: Int?
    }
    
    struct ViewsModel: Decodable {
        var count: Int?
    }
    
    struct CommentsModel: Decodable {
        var count: Int?
    }
}


