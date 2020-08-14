//
//  PostsViewController.swift
//  PostsFeed
//
//  Created by Dima on 06.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

enum Event {
    case viewDidLoad
    case showPost(Post)
    case loadNextPage
    case sortBy(SortPostBy)
}

enum SortPostBy: String {
    case popular = "mostPopular"
    case commented = "mostCommented"
    case createdAt = "createdAt"
}

final class PostsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: PostsViewModel
    private var typeSort: SortPostBy?
    private let headerView = PostsHeaderTableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: .infinity))

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.register(PostTableTextViewCell.self, forCellReuseIdentifier: String(describing: PostTableTextViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = .zero
        tableView.tableFooterView = self.footLoaderIndicator
        tableView.sectionHeaderHeight = 50
        tableView.disableAutoresizingMask()
        return tableView
    }()
    
    private let footLoaderIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.style = .large
        activity.color = .black
        activity.hidesWhenStopped = true
        return activity
    }()
    
    private let loaderIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.style = .medium
        activity.color = .black
        activity.hidesWhenStopped = true
        activity.disableAutoresizingMask()
        return activity
    }()
    
    // MARK: - Init
    
    init(viewModel: PostsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Posts Feed"
        
        setupHeaderView()
        setupViewModel()
        viewModel.runEvent(.viewDidLoad)
    }
    
    // MARK: - Helpers
    
    private func setupHeaderView() {
        headerView.onSortButtonPressed = { [unowned self] (type) in
            self.viewModel.runEvent(.sortBy(type))
        }
    }
    
    private func setupViewModel() {
        viewModel.onSetupViews = { [unowned self] in
            self.setupViews()
        }
        
        viewModel.onShowLoaderIndicator = { [unowned self] in
            DispatchQueue.main.async {
                self.loaderIndicator.startAnimating()
            }
        }
        
        viewModel.onHideLoaderIndicator = { [unowned self] in
            DispatchQueue.main.async {
                self.loaderIndicator.stopAnimating()
            }
        }
        
        viewModel.onReloadData = { [unowned self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.onScrollToTop = { [unowned self] in
            DispatchQueue.main.async {
                let startIndex = IndexPath.init(row: 0, section: 0)
                self.tableView.scrollToRow(at: startIndex, at: .top, animated: true)
            }
        }
        
        viewModel.onShowFootLoaderIndicator = { [unowned self] in
            DispatchQueue.main.async {
                self.tableView.tableFooterView?.isHidden = false
                self.footLoaderIndicator.startAnimating()
            }
        }
        
        viewModel.onHideFootLoaderIndicator = { [unowned self] in
            DispatchQueue.main.async {
                self.tableView.tableFooterView?.isHidden = true
                self.footLoaderIndicator.stopAnimating()
            }
        }
        
        viewModel.onShowPost = { [unowned self] (viewModel) in
            self.navigationController?.pushViewController(DetailPostViewController(viewModel: viewModel), animated: true)
        }
    }
    
    // MARK: - Layout
    
    private func setupViews() {
        view.addSubview(loaderIndicator)
        view.addSubview(tableView)
        footLoaderIndicator.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loaderIndicator.widthAnchor.constraint(equalToConstant: 100),
            loaderIndicator.heightAnchor.constraint(equalToConstant: 100),
            loaderIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loaderIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

    // MARK: - Table view data source

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewModel.posts[indexPath.row].imageURLString {
        case nil:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableTextViewCell.self), for: indexPath) as? PostTableTextViewCell else {return UITableViewCell()}
            
            cell.configure(with: viewModel.posts[indexPath.row])
            
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as? PostTableViewCell else {return UITableViewCell()}
            cell.configure(with: viewModel.posts[indexPath.row])
            
            return cell
        }
    }
}

    // MARK: - Table view delegate

extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.runEvent(.showPost(viewModel.posts[indexPath.row]))
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.posts.count - 1) {
            viewModel.runEvent(.loadNextPage)
        }
    }
}
