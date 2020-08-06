//
//  PostTableViewCell.swift
//  PostsFeed
//
//  Created by Dima on 06.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    
    static let id = "dsd"
    
    private let postImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let commentsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .lightGray
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        likesLabel.text = text
       guard let url = URL(string: text) else { return }
              
              URLSession.shared.dataTask(with: url) { (data, response, error) in
                  if let error = error {
                      print(error)
                      return
                  }
                  
                  #if DEBUG
                  print(response.debugDescription)
                  #endif
                  
                  if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.postImage.image = image
                    }
                  } else {
                    DispatchQueue.main.async {
                        self.postImage.image = UIImage(named: "empty")
                    }
                  }
              }.resume()
    }
    
    private func setupViews() {
        addSubview(postImage)
        postImage.addSubview(likeIcon)
        postImage.addSubview(viewIcon)
        postImage.addSubview(commentIcon)
        postImage.addSubview(likesLabel)
        
        let constraints = [
            postImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20),
            postImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            postImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            postImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            postImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            postImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            likeIcon.heightAnchor.constraint(equalToConstant: 24),
            likeIcon.widthAnchor.constraint(equalToConstant: 24),
            likeIcon.leftAnchor.constraint(equalTo: postImage.leftAnchor, constant: 10),
            likeIcon.bottomAnchor.constraint(equalTo: postImage.bottomAnchor, constant: -10),
            
            viewIcon.heightAnchor.constraint(equalToConstant: 24),
            viewIcon.widthAnchor.constraint(equalToConstant: 24),
            viewIcon.centerXAnchor.constraint(equalTo: postImage.centerXAnchor),
            viewIcon.bottomAnchor.constraint(equalTo: postImage.bottomAnchor, constant: -10),
            
            commentIcon.heightAnchor.constraint(equalToConstant: 24),
            commentIcon.widthAnchor.constraint(equalToConstant: 24),
            commentIcon.rightAnchor.constraint(equalTo: postImage.rightAnchor, constant: -30),
            commentIcon.bottomAnchor.constraint(equalTo: postImage.bottomAnchor, constant: -10)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
}
