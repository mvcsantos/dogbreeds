# Dog Breed iOS App

My main goal was to create a minimalistic design for the App and focus on desining the App for scalability (allowing multiple team members to work on different parts of the app without stumbling on each other toes), testability (allowing to independently test business logic, presentation logic and UI indenpendently) and reusability. The architecture of the App was based on Clean Architecture, by Martin Fowler.

## Breed listing:

* By default, the App opens on the Breed Listing tab
* The screen loads all the images asynchronouly using a custom loader and cache to avoid unnecessary API calls since the content is assumed static (the cache policy can be changed accordingly)

## Details:

* Shows a list of all the available images by breed
* Allows the user to toggle a favorite image

## Favorites:

* Shows a list of all the favorite images
* Allows the user to remove favorite image
* Provides a simple searching functionality over the favorites
* Hides keyboard when scrolling on the CollectionView
* The favorites are currently being store in memory since in a real use case this functionality is either provided by an API or a third party Database

## Notes:
* The app supports both light and dark mode
* Localization was not taken into account in this App
* A single third party package was use to provide DI (Dependency Injection) container
* The current target is iOS 14 to take into account 2 major previous releases
