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
    var onSetupViews: (() -> Void)?
    var onShowLoaderIndicator: (() -> Void)?
    var onShowPost: ((Post) -> Void)?
    var onLoadNextPage: (() -> Void)?
    var onShowFootLoaderIndicator: (() -> Void)?
    
    private let requestPostService = RequestsPostService()
    
    var posts: [Post] = []
    
    func runEvent(_ event: Event) {
        switch event {
        case .viewDidLoad:
            fetchPosts()
        case .showPost(let viewModel):
            showPosts(viewModel: viewModel)
        case .loadNextPage:
            onShowFootLoaderIndicator?()
            loadNextPage()
        default:
            print("showPost")
        }
    }
    
    private func fetchPosts() {
        onShowLoaderIndicator?()
        onSetupViews?()
        
        requestPostService.fetchData { [weak self] (data) in
            guard let data = data else { return }
            
            let model = PostsFeed(model: data)
            self?.posts = model.postModels
            self?.onReloadData?()
        }
    }
    
    private func showPosts(viewModel: Post) {
        onShowPost?(viewModel)
    }
    
    private func loadNextPage() {
        requestPostService.fetchNextPageImagesURL { [weak self] (data) in
            guard let data = data else { return }
            let model = PostsFeed(model: data)
            self?.posts += model.postModels
            self?.onLoadNextPage?()
        }
    }
}

