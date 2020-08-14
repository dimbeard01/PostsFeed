//
//  PostsHeaderTableView.swift
//  PostsFeed
//
//  Created by Dima on 12.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

final class PostsHeaderTableView: UIView {
    
    // MARK: - Properties
    
    var onSortButtonPressed: ((SortPostBy) -> Void)?
    
    private let mostPopularButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray3
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.setTitle("most popular", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.addTarget(self, action: #selector(handleMostPopularButton), for: .touchUpInside)
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true
        button.disableAutoresizingMask()
        return button
    }()
    
    private let mostCommentedButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray3
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.setTitle("most commented", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.addTarget(self, action: #selector(handleMostCommentedButton), for: .touchUpInside)
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true
        button.disableAutoresizingMask()
        return button
    }()
    
    private let createdAtButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray3
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.setTitle("created at", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.addTarget(self, action: #selector(handleCreatedAtButon), for: .touchUpInside)
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true
        button.disableAutoresizingMask()
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.showsHorizontalScrollIndicator = false
        scroll.disableAutoresizingMask()
        return scroll
    }()
    
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.disableAutoresizingMask()
        return containerView
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightText
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func handleSortButton(by type: SortPostBy) {
        switch type {
        case .popular:
            mostPopularButton.layer.borderWidth = 2
            mostPopularButton.layer.borderColor = UIColor.black.cgColor
            
            createdAtButton.layer.borderWidth = 0
            mostCommentedButton.layer.borderWidth = 0
            mostCommentedButton.isUserInteractionEnabled = true
            createdAtButton.isUserInteractionEnabled = true
            mostPopularButton.isUserInteractionEnabled = false
            onSortButtonPressed?(.popular)
            
        case .commented:
            mostCommentedButton.layer.borderWidth = 2
            mostCommentedButton.layer.borderColor = UIColor.black.cgColor
            
            mostPopularButton.layer.borderWidth = 0
            createdAtButton.layer.borderWidth = 0
            mostPopularButton.isUserInteractionEnabled = true
            createdAtButton.isUserInteractionEnabled = true
            mostCommentedButton.isUserInteractionEnabled = false
            onSortButtonPressed?(.commented)
            
        case .createdAt:
            createdAtButton.layer.borderWidth = 2
            createdAtButton.layer.borderColor = UIColor.black.cgColor
            
            mostPopularButton.layer.borderWidth = 0
            mostCommentedButton.layer.borderWidth = 0
            mostPopularButton.isUserInteractionEnabled = true
            mostCommentedButton.isUserInteractionEnabled = true
            createdAtButton.isUserInteractionEnabled = false
            onSortButtonPressed?(.createdAt)
        }
    }
    
    // MARK: - Actions
    
    @objc private func handleMostPopularButton() {
        handleSortButton(by: .popular)
    }
    
    @objc private func handleMostCommentedButton() {
        handleSortButton(by: .commented)
    }
    
    @objc private func handleCreatedAtButon() {
        handleSortButton(by: .createdAt)
    }
    
    // MARK: - Layout
    
    private func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(mostPopularButton)
        containerView.addSubview(mostCommentedButton)
        containerView.addSubview(createdAtButton)
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        let containerViewsConstraints = [
            mostPopularButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            mostPopularButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            mostPopularButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            
            mostCommentedButton.leftAnchor.constraint(equalTo: mostPopularButton.rightAnchor, constant: 10),
            mostCommentedButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            mostCommentedButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            
            createdAtButton.leftAnchor.constraint(equalTo: mostCommentedButton.rightAnchor, constant: 10),
            createdAtButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            createdAtButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            createdAtButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(containerViewsConstraints)
    }
}
