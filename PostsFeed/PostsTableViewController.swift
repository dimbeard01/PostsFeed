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
    case showPost
    case reloadData
}

final class PostsTableViewController: UIViewController {
    
    private let viewModel: PostsViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = .zero
        return tableView
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
        
        view.addSubview(tableView)
        
        tableView.frame = view.frame
        setupViewModel()
        viewModel.runEvent(.viewDidLoad)
    }
    
    private func setupViewModel() {
        viewModel.onReloadData = { [unowned self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
//
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as? PostTableViewCell else {return UITableViewCell()}
        cell.configueNew(viewModel: viewModel, index: indexPath.row)
        
        return cell
    }
}

extension PostsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
