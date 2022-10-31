
import Foundation

public protocol LWNetworking: AnyObject {

    /// Performs an asynchronous data task request with the given `URLRequest` and decodes the response using a JSONDecoder
    /// - Parameter request: The request be to performed
    /// - Returns: Decoded object
    /// - Throws: `NetworkingError` or an `Error` when the request fails
    func performRequest<T: Codable>(_ request: URLRequest) async throws -> T

    /// Performs an asynchronous data task request with the given `URLRequest`
    /// - Returns: Raw Data object if there's one
    /// - Throws: `NetworkingError` or an `Error` when the request fails
    @discardableResult
    func performRequest(_ request: URLRequest) async throws -> Data?
}
