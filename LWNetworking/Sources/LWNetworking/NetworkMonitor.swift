
import Foundation
import Network

public protocol NetworkMonitoring {
    var status: NWPath.Status { get }
}

public final class NetworkMonitor: NetworkMonitoring {

    public var status: NWPath.Status {
        monitor.currentPath.status
    }

    private let queue =  DispatchQueue(label:"monitor.queue")
    private let monitor: NWPathMonitor

    public init() {
        self.monitor = NWPathMonitor()
        monitor.start(queue: queue)
    }
}
