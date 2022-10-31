//
//  BreedListingView.swift
//  DogBreed
//
//  Created by Marcus Santos on 23/10/2022.
//

import UIKit

final class BrowserView: UIView {

    let collectionView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = .init(top: 8, leading: 8, bottom: 20, trailing: 8)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.6)
        )
        let groupLayout = NSCollectionLayoutGroup
            .horizontal(
                layoutSize: groupSize,
                subitem: itemLayout,
                count: 2
            )
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)

        let layout = UICollectionViewCompositionalLayout(section: section)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = Assets.Color.backgroundColor.withAlphaComponent(0.7)

        return collectionView
    }()

    convenience init() {
        self.init(frame: .zero)
        configureView()
        configureSubviews()
        configureConstraints()
    }

    private func configureView() {
        backgroundColor = Assets.Color.backgroundColor.withAlphaComponent(0.7)
    }

    private func configureSubviews() {
        addSubview(collectionView)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
}
