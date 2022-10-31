//
//  BreedImageInteractor.swift
//  DogBreed
//
//  Created by Marcus Santos on 30/10/2022.
//

import Foundation
import LWNetworking


/// Proves images for all breeds
protocol BreedImageInteractorType: AnyObject {

    /// Retrieves and image URL for a given Breed
    /// - Parameter breed: breed name
    /// - Returns: a list of `URL` images
    func imagesByBreed(breed: String) async throws -> [URL]

    /// Retrieves a random image for a given Breed
    /// - Parameter breed: breed name
    /// - Returns: random image `URL`
    func randomImageForBreed(breed: String) async throws -> URL?
}

final class BreedImageInteractor: DogApiInteractable {

    let baseURL: URL
    let network: LWNetworking

    let randomImageCache: Cache<String, String>

    init(baseURL: URL, network: LWNetworking) {
        self.baseURL = baseURL
        self.network = network

        self.randomImageCache = Cache<String, String>()
        randomImageCache.updateCountLimit(count: 100)
    }
}

extension BreedImageInteractor: BreedImageInteractorType {

    func imagesByBreed(breed: String) async throws -> [URL] {

        let response: [String] = try await performRequest(endpoint: .listAllImagesByBreed(breed: breed))

        return response.compactMap(URL.init(string:))
    }

    func randomImageForBreed(breed: String) async throws -> URL? {

        if let imageUrlString = randomImageCache[breed] {
            return URL(string: imageUrlString)
        }

        let imageUrlString: String = try await performRequest(endpoint: .randomImageForBreed(breed: breed))
        randomImageCache[breed] = imageUrlString

        return URL(string: imageUrlString)
    }

}
