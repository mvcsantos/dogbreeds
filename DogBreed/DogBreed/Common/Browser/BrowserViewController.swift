//
//  BreedListingVC.swift
//  DogBreed
//
//  Created by Marcus Santos on 23/10/2022.
//

import UIKit

protocol BrowserViewControllerDelegate {

    func viewWillAppear()

    func pullToRefresh()

    func wantsToNavigateToDetails(model: BreedListCell.ViewModel)

    func didTapOnCellButton(model: BreedListCell.ViewModel, buttonType: BreedListCell.ViewModel.ButtonType)

    func search(text: String)
}

final class BrowserViewController: UIViewController {

    private typealias CellRegistration = UICollectionView.CellRegistration<BreedListCell, BreedListCell.ViewModel>
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, BreedListCell.ViewModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, BreedListCell.ViewModel>

    enum Section {
        case listing
    }

    private let contentView = BrowserView()
    private lazy var searchBar: UISearchBar = .init(frame: .zero)
    private lazy var dataSource: DataSource = {

        let cellRegistration = UICollectionView.CellRegistration<BreedListCell, BreedListCell.ViewModel> { [weak self] in
            $0.imageLoader = self?.breedImageInteractor
            $0.populate(data: $2)
            $0.buttonAction = { model, buttonType in
                self?.delegate?.didTapOnCellButton(model: model, buttonType: buttonType)
            }
        }
        return DataSource(
            collectionView: contentView.collectionView,
            cellProvider: { (collectionView, indexPath, cellData) -> UICollectionViewCell? in
                return collectionView.dequeueConfiguredReusableCell(
                    using: cellRegistration,
                    for: indexPath,
                    item: cellData
                )
            }
        )
    }()
    private let includeSearchBar: Bool

    var delegate: BrowserViewControllerDelegate?
    var breedImageInteractor: BreedImageInteractorType

    init(breedImageInteractor: BreedImageInteractorType, includeSearchBar: Bool = false) {

        self.breedImageInteractor = breedImageInteractor
        self.includeSearchBar = includeSearchBar
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDelegates()
        configureViewController()
        if includeSearchBar {
            setupNavigationBar()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        delegate?.viewWillAppear()
    }

    override func loadView() {
        view = contentView
    }

}

// MARK: - Private methods

extension BrowserViewController {

    private func setupDelegates() {
        searchBar.delegate = self
        contentView.collectionView.delegate = self
    }

    private func configureViewController() {

        view.backgroundColor = Assets.Color.backgroundColor
    }

    private func setupNavigationBar() {
        searchBar.placeholder = "Roof roof search..."
        navigationItem.titleView = searchBar
    }
}

// MARK: - Public methods

extension BrowserViewController {

    @MainActor
    func populate(data: [BreedListCell.ViewModel]) {

        if data.isEmpty {
            contentView
                .collectionView
                .setEmptyMessage("No favorite breeds?")
        } else {
            contentView
                .collectionView
                .restore()
        }

        var snapshot = Snapshot()
        snapshot.appendSections([Section.listing])
        snapshot.appendItems(data)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    func error(title: String, message: String) {

        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

// MARK: - UISearchBar Delegate

extension BrowserViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        delegate?.search(text: searchText)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if searchBar.canResignFirstResponder {
            searchBar.resignFirstResponder()
        }
    }
}

// MARK: - CollectionView Delegate

extension BrowserViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let model = dataSource.itemIdentifier(for: indexPath) else {
            error(title: "Ops", message: "This item is not available at the momment")
            return
        }

        delegate?.wantsToNavigateToDetails(model: model)
    }
}
