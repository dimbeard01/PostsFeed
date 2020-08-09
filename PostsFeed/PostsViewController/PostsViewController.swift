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
}

enum SortPostBy {
    case popular
    case commented
    case createdAt
}

final class PostsViewController: UIViewController {
    
    // MARK: - Properties
    
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
        tableView.tableFooterView = self.footLoaderIndicator
        tableView.disableAutoresizingMask()
        return tableView
    }()
    
    private let footLoaderIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.style = .medium
        activity.color = .black
        activity.hidesWhenStopped = true
        return activity
    }()
    
    private let loaderIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.style = .large
        activity.color = .black
        activity.hidesWhenStopped = true
        activity.disableAutoresizingMask()
        return activity
    }()
    
    private lazy var filterNavigationBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(filterButtonHandler))
        button.tintColor = .black
        return button
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
        navigationItem.rightBarButtonItem = filterNavigationBarButton
        
        setupViewModel()
        viewModel.runEvent(.viewDidLoad)
    }
    
    // MARK: - Helpers
    
    private func setupViewModel() {
        viewModel.onSetupViews = { [unowned self] in
            self.setupViews()
        }
        
        viewModel.onShowLoaderIndicator = { [unowned self] in
            DispatchQueue.main.async {
                self.loaderIndicator.startAnimating()
            }
        }
        
        viewModel.onReloadData = { [unowned self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.loaderIndicator.stopAnimating()
            }
        }
        
        viewModel.onShowFootLoaderIndicator = { [unowned self] in
            DispatchQueue.main.async {
                self.tableView.tableFooterView?.isHidden = false
                self.footLoaderIndicator.startAnimating()
            }
        }
        
        viewModel.onLoadNextPage = { [unowned self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.footLoaderIndicator.stopAnimating()
            }
        }
        
        viewModel.onShowPost = { [unowned self] (viewModel) in
            self.navigationController?.pushViewController(DetailPostViewController(viewModel: viewModel), animated: true)
        }
    }
    
    //Incorrect sort
    private func sortViewModel(type: SortPostBy) -> [Post] {
        switch type {
        case .popular:
            return viewModel.posts.sorted(by: { $0.views > $1.views })
        case .commented:
            return viewModel.posts.sorted(by: { $0.comments > $1.comments })
        case .createdAt:
            return viewModel.posts.sorted(by: { $0.likes > $1.likes })
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
    
    // MARK: - Action
    
    @objc private func filterButtonHandler() {
        let alertController = UIAlertController(title: "Filter by", message: nil, preferredStyle: .alert)
        
        let popularAction = UIAlertAction(title: "most popular", style: .default) { [weak self] (_) in
            self?.viewModel.posts = self?.sortViewModel(type: .popular) ?? []
            self?.tableView.reloadData()
        }
        
        let commentedAction = UIAlertAction(title: "most commented", style: .default) { [weak self] (_) in
            self?.viewModel.posts = self?.sortViewModel(type: .commented) ?? []
            self?.tableView.reloadData()
        }
        
        let createdAtAction = UIAlertAction(title: "created at", style: .default) { [weak self] (_) in
            self?.viewModel.posts = self?.sortViewModel(type: .createdAt) ?? []
            self?.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(popularAction)
        alertController.addAction(commentedAction)
        alertController.addAction(createdAtAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: false, completion: nil)
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
            cell.configueNew(viewModel: viewModel.posts[indexPath.row])
            
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as? PostTableViewCell else {return UITableViewCell()}
            cell.configueNew(viewModel: viewModel.posts[indexPath.row])
            
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.posts.count - 1) {
            viewModel.runEvent(.loadNextPage)
        }
    }
}
