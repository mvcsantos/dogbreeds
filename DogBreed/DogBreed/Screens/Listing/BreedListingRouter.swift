//
//  BreedListingRouter.swift
//  DogBreed
//
//  Created by Marcus Santos on 23/10/2022.
//

import UIKit

class BreedListingRouter {

    var navigationController: UINavigationController?
    let detailsModule: DetailsModuleType

    init(detailsModule: DetailsModuleType) {
        self.detailsModule = detailsModule
    }
}

extension BreedListingRouter: BreedListingRouterType {

    func navigateToDetails(breedName: String) {

        let vc = detailsModule.makeViewController(breed: breedName)
        navigationController?.pushViewController(vc, animated: true)
    }
}
