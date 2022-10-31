//
//  BreedListingPresenter.swift
//  DogBreed
//
//  Created by Marcus Santos on 23/10/2022.
//

import UIKit

class TabBarPresenter {

    weak var viewController: TabBarController?

    let listingVC: UIViewController
    let favoritsVC: UIViewController

    init(listingVC: UIViewController, favoritsVC: UIViewController) {
        self.listingVC = listingVC
        self.favoritsVC = favoritsVC
    }

    private func generateModels() -> [TabBarController.Configuration] {

        let models: [TabBarController.Configuration] = [
            .init(
                title: Constants.Localized.listingTabName,
                image: Constants.listingTabIcon,
                selectedImage: Constants.listingTabIconSelected,
                viewController: listingVC
            ),
            .init(
                title: Constants.Localized.favoritsTabName,
                image: Constants.favoritsTabIcon,
                selectedImage: Constants.favoritsTabIconSelected,
                viewController: favoritsVC
            )
        ]

        return models
    }
}

extension TabBarPresenter: TabBarPresenterType {}

extension TabBarPresenter: TabBarControllerDelegate {

    func viewWillAppear() {

        let models = generateModels()
        viewController?.configureViewController(with: models)
    }
}

extension TabBarPresenter {

    enum Constants {

        static var listingTabIcon: UIImage {
            UIImage(systemName: Constants.SFSymbols.listBulletRectangle)!
                .withRenderingMode(.alwaysTemplate)
        }
        static var listingTabIconSelected: UIImage {
            UIImage(systemName: Constants.SFSymbols.listBulletRectangleFill)!
                .withRenderingMode(.alwaysTemplate)
        }
        static var favoritsTabIcon: UIImage {
            UIImage(systemName: Constants.SFSymbols.star)!
                .withRenderingMode(.alwaysTemplate)
        }
        static var favoritsTabIconSelected: UIImage {
            UIImage(systemName: Constants.SFSymbols.starFill)!
                .withRenderingMode(.alwaysTemplate)
        }

        enum Localized {

            static let listingTabName = "Breeds"
            static let favoritsTabName = "Favorits"
        }

        enum SFSymbols {

            static let listBulletRectangle = "list.bullet.rectangle"
            static let listBulletRectangleFill = "list.bullet.rectangle.fill"
            static let star = "star"
            static let starFill = "star.fill"
        }
    }
}
