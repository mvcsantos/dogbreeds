//
//  BreedsInteractor.swift
//  DogBreed
//
//  Created by Marcus Santos on 24/10/2022.
//

import Foundation
import LWNetworking


/// Proves all available Breeds and Sub-breeds
protocol BreedsInteractorType: AnyObject {

    /// Retrieves a list of all breeds
    /// - Returns: list of breeds
    func listAllBreeds() async throws -> [Breed]

    /// Retrieves a list of all sub-breeds
    /// - Parameter breed: breed name
    /// - Returns: sub-breeds
    func listAllSubBreeds(breed: String) async throws -> [String]
}

final class BreedsInteractor: DogApiInteractable {

    let baseURL: URL
    let network: LWNetworking

    init(baseURL: URL, network: LWNetworking) {
        self.baseURL = baseURL
        self.network = network
    }

    func performRequest<T: Codable>(endpoint: DogApiEndpoints) async throws -> T {
        let request = endpoint.buildRequest(baseURL: baseURL)
        let response: BaseResponse<T> = try await network.performRequest(request)

        guard response.status == .success else {
            throw APIError.invalidRequest
        }

        return response.message
    }
}

extension BreedsInteractor: BreedsInteractorType {

    func listAllBreeds() async throws -> [Breed] {

        let response: [String: [String]] = try await performRequest(endpoint: .listAllAllBreeds)

        return response
            .map { Breed(name: $0, subBreed: $1) }
    }

    func listAllSubBreeds(breed: String) async throws -> [String] {

        let response: [String] = try await performRequest(endpoint: .listAllSubBreeds(breed: breed))

        return response
    }

}
