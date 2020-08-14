//
//  PostsViewModel.swift
//  PostsFeed
//
//  Created by Dima on 05.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

final class PostsViewModel {
    var onSetupViews: (() -> Void)?
    var onReloadData: (() -> Void)?
    var onShowLoaderIndicator: (() -> Void)?
    var onHideLoaderIndicator: (() -> Void)?
    var onShowPost: ((Post) -> Void)?
    var onShowFootLoaderIndicator: (() -> Void)?
    var onHideFootLoaderIndicator: (() -> Void)?
    var onScrollToTop: (() -> Void)?
    
    private let requestPostService = RequestsPostService()
    
    var posts: [Post] = []
    
    func runEvent(_ event: Event) {
        switch event {
        case .viewDidLoad:
            fetchPosts()
        case .showPost(let viewModel):
            showPosts(with: viewModel)
        case .loadNextPage:
            loadNextPage()
            onHideFootLoaderIndicator?()
        case .sortBy(let type):
            sortPosts(by: type)
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
            self?.onHideLoaderIndicator?()
        }
    }
    
    private func showPosts(with viewModel: Post) {
        onShowPost?(viewModel)
    }
    
    private func loadNextPage() {
        onShowFootLoaderIndicator?()

        requestPostService.fetchNextPage { [weak self] (data) in
            guard let data = data else { return }

            let model = PostsFeed(model: data)
            self?.posts += model.postModels
            self?.onReloadData?()
        }
    }
    
    private func sortPosts(by type: SortPostBy) {
        requestPostService.fetchSortData(type: type) { [weak self] (data) in
            guard let data = data else { return }
            
            let model = PostsFeed(model: data)
            self?.posts = model.postModels
            self?.onReloadData?()
            self?.onScrollToTop?()
        }
    }
}

