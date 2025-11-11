# Countries App

A Flutter mobile application for browsing, searching, and learning about the world's countries. Users can view detailed information for each country and manage a personal list of their favourites. This project was built to demonstrate a clean, scalable, and well-documented mobile architecture.

## App Preview

1- Home & Search
<img width="1080" height="2400" alt="Screenshot_1762887041" src="https://github.com/user-attachments/assets/9eae8752-76d7-4b53-82bc-a8ac33123244" />



2- Favourites
<img width="1080" height="2400" alt="Screenshot_1762887048" src="https://github.com/user-attachments/assets/c89df8ca-9613-4359-812d-41da88586458" />


3- Detail Page
<img width="1080" height="2400" alt="Screenshot_1762887058" src="https://github.com/user-attachments/assets/66880dbc-ea04-46ac-94e8-b9b1ded258ae" />


## Features

-   **Browse & Discover:** View a list of all countries in the world.
-   **Live Search:** Find any country by name with a real-time search filter.
-   **Detailed Information:** Tap on a country to see its flag, capital, population, region, area, and timezones.
-   **Favourites System:** Mark or unmark any country as a favourite.
-   **Persistent Favourites:** Your list of favourite countries is saved locally on your device and persists between app launches.
-   **Responsive Design:** The UI is designed to adapt to various phone screen sizes using flutter_screenutil
-   **Error Handling:** Clear error messages and a "Retry" option are shown for network failures.
-   **Loading States:** Smooth shimmer effects provide a great user experience while data is being fetched.


## How to Set Up and Run

### Prerequisites

-   Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
-   An IDE like VS Code or Android Studio with the Flutter plugin.
-   An emulator/simulator or a physical device to run the app.

### Running the Project Locally

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/countries-app.git
    cd countries-app
    ```

2.  **Get dependencies:**
    Run the following command to fetch all the necessary packages.
    ```bash
    flutter pub get
    ```

3.  **Run the app:**
    Start the application on your connected device or emulator.
    ```bash
    flutter run
    ```


## Environment Variables

This project connects to the public [REST Countries API](https://restcountries.com/) and **does not require any environment variables or API keys** to run.


## Technology and Architectural Choices

This application was built with a focus on creating a clean, scalable, and maintainable codebase.

### Architecture: Clean Architecture (Feature-First)

The project follows the principles of **Clean Architecture**, separating the code into three distinct layers: **Data, Domain, and Presentation**. The directory structure is organized by feature (`home`, `country_detail`, `favorites`), which makes the codebase modular and easy to navigate.

-   **Data Layer:** Responsible for all data operations. It includes data models, data sources (remote API and local database), and a repository implementation.
-   **Domain Layer:** Contains the core business logic and rules of the application. It defines repository contracts (interfaces) that the data layer implements. This decouples the application's logic from the specific data sources.
-   **Presentation Layer:** The UI layer of the app. It includes all the widgets, screens, and state management logic (Cubits). This layer only interacts with the Domain layer, making it completely unaware of where the data comes from.

### State Management: Cubit (from `flutter_bloc`)

**Cubit** was chosen as the state management solution for its simplicity, predictability, and scalability.

-   **Why Cubit?** For an application of this scope, Cubit provides a perfect balance of power and ease of use. It reduces boilerplate compared to the full BLoC pattern while still offering a robust, stream-based approach to state management. It makes the flow of data from user events to UI updates clear and easy to debug.
-   **State Synchronization:** The state of the favourites list is managed by a single `HomeCubit` that is "lifted" above both the Home and Favourites pages. This ensures that when a user favourites an item on one screen, the change is instantly reflected on the other, creating a seamless user experience.

### Other Key Technologies

-   **`dio`:** A powerful and robust HTTP client for making API calls. It's used for all communication with the REST Countries API.
-   **`get_it`:** A lightweight service locator used for dependency injection. It allows us to decouple our classes and easily provide dependencies (like repositories and data sources) wherever they are needed.
-   **`hive`:** A high-performance, key-value database used for local storage. It was chosen for its excellent speed and simplicity in persisting the user's list of favourite countries.
-   **`equatable`:** Used in our data models and states to prevent unnecessary widget rebuilds by enabling value-based equality checks.
-   **`google_fonts`:** To provide a clean and professional typography that matches the design mockups.
-   **`flutter_screenutil`:** To ensure the UI is fully responsive and adapts gracefully to a wide variety of screen sizes and pixel densities.
