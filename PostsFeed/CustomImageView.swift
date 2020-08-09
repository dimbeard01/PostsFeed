//
//  CustomImageView.swift
//  PostsFeed
//
//  Created by Dima on 08.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

final class CustomImageView: UIImageView {
    
    func loadImage(with model: Post) {
        guard let imageURL = model.imageURLString else { return }
        
        if let imageFromCache = imageCache.object(forKey: imageURL as NSString) {
            self.image = imageFromCache
            return
        }
        
        fetchImage(with: imageURL) { [weak self] (image) in
            guard let image = image else { return }
            
            DispatchQueue.main.async {
                let imageToCache = image
                imageCache.setObject(imageToCache, forKey: imageURL as NSString)
                self?.image = imageToCache
            }
        }
    }
    
    func fetchImage(with urlSting: String, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: urlSting) else { return }
        
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

