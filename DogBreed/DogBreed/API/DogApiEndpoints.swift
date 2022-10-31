//
//  BreedApiEndpoints.swift
//  DogBreed
//
//  Created by Marcus Santos on 24/10/2022.
//

import Foundation

enum APIError: Error {

    case invalidRequest
}

enum DogApiEndpoints {

    static let baseURL = "https://dog.ceo"

    case listAllAllBreeds
    case listAllSubBreeds(breed: String)
    case listAllImagesByBreed(breed: String)
    case randomImageForBreed(breed: String)

    var path: String {

        switch self {
        case .listAllAllBreeds:
            return "/api/breeds/list/all"

        case let .listAllSubBreeds(breed):
            return "/api/breed/\(breed)/list"

        case let .listAllImagesByBreed(breed):
            return "/api/breed/\(breed)/images"

        case let .randomImageForBreed(breed):
            return "/api/breed/\(breed)/images/random"
        }
    }

    var method: URLRequest.HTTPMethod {

        switch self {
        case .listAllAllBreeds:
            return .get

        case .listAllSubBreeds:
            return .get

        case .listAllImagesByBreed:
            return .get

        case .randomImageForBreed:
            return .get
        }
    }
}

extension DogApiEndpoints {

    func buildRequest(baseURL: URL) -> URLRequest {

        let path = self.path
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        
        return request
    }
}
