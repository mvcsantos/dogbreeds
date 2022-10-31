//
//  DetailsModule.swift
//  DogBreed
//
//  Created by Marcus Santos on 30/10/2022.
//

import UIKit

final class FavoritesModule {

    let interactor: FavoritesInteractorType
    let breedImageInteractor: BreedImageInteractorType

    init(interactor: FavoritesInteractorType, breedImageInteractor: BreedImageInteractorType) {
        self.interactor = interactor
        self.breedImageInteractor = breedImageInteractor
    }
}

extension FavoritesModule: FavoritesModuleType {

    func makeViewController() -> UIViewController {

        let presenter = FavoritesPresenter(favoritesInteractor: interactor)
        let viewController = BrowserViewController(
            breedImageInteractor: breedImageInteractor,
            includeSearchBar: true
        )
        viewController.title = "Favorites"
        viewController.delegate = presenter

        presenter.viewController = viewController

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true

        return navigationController
    }
}
