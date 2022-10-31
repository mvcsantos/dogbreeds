
import Foundation

public enum LWNetworkingError: Error, Equatable {
    case uploadFileFail
    case malformedRequest
    case urlSessionError(description: String)
    /// If it fails to decode the response
    case decodingError(description: String)
    case invalidResponse
    case unknownError
    /// If HTTP response code is between 400 and 499
    case client(error: String)
    /// If HTTP response code is between 500 and 599
    case remote(error: String)
    case noData
    case noNetworkConnection
}
