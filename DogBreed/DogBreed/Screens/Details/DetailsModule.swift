//
//  DetailsModule.swift
//  DogBreed
//
//  Created by Marcus Santos on 30/10/2022.
//

import UIKit

final class DetailsModule {

    let breedInteractor: BreedsInteractorType
    let breedImageInteractor: BreedImageInteractorType
    let favoritesInteractor: FavoritesInteractorType

    init(
        breedInteractor: BreedsInteractorType,
        breedImageInteractor: BreedImageInteractorType,
        favoritesInteractor: FavoritesInteractorType
    ) {
        self.breedInteractor = breedInteractor
        self.breedImageInteractor = breedImageInteractor
        self.favoritesInteractor = favoritesInteractor
    }
}

extension DetailsModule: DetailsModuleType {

    func makeViewController(breed: String) -> UIViewController {

        let presenter = DetailsPresenter(
            breedsInteractor: breedInteractor,
            breedsImageInteractor: breedImageInteractor,
            favoritesInteractor: favoritesInteractor,
            selectedBreed: breed
        )
        let viewController = BrowserViewController(breedImageInteractor: breedImageInteractor)
        viewController.title = breed
        viewController.delegate = presenter

        presenter.viewController = viewController

        return viewController
    }
}
