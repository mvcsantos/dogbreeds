//
//  FavoritsInteractor.swift
//  DogBreed
//
//  Created by Marcus Santos on 30/10/2022.
//

import Foundation

/// Source of truth for all the images marked as favorite
protocol FavoritesInteractorType {

    /// All the images marked as favorite
    /// - Returns: All images
    func retrieveAllFavorites() async -> [URL]

    /// Marks as image as favorite
    /// - Parameter imageURL: image to be marked as favorite
    func toggleFavorite(imageURL: URL) async

    /// Checks if an image was marked as favorite
    /// - Parameter imageURL: image to be checked
    /// - Returns: `true` if the image was marked as favorite, `false` otherwise
    func isFavorite(imageURL: URL) -> Bool

    /// Performs a search using the substring `text` in the favorits
    /// - Parameter text: Text to search for
    /// - Returns:Favorites filtered by `text`
    func search(text: String) -> [URL]
}

final class FavoritesInteractor {

    var content = [URL]()
}

extension FavoritesInteractor: FavoritesInteractorType {

    func retrieveAllFavorites() async -> [URL] {
        content
    }

    func toggleFavorite(imageURL: URL) async {
        if content.contains(imageURL) {
            content.removeAll { $0 == imageURL }
            return
        }
        content.append(imageURL)
    }

    func isFavorite(imageURL: URL) -> Bool {
        content.contains(imageURL)
    }

    func search(text: String) -> [URL] {

        let text = text.lowercased()

        if text.isEmpty {
            return content
        }

        return content.filter {
            $0.absoluteString.lowercased().contains(text)
        }
    }
}
