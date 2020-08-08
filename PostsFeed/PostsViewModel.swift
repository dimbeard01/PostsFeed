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
    var onShowLoader: (() -> Void)?
    var onShowPost: ((PostViewModel) -> Void)?
    var onLoadNext: (() -> Void)?

    private let requestPostService = RequestsPostService()
    
    var posts: [PostViewModel] = []
    var cursor: String?
    
    func runEvent(_ event: Event) {
        switch event {
        case .viewDidLoad:
            fetchPosts()
        case .showPost(let viewModel):
            showPosts(viewModel: viewModel)
        case .next(let str):
            loadNextPage(str: str)
        default:
            print("showPost")
        }
    }
    
    private func fetchPosts() {
        onShowLoader?()
        requestPostService.fetchData { [weak self] (data, cursor) in
            guard let data = data else { return }
            
            let model = FeedViewModel(model: data)
            self?.posts = model.postModels
            self?.cursor = cursor
            self?.onReloadData?()
        }
    }
    
    private func showPosts(viewModel: PostViewModel) {
        onShowPost?(viewModel)
    }
    
    private func loadNextPage(str: String?) {
        requestPostService.fetchNextPageImagesURL(cursor: str) { [weak self] (data) in
            guard let data = data else { return }
            
            let model = FeedViewModel(model: data)
            self?.posts.append(contentsOf: model.postModels)
            
            self?.onReloadData?()
        }
    }
}

