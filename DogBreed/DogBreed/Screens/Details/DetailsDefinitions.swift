//
//  DetailsDefinitions.swift
//  DogBreed
//
//  Created by Marcus Santos on 30/10/2022.
//

import UIKit

protocol DetailsModuleType {

    func makeViewController(breed: String) -> UIViewController
}

protocol DetailsPresenterType {}

protocol DetailsViewControllerDelegate: AnyObject {

    func viewWillAppear()
}
