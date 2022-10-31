//
//  BaseResponse.swift
//  DogBreed
//
//  Created by Marcus Santos on 23/10/2022.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {

    let status: Status
    let message: T
    let error: Int?

    enum Status: String, Codable {
        case success
        case error
    }
}
