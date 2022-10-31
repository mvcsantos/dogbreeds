//
//  TabBarDefinitions.swift
//  DogBreed
//
//  Created by Marcus Santos on 23/10/2022.
//

import UIKit

protocol TabBarModuleType {
    func makeVC() -> UIViewController
}

protocol TabBarRouterType {

    func navigateToDetails()
}

protocol TabBarPresenterType {}

protocol TabBarControllerDelegate: AnyObject {

    func viewWillAppear()
}
