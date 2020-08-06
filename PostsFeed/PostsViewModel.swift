//
//  PostsViewModel.swift
//  PostsFeed
//
//  Created by Dima on 05.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

final class PostsViewModel {
    var onReloadData: (() -> Void)?
    
    var posts: [RequestUserPostModel] = []
    
    func runEvent(_ event: Event) {
        switch event {
        case .viewDidLoad:
            fetchPosts()
        default:
            print("showPost")
        }
    }
    
    private func fetchPosts(){
        RequestsPostService.shared.fetchData { [weak self] (data) in
            guard let data = data else { return }
            
            let model = PostModel(model: data)
            self?.posts = model.postModel
            
            self?.onReloadData?()
        }
    }
}

