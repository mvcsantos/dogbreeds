
import Foundation
import Network

public final class LWNetwork {

    private let session: URLSession
    private(set) var networkMonitor: NetworkMonitoring

    public init(
        configuration: URLSessionConfiguration = .default,
        networkMonitor: NetworkMonitoring = NetworkMonitor()
    ) {
        self.session = URLSession(
            configuration: configuration,
            delegate: nil,
            delegateQueue: nil
        )
        self.networkMonitor = networkMonitor
    }
}

// MARK: - LWNetworking

extension LWNetwork: LWNetworking {

    @discardableResult
    public func performRequest(_ request: URLRequest) async throws -> Data? {
        guard networkMonitor.status == .satisfied else {
            throw LWNetworkingError.noNetworkConnection
        }
        let (data, urlResponse) = try await session.dataTask(with: request)

        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            throw LWNetworkingError.invalidResponse
        }

        switch urlResponse.statusCode {
            case (400..<500):
                throw LWNetworkingError.client(error: urlResponse.debugDescription)
            case (500..<600):
                throw LWNetworkingError.remote(error: "\(urlResponse.debugDescription)")
            default:
                break
        }

        guard (200..<300).contains(urlResponse.statusCode) else {
            throw LWNetworkingError.unknownError
        }

        return data
    }

    public func performRequest<T: Codable>(_ request: URLRequest) async throws -> T {
        let data = try await performRequest(request)

        guard let data = data else { throw LWNetworkingError.noData }

        let decodedResponse = try JSONDecoder().decode(T.self, from: data)
        return decodedResponse
    }
}
