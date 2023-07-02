//
//  BrowserViewControllerType.swift
//  DogBreed
//
//  Created by Marcus Santos on 07/11/2022.
//

import Foundation

protocol BrowserViewControllerType: AnyObject {
    func populate(data: [BreedListCell.ViewModel])
    func error(title: String, message: String)
}

protocol BrowserViewControllerDelegate {

    func viewWillAppear() async

    func wantsToNavigateToDetails(model: BreedListCell.ViewModel)

    func didTapOnCellButton(model: BreedListCell.ViewModel, buttonType: BreedListCell.ViewModel.ButtonType) async

    func search(text: String)
}
