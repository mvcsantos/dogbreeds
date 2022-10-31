//
//  DogApiInteractable.swift
//  DogBreed
//
//  Created by Marcus Santos on 30/10/2022.
//

import Foundation
import LWNetworking

protocol DogApiInteractable {

    var baseURL: URL { get }
    var network: LWNetworking { get }

    func performRequest<T: Codable>(endpoint: DogApiEndpoints) async throws -> T
}

extension DogApiInteractable {

    func performRequest<T: Codable>(endpoint: DogApiEndpoints) async throws -> T {
        let request = endpoint.buildRequest(baseURL: baseURL)
        let response: BaseResponse<T> = try await network.performRequest(request)

        guard response.status == .success else {
            throw APIError.invalidRequest
        }

        return response.message
    }
}
