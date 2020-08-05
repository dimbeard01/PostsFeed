//
//  NetworkPostsModel.swift
//  PostsFeed
//
//  Created by Dima on 05.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

struct NetworkModel: Decodable {
    var data: NetworkPostsModel
}

struct NetworkPostsModel: Decodable {
    var items: [PostModel]
    var cursor: String
}

struct PostModel: Decodable {
    var id: String
    var contents: [Content]
    var createdAt: Int
    var author: AuthorModel
    var stats: StatisticsModel
}

   enum Content: Decodable {
    case text(TextPostModel)
    case image(ImagePostModel)
  
   }

struct TextPostModel: Decodable {
    var type: String
    var data: TextModel
    var sss: String
    
    struct TextModel: Decodable {
        var value: String?
    }
}

struct ImagePostModel: Decodable {
    var type: String
    var data: ImageModel
    
    struct ImageModel: Decodable {
        var small: SmallImage
        
        struct SmallImage: Decodable {
            var url: String?
        }
    }
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


