//
//  TabBarViewController.swift
//  DogBreed
//
//  Created by Marcus Santos on 23/10/2022.
//

import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {

    var controllerDelegate: TabBarControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        controllerDelegate?.viewWillAppear()
    }
}

extension TabBarController {

    func configureViewController(with config: [Configuration]) {

        let controllers: [UIViewController] = config.map { model in

            let tabBarItem = UITabBarItem(
                title: model.title,
                image: model.image,
                selectedImage: model.selectedImage
            )
            let vc = model.viewController
            vc.title = model.title
            vc.tabBarItem = tabBarItem

            return vc
        }

        self.viewControllers = controllers

        UITabBar.appearance().tintColor = UIColor(named: "iconColor")
    }
}

extension TabBarController {

    struct Configuration {
        
        let title: String
        let image: UIImage
        let selectedImage: UIImage
        let viewController: UIViewController
    }
}

extension TabBarController {

    enum Constants {

        enum SFSymbols {

            static let listBulletRectangle = "list.bullet.rectangle"
            static let listBulletRectangleFill = "list.bullet.rectangle.fill"
            static let star = "star"
            static let starFill = "star.fill"
        }
    }
}
