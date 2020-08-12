//
//  PostsHeaderTableView.swift
//  PostsFeed
//
//  Created by Dima on 12.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

final class PostsHeaderTableView: UIView {
    private let mostPopularLabel: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.setTitle("most popular", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true
        button.disableAutoresizingMask()
        return button
    }()
    
    private let mostCommentedLabel: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.setTitle("most commented", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true
        button.disableAutoresizingMask()
        return button
    }()
    
    private let createdAtLabel: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.setTitle("created at", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true
        button.disableAutoresizingMask()
        return button
    }()
    
    private let wrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.disableAutoresizingMask()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightText
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleTap() {
        mostPopularLabel.layer.borderWidth = 2
        mostPopularLabel.layer.borderColor = UIColor.black.cgColor
    }
    
    private func setupViews() {
        addSubview(mostPopularLabel)
        addSubview(mostCommentedLabel)
        addSubview(createdAtLabel)
        
        
        let constraints = [
            mostPopularLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            mostPopularLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            
            mostCommentedLabel.leftAnchor.constraint(equalTo: mostPopularLabel.rightAnchor, constant: 10),
            mostCommentedLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            
            createdAtLabel.leftAnchor.constraint(equalTo: mostCommentedLabel.rightAnchor, constant: 10),
            createdAtLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            createdAtLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
