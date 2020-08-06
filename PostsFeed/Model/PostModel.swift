//
//  PostModel.swift
//  PostsFeed
//
//  Created by Dima on 06.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import Foundation

final class PostModel {
    let postModel: [RequestUserPostModel]
    
    init(model: RequestModel) {
        self.postModel = model.data.items
    }
}
