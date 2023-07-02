//
//  DetailsPresenter.swift
//  DogBreed
//
//  Created by Marcus Santos on 30/10/2022.
//

import UIKit

class FavoritesPresenter {

    weak var viewController: BrowserViewController?
    let favoritesInteractor: FavoritesInteractorType

    init(favoritesInteractor: FavoritesInteractorType) {
        self.favoritesInteractor = favoritesInteractor
    }

    private func present(data: [URL]) {

        let viewModels: [BreedListCell.ViewModel] = data
            .map {
                var components = $0.pathComponents
                components.removeLast()
                let breedName = components.last ?? ""

                return .init(
                    id: $0.absoluteString.hashValue,
                    title: breedName,
                    imageUrl: $0,
                    button: .remove
                )
            }
            .sorted { $0.title ?? "" < $1.title ?? "" }

        DispatchQueue.main.async { [weak self] in

            self?.viewController?.populate(data: viewModels)
        }
    }
}

extension FavoritesPresenter: FavoritesPresenterType {}

extension FavoritesPresenter: BrowserViewControllerDelegate {

    func viewWillAppear() async {

        let imagesURL = await favoritesInteractor.retrieveAllFavorites()
        present(data: imagesURL)
    }

    func wantsToNavigateToDetails(model: BreedListCell.ViewModel) {}

    func didTapOnCellButton(model: BreedListCell.ViewModel, buttonType: BreedListCell.ViewModel.ButtonType) async {

        guard case .remove = buttonType else {
            return
        }

        guard let imageURL = model.imageUrl else {
            return
        }
        await favoritesInteractor.toggleFavorite(imageURL: imageURL)
        await viewWillAppear()
    }

    func search(text: String) {
        let filteredList = favoritesInteractor.search(text: text)
        present(data: filteredList)
    }
}
