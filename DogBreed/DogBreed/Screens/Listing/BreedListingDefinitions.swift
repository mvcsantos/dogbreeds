//
//  BreedListDefinitions.swift
//  DogBreed
//
//  Created by Marcus Santos on 23/10/2022.
//

import UIKit

protocol BreedListingModuleType {
    func makeViewController() -> UIViewController
}

protocol BreedListingRouterType {

    func navigateToDetails(breedName: String)
}

protocol BreedListingPresenterType {}

