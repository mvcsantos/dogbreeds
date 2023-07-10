## Overview

This repository showcases a project called Dog Breed App, which demonstrates my skills and approach to software development. The main goal of the project was to create a minimalistic design for the app while focusing on scalability, testability, and reusability. The architecture of the app is based on Clean Architecture principles by Martin Fowler.

## Key Features

### Breed Listing (Screen 1)

- Default Screen: Upon opening the app, the Breed Listing tab is displayed.
- Asynchronous Image Loading: The screen efficiently loads images using a custom loader and cache mechanism. This approach minimizes unnecessary API calls, assuming the content remains static. (Cache policy can be adjusted as needed).

### Details (Screen 2)

- Image Listing by Breed: This screen presents a list of all available images categorized by breed.
- Favorite Image Toggle: Users can toggle their favorite images, marking them for easy access.

### Favorites (Screen 3)

- Favorite Image List: Users can view a comprehensive list of their favorite images.
- Remove from Favorites: The app allows users to remove images from their favorites.
- Simple Search Functionality: A search feature is provided to facilitate searching within the favorites.
- Enhanced User Experience: The keyboard is automatically hidden when scrolling through the CollectionView.

### Data Storage

- In-Memory Favorites: Currently, the app stores favorites in memory. In real-world scenarios, this functionality is typically supported by an API or a third-party database.

## Technologies Used

- Language: Swift
- Framework: UIKit
- Networking Package: Lightweight Networking (SPM)
- Concurrency: Structured Concurrency

## Third-Party Dependencies

- DIP: A DI (Dependency Injection) container used to manage dependencies.
- Cuckoo: A mocking framework for creating test doubles.

## Installation

To get the project up and running on your local machine, follow these steps:

1. Clone the repository: `git clone [repository URL]`
2. Navigate to the "DogBreed" folder: `cd DogBreed`
3. Open the Xcode project: `open DogBreed.xcodeproj`
4. Build and run the project using Xcode's simulator or a physical device.

## Folder Structure

- `DogBreed/`: Contains the Xcode project for the Dog Breed App.
- `LWNetworking/`: Includes the lightweight networking package used in the project.

## Additional Information

- Light and Dark Mode Support: The app supports both light and dark mode.
- Localization: Localization was not taken into account in this app.
- Target iOS Version: The current target is iOS 14, considering two major previous releases.
