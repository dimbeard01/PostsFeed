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
    private let requestPostService = RequestsPostService()
    
    var posts: [PostViewModel] = []
    
    func runEvent(_ event: Event) {
        switch event {
        case .viewDidLoad:
            fetchPosts()
        default:
            print("showPost")
        }
    }
    
    private func fetchPosts(){
        requestPostService.fetchData { [weak self] (data) in
            guard let data = data else { return }
            
            let model = FeedViewModel(model: data)
            self?.posts = model.postModels
            
            self?.onReloadData?()
        }
    }
}

