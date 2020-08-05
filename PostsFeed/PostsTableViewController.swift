//
//  PostsTableViewController.swift
//  PostsFeed
//
//  Created by Dima on 05.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

class PostsTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        Network.shared.fetchData { (data) in
            print(data)
            guard let data = data else { return }
        }
    }
}

