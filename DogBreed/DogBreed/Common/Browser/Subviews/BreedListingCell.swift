//
//  BreedListingCell.swift
//  DogBreed
//
//  Created by Marcus Santos on 23/10/2022.
//

import UIKit

final class BreedListCell: UICollectionViewCell {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadius
        return imageView
    }()

    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Constants.handThumbsupFillImage, for: .selected)
        button.setImage(Constants.handThumbsupImage, for: .normal)

        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = Assets.Color.textColor
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0

        return label
    }()

    private var dataTask: URLSessionDataTask?

    var model: ViewModel?
    var buttonAction: ((ViewModel, ViewModel.ButtonType) -> Void)?
    weak var imageLoader: BreedImageInteractorType?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureView()
        configureSubviews()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    private func configureView() {
        contentView.layer.cornerRadius = Constants.cornerRadius

        button.addTarget(self, action: #selector(cellButtonAction), for: .touchUpInside)
    }

    private func configureSubviews() {
        [imageView, titleLabel, button].forEach { contentView.addSubview($0) }
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.descriptionTopAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: button.leadingAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.descriptionTopAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),

            button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.descriptionTopAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.descriptionBottomAnchor)
        ])
    }

    override func prepareForReuse() {
        titleLabel.text = ""
        imageView.image = nil
        dataTask?.cancel()
    }

    @objc private func cellButtonAction(sender: UIButton!) {

        if let buttonAction, let model {
            buttonAction(model, model.button)
        }
    }

    private func updateContent(model: ViewModel) {
        self.model = model

        titleLabel.text = model.title
        updateButton(buttonType: model.button)
    }

    func updateButton(buttonType: ViewModel.ButtonType) {

        switch buttonType {
        case .like(let isFavorite):
            button.setImage(Constants.handThumbsupFillImage, for: .selected)
            button.setImage(Constants.handThumbsupImage, for: .normal)
            button.isSelected = isFavorite
            button.isHidden = false

        case .remove:
            button.setImage(Constants.trashFillImage, for: .normal)
            button.isHidden = false

        case .none:
            button.isHidden = true
        }

    }

    func updateImage(model: ViewModel) {

        if let imageURL = model.imageUrl {
            loadImage(url: imageURL)
        } else {
            Task { [weak self] in
                guard let breedName = model.title,
                      let imageURL = try? await imageLoader?.randomImageForBreed(breed: breedName) else {
                    return
                }
                self?.loadImage(url: imageURL)
            }
        }
    }
}

extension BreedListCell {

    struct ViewModel: Hashable, Equatable {

        let id: Int
        let title: String?
        let imageUrl: URL?
        let button: ButtonType

        init(id: Int, title: String, imageUrl: URL? = nil, button: ButtonType = .none) {
            self.id = id
            self.title = title
            self.imageUrl = imageUrl
            self.button = button
        }

        enum ButtonType: Equatable, Hashable {
            case like(isFavorite: Bool)
            case remove
            case none
        }
    }

    private func loadImage(url: URL) {

        DispatchQueue.main.async { [weak self] in

            self?.dataTask = self?.imageView.load(url: url)
            self?.dataTask?.resume()
        }
    }

    func populate(data: ViewModel) {

        updateContent(model: data)
        updateImage(model: data)
    }
}


extension BreedListCell {

    enum Constants {

        static let descriptionTopAnchor: CGFloat = 5
        static let descriptionBottomAnchor: CGFloat = 5

        static var handThumbsupImage: UIImage {
            UIImage(systemName: Constants.SFSymbols.handThumbsup)!
                .withRenderingMode(.alwaysTemplate)
        }
        static var handThumbsupFillImage: UIImage {
            UIImage(systemName: Constants.SFSymbols.handThumbsupFill)!
                .withRenderingMode(.alwaysTemplate)
        }
        static var trashFillImage: UIImage {
            UIImage(systemName: Constants.SFSymbols.trashFill)!
                .withRenderingMode(.alwaysTemplate)
        }

        static let cornerRadius: CGFloat = 10

        enum SFSymbols {

            static let handThumbsup = "hand.thumbsup"
            static let handThumbsupFill = "hand.thumbsup.fill"
            static let trashFill = "trash.fill"
        }
    }
}
