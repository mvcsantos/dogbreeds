//
//  DetailsPresenter.swift
//  DogBreed
//
//  Created by Marcus Santos on 30/10/2022.
//

import UIKit

class DetailsPresenter: ErrorHandling {

    weak var viewController: BrowserViewControllerType?

    private let breedsInteractor: BreedsInteractorType
    private let breedsImageInteractor: BreedImageInteractorType
    private let favoritesInteractor: FavoritesInteractorType
    private let selectedBreed: String

    init(
        breedsInteractor: BreedsInteractorType,
        breedsImageInteractor: BreedImageInteractorType,
        favoritesInteractor: FavoritesInteractorType,
        selectedBreed: String
    ) {
        self.breedsInteractor = breedsInteractor
        self.breedsImageInteractor = breedsImageInteractor
        self.favoritesInteractor = favoritesInteractor
        self.selectedBreed = selectedBreed
    }

    private func present(data: [URL]) {

        let viewModels: [BreedListCell.ViewModel] = data
            .map {
                .init(
                    id: $0.absoluteString.hashValue,
                    title: "",
                    imageUrl: $0,
                    button: .like(isFavorite: favoritesInteractor.isFavorite(imageURL: $0))
                )
            }

        viewController?.populate(data: viewModels)
    }

}

extension DetailsPresenter: DetailsPresenterType {}

extension DetailsPresenter: BrowserViewControllerDelegate {

    func viewWillAppear() async {
        do {
            let imagesURL = try await breedsImageInteractor.imagesByBreed(breed: selectedBreed)
            present(data: imagesURL)
        } catch {
            handle(error: error)
        }
    }

    func wantsToNavigateToDetails(model: BreedListCell.ViewModel) {}

    func didTapOnCellButton(
        model: BreedListCell.ViewModel,
        buttonType: BreedListCell.ViewModel.ButtonType
    ) async {

        guard case .like = buttonType else {
            return
        }

        guard let imageURL = model.imageUrl else {
            return
        }
        await favoritesInteractor.toggleFavorite(imageURL: imageURL)
        await viewWillAppear()
    }

    func search(text: String) {
        
    }
}
