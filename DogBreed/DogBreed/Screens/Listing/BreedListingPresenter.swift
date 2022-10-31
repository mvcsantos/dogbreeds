//
//  BreedListingPresenter.swift
//  DogBreed
//
//  Created by Marcus Santos on 23/10/2022.
//

import Foundation

class BreedListingPresenter: ErrorHandling {

    let interactor: BreedsInteractorType
    let router: BreedListingRouterType
    weak var viewController: BrowserViewController?

    init(interactor: BreedsInteractorType, router: BreedListingRouterType) {

        self.interactor = interactor
        self.router = router
    }

    private func present(data: [Breed]) {

        let viewModels: [BreedListCell.ViewModel] = data
            .sorted { $0.name < $1.name }
            .map {
                .init(
                    id: $0.name.hashValue,
                    title: $0.name,
                    imageUrl: nil
                )
            }

        DispatchQueue.main.async { [weak self] in

            self?.viewController?.populate(data: viewModels)
        }
    }
}

extension BreedListingPresenter: BreedListingPresenterType {}

extension BreedListingPresenter: BrowserViewControllerDelegate {


    func viewWillAppear() {

        Task { [weak self, interactor = self.interactor] in
            do {
                let allBreeds = try await interactor
                    .listAllBreeds()
                self?.present(data: allBreeds)
            } catch {
                self?.handle(error: error)
            }
        }
    }

    func pullToRefresh() {

        viewWillAppear()
    }

    func wantsToNavigateToDetails(model: BreedListCell.ViewModel) {
        guard let breedName = model.title else {
            return
        }
        router.navigateToDetails(breedName: breedName)
    }

    func didTapOnCellButton(model: BreedListCell.ViewModel, buttonType: BreedListCell.ViewModel.ButtonType) {}

    func search(text: String) {}
}
