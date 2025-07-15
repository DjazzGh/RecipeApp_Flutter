# Flutter Recipe App

## Overview
This Flutter application allows users to manage their favorite recipes, categorized as either Salty or Sugary. Users can add new recipes, view details, and store their data locally using SQLite. The app features a modern UI, custom transitions, and image assets for a visually appealing experience.

## Features
- Welcome home page with app logo
- Add new recipes with:
  - Title
  - Ingredients (add/remove dynamically)
  - Cooking time (with unit selection)
  - Steps
  - Difficulty (1-5 stars)
- Categorize recipes as Salty or Sugary
- View a list of all recipes
- View detailed information for each recipe
- Persistent storage using SQLite (`sqflite`)
- Delete all recipes (reset database)
- Custom page transitions

## Screenshots
<img src="screenshot.jpeg" alt="Screenshot" width="300" height="600"/>


## Demo Video
[Demo Video Link](https://drive.google.com/file/d/1U3WdxEE9ybhgYlJ302uFvOCK-LAsOWjT/view) 

## Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart SDK (included with Flutter)

### Installation
1. Clone this repository:
   ```bash
   git clone <your-repo-url>
   cd AppFlutter
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Project Structure
- `lib/main.dart` - App entry point
- `lib/pages/` - All main pages:
  - `home.dart` - Welcome and navigation
  - `NextPage.dart` - Recipe list and search
  - `NewRecipePage.dart` - Category selection
  - `SaltyRecipePage.dart` - Add salty recipes
  - `SugaryRecipePage.dart` - Add sugary recipes
  - `RecipeDetailPage.dart` - View recipe details
  - `DatabaseHelper.dart` - SQLite database logic
- `lib/assets/` - Image assets (Logo, Salt, Sugar)

## Assets
- `assets/Logo.png` - App logo
- `assets/Salt.png` - Salty category icon
- `assets/Sugar.png` - Sugary category icon

## Dependencies
- `flutter`
- `sqflite` - SQLite database
- `path` - File path utilities
- `cupertino_icons` - iOS style icons
- `page_transition` - Custom page transitions

