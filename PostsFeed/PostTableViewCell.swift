//
//  PostTableViewCell.swift
//  PostsFeed
//
//  Created by Dima on 06.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
        
    private let postImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let userTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
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
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    func configueNew(viewModel: PostsViewModel, index: Int) {        
        self.likesLabel.text = convertStatisticsData(value: viewModel.posts[index].likes)
        self.viewsLabel.text = convertStatisticsData(value: viewModel.posts[index].views)
        self.commentsLabel.text = convertStatisticsData(value: viewModel.posts[index].comments)
        self.userNameLabel.text = viewModel.posts[index].userName
        self.userTextLabel.text = viewModel.posts[index].userText
        let image = UIImage()
        image.fetchImage(with: viewModel, index: index) { [weak self] (image) in
            DispatchQueue.main.async {
                self?.postImage.image = image
            }
        }
//        RequestsPostService.shared.fetchImage(with: viewModel, index: index) { [weak self] (image) in
////            guard let image = image else { return }
//            if  image != nil {
//                DispatchQueue.main.async {
//                    self?.postImage.image = image
//                }
//            } else {
//                DispatchQueue.main.async {
//                    self?.postImage.image = nil
//                }
//            }
//        }
    }
    
    

    

    
    private func convertStatisticsData(value: Int) -> String {
        if value > 1000 {
            return "\(value/1000)K"
        } else if value > 1000000 {
            return "\(value/1000000)M"
        } else {
            return "\(value)"
        }
    }
    
    private func setupViews() {
        
        if postImage.image != nil {
            [userNameLabel, userTextLabel, likeIcon, likesLabel, viewIcon, viewsLabel, commentIcon, commentsLabel].forEach { contentView.addSubview($0) }

            let constraints = [
                
                userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                userNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                
                userTextLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
                userTextLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
                userTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
                userTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
                
                likeIcon.heightAnchor.constraint(equalToConstant: 24),
                likeIcon.widthAnchor.constraint(equalToConstant: 24),
                likeIcon.topAnchor.constraint(equalTo: userTextLabel.bottomAnchor, constant: 10),
                likeIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                likeIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                likesLabel.widthAnchor.constraint(equalToConstant: 30),
                likesLabel.leftAnchor.constraint(equalTo: likeIcon.rightAnchor, constant: 8),
                likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                
                viewIcon.heightAnchor.constraint(equalToConstant: 24),
                viewIcon.widthAnchor.constraint(equalToConstant: 24),
                viewIcon.leftAnchor.constraint(equalTo: likesLabel.rightAnchor, constant: 30),
                viewIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                viewsLabel.widthAnchor.constraint(equalToConstant: 30),
                viewsLabel.leftAnchor.constraint(equalTo: viewIcon.rightAnchor, constant: 8),
                viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                
                commentIcon.heightAnchor.constraint(equalToConstant: 24),
                commentIcon.widthAnchor.constraint(equalToConstant: 24),
                commentIcon.leftAnchor.constraint(equalTo: viewsLabel.rightAnchor, constant: 30),
                commentIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                commentsLabel.widthAnchor.constraint(equalToConstant: 30),
                commentsLabel.leftAnchor.constraint(equalTo: commentIcon.rightAnchor, constant: 8),
                commentsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                
            ]
            
            NSLayoutConstraint.activate(constraints)
        } else {
            [userNameLabel, userTextLabel, postImage, likeIcon, likesLabel, viewIcon, viewsLabel, commentIcon, commentsLabel].forEach { contentView.addSubview($0) }

            let constraints = [
                userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                userNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                           
                postImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
                postImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
                postImage.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
              
                userTextLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 10),
                userTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                userTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
                
                likeIcon.heightAnchor.constraint(equalToConstant: 24),
                likeIcon.widthAnchor.constraint(equalToConstant: 24),
                likeIcon.topAnchor.constraint(equalTo: userTextLabel.bottomAnchor, constant: 10),
                likeIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                likeIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                
                likesLabel.widthAnchor.constraint(equalToConstant: 30),
                likesLabel.leftAnchor.constraint(equalTo: likeIcon.rightAnchor, constant: 8),
                likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                
                viewIcon.heightAnchor.constraint(equalToConstant: 24),
                viewIcon.widthAnchor.constraint(equalToConstant: 24),
                viewIcon.leftAnchor.constraint(equalTo: likesLabel.rightAnchor, constant: 30),
                viewIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                
                viewsLabel.widthAnchor.constraint(equalToConstant: 30),
                viewsLabel.leftAnchor.constraint(equalTo: viewIcon.rightAnchor, constant: 8),
                viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                
                commentIcon.heightAnchor.constraint(equalToConstant: 24),
                commentIcon.widthAnchor.constraint(equalToConstant: 24),
                commentIcon.leftAnchor.constraint(equalTo: viewsLabel.rightAnchor, constant: 30),
                commentIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                
                commentsLabel.widthAnchor.constraint(equalToConstant: 30),
                commentsLabel.leftAnchor.constraint(equalTo: commentIcon.rightAnchor, constant: 8),
                commentsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                
            ]
            
            NSLayoutConstraint.activate(constraints)
        }
    
        
    }
}


extension UIImage {
    func fetchImage(with model: PostsViewModel, index: Int, completion: @escaping (UIImage?) -> Void) {
          guard let imageURL = model.posts[index].imageURLString else { return }
          
          guard let url = URL(string: imageURL) else { return }
          
          URLSession.shared.dataTask(with: url) { (data, response, error) in
              if let error = error {
                  print(error)
                  return
              }
              
              #if DEBUG
              print(response.debugDescription)
              #endif
              
              if let data = data, let image = UIImage(data: data) {
                  completion(image)
              } else {
                  completion(nil)
              }
          }.resume()
      }
}
