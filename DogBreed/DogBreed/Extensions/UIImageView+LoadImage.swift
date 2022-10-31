//
//  UIImageView+LoadImage.swift
//  DogBreed
//
//  Created by Marcus Santos on 30/10/2022.
//

import UIKit

extension UIImageView {

    private static let cache: Cache<URL, Data> = {
        var cache = Cache<URL, Data>()
        cache.updateCountLimit(count: 12)

        return cache
    }()

    func load(url: URL) -> URLSessionDataTask {

        if let data = UIImageView.cache[url] {
            self.image = UIImage(data: data)
        }

        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
            if let data = data {
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                    UIImageView.cache[url] = data
                }
            }
        }
        return dataTask
    }
}
