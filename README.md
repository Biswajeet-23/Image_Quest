# Image Quest

## Overview

This Flutter application, named "Animelia," allows users to search for images using keywords and displays the search results in a grid view. The app fetches images from the Unsplash API and uses the cached_network_image package to display them efficiently. It also includes error handling in case image loading fails.

## Instructions:

Follow these steps to run the Image Search App on your local machine:

### 1. Prerequisites:

- Make sure you have Flutter installed. If not, follow the Flutter installation guide to set up your development environment.

### 2. Clone the Repository: 

- Clone this GitHub repository to your local machine using the following command: **git clone https://github.com/your-username/animelia-image-search-app.git**

### 3. Install Dependencies:

- Run the following command to fetch and install the project's dependencies: **flutter pub get**

### 4. Configure API Key:

- To fetch images from the Unsplash API, you need to obtain an API key from the Unsplash Developer Dashboard. Once you have the API key, replace the apiKey variable in image_screen.dart with your API key.

### 5. Run the App:

- Connect your Android or iOS device or start an emulator/simulator.
- Run the app using the following command: **flutter run**

### 6. Using the App:

- The app will open, and you will see a search bar at the top.
- Enter a keyword in the search bar and tap the search icon.
- Images related to your keyword will appear in a grid view below.
- Scroll down to load more images if available.
- If an image fails to load, an error icon will be displayed.

## Issues and Bugs:

- If you encounter any issues or find a bug in the app, please open an issue on the GitHub repository with a detailed description of the problem.

## License:

- This project is licensed under the MIT License. See the [LICENSE](https://github.com/Biswajeet-23/Image_Quest/blob/master/LICENSE) file for details.
