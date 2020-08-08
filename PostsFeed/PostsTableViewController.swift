//
//  PostsTableViewController.swift
//  PostsFeed
//
//  Created by Dima on 06.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

enum Event {
    case viewDidLoad
    case showPost(PostViewModel)
    case reloadData
    case next(String?)
}

final class PostsTableViewController: UIViewController {
    
    private let viewModel: PostsViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.register(PostTableTextViewCell.self, forCellReuseIdentifier: String(describing: PostTableTextViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = .zero
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.style = .large
        activity.color = .black
        activity.hidesWhenStopped = true
        return activity
    }()
    
    init(viewModel: PostsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Posts Feed"
        
        view.addSubview(activityIndicator)
        activityIndicator.frame = CGRect(x: view.center.x - 50, y: view.center.y - 50, width: 100, height: 100)
        
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        setupViewModel()
        viewModel.runEvent(.viewDidLoad)
        
    }
    
    private func showLoader() {
        activityIndicator.startAnimating()
    }
    
    private func hideLoader() {
        activityIndicator.stopAnimating()
    }
    
    private func setupViewModel() {
        
        viewModel.onShowLoader = { [unowned self] in
            DispatchQueue.main.async {
                self.showLoader()
            }
        }
        
        viewModel.onReloadData = { [unowned self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.hideLoader()
            }
        }
        
        viewModel.onShowPost = { [unowned self] (viewModel) in
            self.navigationController?.pushViewController(DetailPostViewController(viewModel: viewModel), animated: true)
        }
        
        //        viewModel.onsetupViews = {
        //            self.setupViews()
        //        }
    }
}

extension PostsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewModel.posts[indexPath.row].imageURLString {
        case nil:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableTextViewCell.self), for: indexPath) as? PostTableTextViewCell else {return UITableViewCell()}
            cell.configueNew(viewModel: viewModel.posts[indexPath.row])
            
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as? PostTableViewCell else {return UITableViewCell()}
            cell.configueNew(viewModel: viewModel.posts[indexPath.row])
            
            return cell
        }
        
    }
}

extension PostsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.runEvent(.showPost(viewModel.posts[indexPath.row]))
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 19 {
            viewModel.runEvent(.next(nil))
        }
    }
}
