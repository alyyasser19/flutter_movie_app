# The Movie App

This is a movie app created using flutter, using TMDB API.

## Getting Started

To get started a .env file must be created with the following and place it in the root direcory of the project:

```
API_KEY_V3  = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
API_READ_V4 = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

To obtain the keys simply go to [TMDB](https://www.themoviedb.org/), and create an account.

## How to Use

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/alyyasser19/flutter_movie_app.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get 
```

### Libraries & Tools Used

* [Flutter Dotenv](https://pub.dev/packages/flutter_dotenv)
* [TMDB API](https://pub.dev/packages/tmdb_api)
* [Shared_Preferences](https://pub.dev/packages/shared_preferences)
* [Lottie](https://pub.dev/packages/lottie)
* [Material Floating Search Bar](https://pub.dev/packages/material_floating_search_bar)
* [Cupertino Icons](https://pub.dev/packages/cupertino_icons)

### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- assets
```

Here is the folder structure we have been using in this project

```
lib/
|- API/
|- models/
|- routes/
|- Screens/
|- widgets/
|- main.dart
|- app.dart
```

## Screenshots

![App Screenshot1](/screenshots/SS1.png)
![App Screenshot2](/screenshots/SS2.png)

