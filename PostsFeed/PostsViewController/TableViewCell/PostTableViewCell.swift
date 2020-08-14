//
//  PostTableViewCell.swift
//  PostsFeed
//
//  Created by Dima on 06.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var customPostImage: CustomImageView = {
        let image = CustomImageView()
        image.backgroundColor = .white
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.disableAutoresizingMask()
        return image
    }()
    
    private let userTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.disableAutoresizingMask()
        return label
    }()
    
    private let likeIcon: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "likes")
        image.disableAutoresizingMask()
        return image
    }()
    
    private let viewIcon: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "views")
        image.disableAutoresizingMask()
        return image
    }()
    
    private let commentIcon: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "comments")
        image.disableAutoresizingMask()
        return image
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.disableAutoresizingMask()
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.disableAutoresizingMask()
        return label
    }()
    
    private let commentsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.disableAutoresizingMask()
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .left
        label.disableAutoresizingMask()
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure(with viewModel: Post) {
        likesLabel.text = viewModel.likes.convertStatistics()
        viewsLabel.text = viewModel.views.convertStatistics()
        commentsLabel.text =  viewModel.comments.convertStatistics()
        userNameLabel.text = viewModel.userName
        userTextLabel.text = viewModel.userText
        customPostImage.loadImage(with: viewModel)
    }
    
    // MARK: - Layout
    
    private func setupViews() {
        [userNameLabel, userTextLabel, customPostImage, likeIcon, likesLabel, viewIcon, viewsLabel, commentIcon, commentsLabel].forEach { contentView.addSubview($0) }
        
        let constraints = [
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            
            customPostImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            customPostImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            customPostImage.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            
            userTextLabel.topAnchor.constraint(equalTo: customPostImage.bottomAnchor, constant: 10),
            userTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            userTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            likeIcon.heightAnchor.constraint(equalToConstant: 24),
            likeIcon.widthAnchor.constraint(equalToConstant: 24),
            likeIcon.topAnchor.constraint(equalTo: userTextLabel.bottomAnchor, constant: 10),
            likeIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            likeIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            likesLabel.leftAnchor.constraint(equalTo: likeIcon.rightAnchor, constant: 8),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            viewIcon.heightAnchor.constraint(equalToConstant: 24),
            viewIcon.widthAnchor.constraint(equalToConstant: 24),
            viewIcon.leftAnchor.constraint(equalTo: likesLabel.rightAnchor, constant: 30),
            viewIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            viewsLabel.leftAnchor.constraint(equalTo: viewIcon.rightAnchor, constant: 8),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            commentIcon.heightAnchor.constraint(equalToConstant: 24),
            commentIcon.widthAnchor.constraint(equalToConstant: 24),
            commentIcon.leftAnchor.constraint(equalTo: viewsLabel.rightAnchor, constant: 30),
            commentIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            commentsLabel.leftAnchor.constraint(equalTo: commentIcon.rightAnchor, constant: 8),
            commentsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

