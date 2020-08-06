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
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
         tableView.dataSource = self
        tableView.delegate = self
         tableView.backgroundColor = .clear
         tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
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
        viewModel.runEvent(.viewDidLoad)
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel.onReloadData = { [unowned self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension PostsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.id, for: indexPath) as? PostTableViewCell else {return UITableViewCell()}
        guard let text = viewModel.posts[indexPath.row].stats.views.count else {return UITableViewCell()}
        
    
        let a = getLikes(value: text)
        let s = getImage(model: viewModel, index: indexPath.row)
        cell.configure(text: s)
        return cell
    }
    
    func getLikes(value: Int) -> String {
        if value > 1000 {
            return "\(value/1000) K"
        } else if value > 1000000{
         return "\(value/1000000) M"
        } else {
            return "\(value)"
        }
        
    }
    
    func getImage(model: PostsViewModel, index: Int) -> String {
           var imageURL = String()
           model.posts[index].contents.forEach { (item) in
               guard let image = item.data.small else { return }
               imageURL = image.url
           }
           return imageURL
       }
  }


extension PostsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width
    }

}
