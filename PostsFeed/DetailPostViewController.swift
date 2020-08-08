//
//  DetailPostViewController.swift
//  PostsFeed
//
//  Created by Dima on 08.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

final class DetailPostViewController: UIViewController {
    private let viewModel: PostViewModel?
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private var customPostImage: CustomImageView? = {
        let image = CustomImageView()
        image.backgroundColor = .white
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let userTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let likeIcon: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "likes")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let viewIcon: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "views")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let commentIcon: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "comments")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let commentsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    init(viewModel: PostViewModel) {
        self.viewModel = viewModel
        likesLabel.text = viewModel.likes.convertStatistics()
        viewsLabel.text = viewModel.views.convertStatistics()
        commentsLabel.text =  viewModel.comments.convertStatistics()
        userNameLabel.text = viewModel.userName
        userTextLabel.text = viewModel.userText
        
        if viewModel.imageURLString != nil {
            customPostImage?.loadImage(with: viewModel)
        } else {
            customPostImage = nil
        }
        
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        let viewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalToConstant: view.frame.width)
        ]
        
        NSLayoutConstraint.activate(viewConstraints)

        let emptyImageConstraints = [
            userNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            userNameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            
            userTextLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            userTextLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            userTextLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
            
            likeIcon.heightAnchor.constraint(equalToConstant: 24),
            likeIcon.widthAnchor.constraint(equalToConstant: 24),
            likeIcon.topAnchor.constraint(equalTo: userTextLabel.bottomAnchor, constant: 10),
            likeIcon.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            likeIcon.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            
            likesLabel.leftAnchor.constraint(equalTo: likeIcon.rightAnchor, constant: 8),
            likesLabel.topAnchor.constraint(equalTo: userTextLabel.bottomAnchor, constant: 10),
            likesLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            
            viewIcon.heightAnchor.constraint(equalToConstant: 24),
            viewIcon.widthAnchor.constraint(equalToConstant: 24),
            viewIcon.topAnchor.constraint(equalTo: userTextLabel.bottomAnchor, constant: 10),
            viewIcon.leftAnchor.constraint(equalTo: likesLabel.rightAnchor, constant: 30),
            viewIcon.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            
            viewsLabel.leftAnchor.constraint(equalTo: viewIcon.rightAnchor, constant: 8),
            viewsLabel.topAnchor.constraint(equalTo: userTextLabel.bottomAnchor, constant: 10),
            viewsLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            
            commentIcon.heightAnchor.constraint(equalToConstant: 24),
            commentIcon.widthAnchor.constraint(equalToConstant: 24),
            commentIcon.topAnchor.constraint(equalTo: userTextLabel.bottomAnchor, constant: 10),
            commentIcon.leftAnchor.constraint(equalTo: viewsLabel.rightAnchor, constant: 30),
            commentIcon.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            
            commentsLabel.leftAnchor.constraint(equalTo: commentIcon.rightAnchor, constant: 8),
            commentsLabel.topAnchor.constraint(equalTo: userTextLabel.bottomAnchor, constant: 10),
            commentsLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ]
        
        
        
        if let customPostImage = customPostImage {
            [userNameLabel, userTextLabel, customPostImage, likeIcon, likesLabel, viewIcon, viewsLabel, commentIcon, commentsLabel].forEach { containerView.addSubview($0) }
            
            let constraints = [
                userNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
                userNameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
                
                customPostImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
                customPostImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
                customPostImage.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
                
                userTextLabel.topAnchor.constraint(equalTo: customPostImage.bottomAnchor, constant: 10),
                userTextLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
                userTextLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
                
                likeIcon.heightAnchor.constraint(equalToConstant: 24),
                likeIcon.widthAnchor.constraint(equalToConstant: 24),
                likeIcon.topAnchor.constraint(equalTo: userTextLabel.bottomAnchor, constant: 10),
                likeIcon.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
                likeIcon.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
                
                likesLabel.leftAnchor.constraint(equalTo: likeIcon.rightAnchor, constant: 8),
                likesLabel.topAnchor.constraint(equalTo: userTextLabel.bottomAnchor, constant: 10),
                likesLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
                
                viewIcon.heightAnchor.constraint(equalToConstant: 24),
                viewIcon.widthAnchor.constraint(equalToConstant: 24),
                viewIcon.topAnchor.constraint(equalTo: userTextLabel.bottomAnchor, constant: 10),
                viewIcon.leftAnchor.constraint(equalTo: likesLabel.rightAnchor, constant: 30),
                viewIcon.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
                
                viewsLabel.leftAnchor.constraint(equalTo: viewIcon.rightAnchor, constant: 8),
                viewsLabel.topAnchor.constraint(equalTo: userTextLabel.bottomAnchor, constant: 10),
                viewsLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
                
                commentIcon.heightAnchor.constraint(equalToConstant: 24),
                commentIcon.widthAnchor.constraint(equalToConstant: 24),
                commentIcon.topAnchor.constraint(equalTo: userTextLabel.bottomAnchor, constant: 10),
                commentIcon.leftAnchor.constraint(equalTo: viewsLabel.rightAnchor, constant: 30),
                commentIcon.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
                
                commentsLabel.leftAnchor.constraint(equalTo: commentIcon.rightAnchor, constant: 8),
                commentsLabel.topAnchor.constraint(equalTo: userTextLabel.bottomAnchor, constant: 10),
                commentsLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
            ]
            NSLayoutConstraint.activate(constraints)
        } else {
            [userNameLabel, userTextLabel, likeIcon, likesLabel, viewIcon, viewsLabel, commentIcon, commentsLabel].forEach { containerView.addSubview($0) }
            
            NSLayoutConstraint.activate(emptyImageConstraints)
            
        }
        
    }
}


