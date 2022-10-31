//
//  DetailsDefinitions.swift
//  DogBreed
//
//  Created by Marcus Santos on 30/10/2022.
//

import UIKit

protocol FavoritesModuleType {

    func makeViewController() -> UIViewController
}

protocol FavoritesPresenterType {}

protocol FavoritesViewControllerDelegate {

    func viewWillAppear()
}
