//
//  BreedsInteractorTests.swift
//  DogBreedTests
//
//  Created by Marcus Santos on 07/11/2022.
//

import XCTest
import Cuckoo

@testable import DogBreed

final class BreedListingPresenterTests: XCTestCase {

    let breedsInteractorMock = MockBreedsInteractorType()
    let routerMock = MockBreedListingRouterType()
    let viewControllerMock = MockBrowserViewControllerType()

    override func tearDownWithError() throws {

        reset(breedsInteractorMock)
    }

    func test_initialLoading_whenViewWillAppear_then() async {

        stub(breedsInteractorMock) { stub in
            when(stub.listAllBreeds())
                .thenReturn(Constants.interactorReturnValue)
        }

        stub(viewControllerMock) { stub in
            when(stub.populate(data: any()))
                .thenDoNothing()
        }

        let presenter = BreedListingPresenter(
            interactor: breedsInteractorMock,
            router: routerMock
        )
        presenter.viewController = viewControllerMock

        await presenter.viewWillAppear()

        verify(breedsInteractorMock).listAllBreeds()
        verify(viewControllerMock).populate(data: any())
        verifyNoMoreInteractions(breedsInteractorMock)
        verifyNoMoreInteractions(viewControllerMock)
    }
}

extension BreedListingPresenterTests {

    enum Constants {

        static let breedNameA = "Breed Name A"
        static let breedNameB = "Breed Name B"

        static let interactorReturnValue = [
            Breed(name: breedNameA, subBreed: []),
            Breed(name: breedNameB, subBreed: [])
        ]
    }
}
