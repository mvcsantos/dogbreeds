//
//  ErrorHandling.swift
//  DogBreed
//
//  Created by Marcus Santos on 31/10/2022.
//

import Foundation
import LWNetworking

protocol ErrorHandling {

    var viewController: BrowserViewController? { get set }

    func handle(error: Error)
}

extension ErrorHandling {

    func handle(error: Error) {

        switch error {
        case let error as APIError:
            handleAPIError(error: error)

        case let error as LWNetworkingError:
            handleNetworkingError(error: error)

        default:
            viewController?.error(title: "Ops", message: "something bad happen")
        }
    }

    private func handleAPIError(error: APIError) {
        viewController?.error(title: "", message: "")
    }

    private func handleNetworkingError(error: LWNetworkingError) {

        switch error {
        case .noNetworkConnection:
            viewController?.error(title: "No internet", message: "please, check your internet connection and try again")

        default:
            viewController?.error(title: "Ops", message: "something bad happen")
        }
    }
}
