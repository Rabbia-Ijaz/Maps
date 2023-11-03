# Maps App


![Maps App Screenshot](https://user-images.githubusercontent.com/63001234/236641517-652fa68a-3877-4394-8e7f-747f76ac31dd.png)

Maps is an iOS app that allows users to search for cities and view their locations on a map using MapKit. It integrates with the Spott API from Rapid API to retrieve city data, including city name, population, and more.

## Application flow

- Home screen is a map containing a search option. As user types, pins for matching cities are rendered on the map. (See GET /places /autocomplete)
Population in the UI should be formatted according to the users preference
- Tapping on a pin you should see City name, Population, Button to detail screen
- Details screen should fetch detail info (See GET /places/{id}) containing
- A map with only one pin (selected city)

## Features

- Search for cities using the Spott API.
- Display city locations on a Map with annotations.
- View city details, including name and population.
- Navigate to a detail screen for more information.

## User Interface (UI)

The City Maps app's user interface is entirely constructed programmatically in Swift code, without the use of .xib files or storyboards. This approach offers more flexibility and control over the app's design and layout. Here are some key points about the UI:

- No .xib files or storyboards are used in the project.
- The app's UI is created using Swift code, allowing for dynamic and responsive user interfaces.
- Autolayout and constraints are utilized to ensure the app's UI adapts to different device sizes and orientations.
- The UI code is well-documented for easier maintenance and modification.

## App Architecture

![App Architecture](https://user-images.githubusercontent.com/63001234/236641495-8be28eb9-cd3b-4914-8e91-0b3446dbf678.png)


## How to Use

1. Clone or download the project from this GitHub repository.

2. Open the project in Xcode.
   
4. open Maps/Maps/NetworkRequests/SpottApi.swift file and in place of "<add api key>" replace with the your api key you will get on [Spott API Access](https://rapidapi.com/Spott/api/spott/)

5. Build and run the app on your iOS device or simulator.

6. Enter a city name in the search bar and click the search button.

7. The app will display the city locations on the map with annotations.

8. Click on a location to view city details, including name and population.

9. Click the "Details" button to see a detailed view of the selected location on the map along with additional information.

## Technologies Used

- Swift
- MapKit
- Spott API (Rapid API)
- MVVM Architecture

## Contact

If you have any questions or feedback, please feel free to contact the project maintainer:

- Email: rabbiaijaz19@gmail.com

Enjoy using the Maps app!

