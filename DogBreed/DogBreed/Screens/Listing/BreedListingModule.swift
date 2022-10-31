//
//  BreedListingModule.swift
//  DogBreed
//
//  Created by Marcus Santos on 23/10/2022.
//

import UIKit

final class BreedListingModule {

    let breedInteractor: BreedsInteractorType
    let breedImageInteractor: BreedImageInteractorType
    let detailsModule: DetailsModuleType
    
    init(
        breedInteractor: BreedsInteractorType,
        breedImageInteractor: BreedImageInteractorType,
        detailsModule: DetailsModuleType
    ) {
        self.breedInteractor = breedInteractor
        self.breedImageInteractor = breedImageInteractor
        self.detailsModule = detailsModule
    }
}

extension BreedListingModule: BreedListingModuleType {

    func makeViewController() -> UIViewController {

        let router = BreedListingRouter(detailsModule: detailsModule)
        let presenter = BreedListingPresenter(
            interactor: breedInteractor,
            router: router
        )
        let viewController = BrowserViewController(breedImageInteractor: breedImageInteractor)
        viewController.title = "Breeds"
        viewController.delegate = presenter

        presenter.viewController = viewController

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        router.navigationController = navigationController

        return navigationController
    }
}
