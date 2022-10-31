//
//  AppContainer.swift
//  DogBreed
//
//  Created by Marcus Santos on 23/10/2022.
//

import Foundation
import LWNetworking
import Dip

enum AppContainerError: Error {

    case invalidApiBaseURL
}

class AppContainer {

    private let container = DependencyContainer()

    init() {

        guard let baseURL = URL(string: DogApiEndpoints.baseURL) else {
            fatalError("Invalid Dog API base URL")
        }

        registerNetworking(baseURL: baseURL)
        registerScreens()
    }

    func registerNetworking(baseURL: URL) {

        let network = LWNetwork()

        container.register(.shared) {
            BreedsInteractor(
                baseURL: baseURL,
                network: network
            )
        }
        .implements(BreedsInteractorType.self)

        container.register(.shared) {
            BreedImageInteractor(
                baseURL: baseURL,
                network: network
            )
        }
        .implements(BreedImageInteractorType.self)

        container.register(.shared) {
            FavoritesInteractor()
        }
        .implements(FavoritesInteractorType.self)
    }

    func registerScreens() {

        container.register(.shared) {
            DetailsModule(breedInteractor: $0, breedImageInteractor: $1, favoritesInteractor: $2)
        }
        .implements(DetailsModuleType.self)

        container.register(.shared) {
            BreedListingModule(breedInteractor: $0, breedImageInteractor: $1, detailsModule: $2)
        }
        .implements(BreedListingModuleType.self)

        container.register(.shared) {
            FavoritesModule(interactor: $0, breedImageInteractor: $1)
        }
        .implements(FavoritesModuleType.self)

        container.register(.shared) {
            TabBarModule(listingModule: $0, favoritesModule: $1)
        }
        .implements(TabBarModuleType.self)
    }

    func resolve<T>() throws -> T {
        try container.resolve()
    }
}
