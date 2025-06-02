# Cats App

A simple iOS application to explore and display cat images fetched from the [CATAAS API](https://cataas.com/). The app demonstrates a robust MVVMC (Model-View-ViewModel-Coordinator) architecture and modern iOS development practices.

---

## Features

- **Cat List**: Displays an infinite scrollable collection of cat images with their respective labels (tags).
- **Infinite Scrolling**: Automatically loads more cats as the user scrolls down the list.
- **Detail Screen**: Tapping a cat image in the list navigates the user to a detail screen that shows the image in a larger size, its ID, and associated tags.
- **Date Formatting**: Cat creation dates are formatted from a string into a human-readable English format.
- **Dynamic Tags**: Tags on the detail screen are displayed in a "pill" layout that automatically adjusts and wraps to the next line.
- **Image Caching**: Cat images are cached in memory for fast and efficient loading.

---

## Architecture and Technologies Used

This project was built following the principles of a clean and organized architecture, utilizing the following elements:

### MVVMC (Model-View-ViewModel-Coordinator)

- **Model**: Represents the data and business logic.  
  File: `Cat.swift`

- **View**: User Interface (UI) components that display data and react to user interactions.  
  Files:  
  - `CatListViewController.swift`  
  - `CatCollectionViewCell.swift`  
  - `CatDetailsViewController.swift`

- **ViewModel**: Acts as an intermediary layer between the View and the Model, transforming Model data into something the View can display and handling presentation logic.  
  Files:  
  - `CatListViewModel.swift`  
  - `CatDetailsViewModel.swift`

- **Coordinator**: Manages the navigation flow between different screens, decoupling navigation logic from ViewModels and ViewControllers.  
  File: `AppCoordinator.swift`

---

### Technologies

- **UIKit**: Apple's framework for building native iOS user interfaces.
- **Programmatic Auto Layout**: All layout constraints are defined via code for greater control and flexibility.
- **URLSession**: Used for all network operations, such as fetching the list of cats and their images.
- **NSCache**: Implemented for in-memory image caching, improving performance when scrolling the list.
- **DateFormatter**: Used to convert date strings into `Date` objects and format them for display in a readable format.
- **Swift Extensions**: Used to add functionalities to existing types in an organized manner.  
  Examples:  
  - `UIImageView+Ext.swift` (image loading)  
  - `URL+Ext.swift` (query parameters)
- **Lazy Initialization (`lazy var`)**: Used to initialize UI properties only when they are accessed for the first time, optimizing memory usage.
- **UICollectionView**: Employed in `CatListViewController` to efficiently display a grid of cat images, supporting infinite scrolling and cell reuse.
- **UIStackView**: Utilized in `CatDetailsViewController` to organize UI elements vertically and horizontally, specifically for dynamic tag display with automatic line wrapping.

---

## How to Run the Project

1. Clone the repository:
   ```bash
   git clone https://docs.github.com/en/repositories/creating-and-managing-repositories/about-repositories
   ```

2. Navigate to the project directory:
   ```bash
   cd cats-app
   ```

3. Open the project in Xcode:
   ```bash
   open cats-app.xcodeproj
   ```

4. Select an iOS simulator or device.

5. Run the application:  
   Press `Cmd + R` or click the **Run** button in Xcode.
