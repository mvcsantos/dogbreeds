//
//  TabBarModule.swift
//  DogBreed
//
//  Created by Marcus Santos on 23/10/2022.
//

import UIKit

final class TabBarModule {

    let listingModule: BreedListingModuleType
    let favoritesModule: FavoritesModuleType

    init(listingModule: BreedListingModuleType, favoritesModule: FavoritesModuleType) {
        self.listingModule = listingModule
        self.favoritesModule = favoritesModule
    }
}

extension TabBarModule: TabBarModuleType {

    func makeVC() -> UIViewController {

        let listingVC = listingModule.makeViewController()
        let favoritsVC = favoritesModule.makeViewController()
        let presenter = TabBarPresenter(listingVC: listingVC, favoritsVC: favoritsVC)
        let viewController = TabBarController()

        presenter.viewController = viewController
        viewController.controllerDelegate = presenter

        return viewController
    }
}
