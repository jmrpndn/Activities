# ServiceHub - Complete Flutter Mobile Services App

A comprehensive single-file Flutter application that demonstrates **ALL** Activity 1 and Activity 2 requirements in one consolidated Dart file (`lib/complete_app.dart`).

## 📁 Single-File Implementation

The entire application is contained in `lib/complete_app.dart` with the following structure:

```dart
lib/
├── main.dart              # Simple export of complete_app.dart
└── complete_app.dart      # Complete implementation with all features
```

### Why Single-File Implementation?

1. **Simplicity**: Everything in one place for easy understanding and demonstration
2. **Portability**: Single file can be easily shared and run anywhere
3. **Learning**: Perfect for educational purposes - all concepts visible at once
4. **Completeness**: Demonstrates all required features without file navigation
5. **Self-Contained**: No external dependencies or complex folder structure

## Widget Tree Hierarchy

### Main App Widget Tree

```
ServiceHubApp (MaterialApp)
├── MainNavigationScreen (StatefulWidget)
│   ├── Scaffold
│   │   ├── body: _screens[_currentIndex]
│   │   │   ├── HomeScreen
│   │   │   ├── ServicesScreen
│   │   │   ├── ProfileScreen
│   │   │   └── LayoutDemoScreen
│   │   ├── bottomNavigationBar: BottomNavigationBar
│   │   │   └── BottomNavigationBarItem (4 items)
│   │   └── drawer: Drawer
│   │       └── ListView
│   │           └── ListTile (multiple items)
│   └── State Management
│       └── _currentIndex (int)
```

### HomeScreen Widget Tree

```
HomeScreen (StatefulWidget)
├── Scaffold
│   ├── AppBar
│   │   ├── Text (title)
│   │   └── IconButton (profile)
│   ├── drawer: Drawer
│   │   └── ListView
│   │       ├── DrawerHeader
│   │       └── ListTile (multiple)
│   ├── body: Column
│   │   ├── Container (header with Row)
│   │   │   └── Row (3 Text widgets)
│   │   ├── Container (buttons section)
│   │   │   └── Row
│   │   │       └── CustomButton (2 buttons)
│   │   └── Expanded
│   │       └── MasonryGridView
│   │           └── ServiceCard (multiple)
│   ├── bottomNavigationBar: BottomNavigationBar
│   └── floatingActionButton: FloatingActionButton
└── State Management
    ├── _services (List<Service>)
    └── _isLoading (bool)
```

### ServiceCard Widget Tree (Reusable Component)

```
ServiceCard (StatelessWidget)
├── Card
│   └── InkWell
│       └── Column
│           ├── ClipRRect
│           │   └── Container
│           │       └── Image.network (or Icon)
│           └── Padding
│               └── Column
│                   ├── Text (title)
│                   ├── Text (description)
│                   └── Row
│                       ├── Text (price)
│                       └── Row (rating)
│                           ├── Icon (star)
│                           └── Text (rating + reviews)
```

## Features Implemented

### Activity 1 - Core Flutter Concepts

1. ✅ **Organized Project Structure**
   - Created folders: models, views, widgets, services
   - Clean separation of concerns

2. ✅ **Hello World StatelessWidget**
   - Simple greeting screen with icons and text
   - Demonstrates basic StatelessWidget usage

3. ✅ **Hello World StatefulWidget with Counter**
   - Counter functionality with increment, decrement, and reset
   - State management demonstration

4. ✅ **Custom Reusable Button Widget**
   - `CustomButton` widget used across multiple screens
   - Supports both Material and Cupertino designs
   - Configurable colors, sizes, and callbacks

5. ✅ **Material Design and Cupertino Widgets**
   - Services screen switches between Material and Cupertino designs
   - Demonstrates platform-specific UI patterns

6. ✅ **Navigation with Drawer and BottomNavigationBar**
   - Drawer navigation for main menu
   - BottomNavigationBar for quick access
   - Multiple screens with proper navigation

7. ✅ **Widget Tree Documentation**
   - Detailed hierarchy explanation above
   - Parent-child relationships clearly defined

8. ✅ **Refactored Widget Tree**
   - Large widgets broken into smaller, reusable components
   - ServiceCard, ProfileCard, ChatBubble widgets
   - Improved maintainability and reusability

9. ✅ **Third-Party Package Integration**
   - `flutter_staggered_grid_view` for MasonryGridView
   - Staggered layout for service cards

10. ✅ **Project Documentation**
    - Comprehensive README with structure explanation
    - Widget tree diagrams and hierarchy documentation

### Activity 2 - Layout and UI Components

1. ✅ **Three Text widgets in a Row with equal spacing**
   - HomeScreen header section with "Discover", "Services", "Near You"

2. ✅ **Two buttons in a Column, centered**
   - HomeScreen action buttons section
   - Vertically and horizontally centered

3. ✅ **Container with padding, margin, and background color**
   - ProfileScreen information container
   - Styled with rounded corners and border

4. ✅ **Profile card layout with Row and Column**
   - ProfileCard widget combining Row (image + name) and Column (details)

5. ✅ **Responsive layout using Expanded**
   - ProfileScreen rating and services containers
   - Two containers sharing screen width equally

6. ✅ **Navigation bar using Row with icons**
   - ProfileScreen navigation section
   - Icons spaced evenly across the row

7. ✅ **Stack layout with background and floating button**
   - LayoutDemoScreen Stack demo
   - Background gradient with floating action button overlay

8. ✅ **Flexible widgets for orientation changes**
   - LayoutDemoScreen Flexible demo
   - Dynamic resizing based on screen orientation

9. ✅ **Chat bubble UI with rounded borders**
   - ChatBubble widget with padding, margin, and rounded corners
   - Different styles for sent/received messages

10. ✅ **Row and Column grid layout**
    - LayoutDemoScreen grid demo
    - 3x3 grid using nested Row and Column widgets

## Services Offered

The app simulates a mobile service marketplace offering:

- **House Cleaning** - Professional cleaning services
- **Plumbing Repair** - Expert plumbing maintenance
- **Tutoring Services** - Personal educational support
- **Garden Maintenance** - Outdoor care services

Each service includes:
- Title and description
- Pricing information
- Rating and review count
- Category classification
- Visual representation

## Technical Features

- **State Management**: Proper use of StatefulWidget for dynamic content
- **Navigation**: Multiple navigation patterns (Drawer, BottomNavigationBar, Routes)
- **Responsive Design**: Adapts to different screen orientations
- **Custom Widgets**: Reusable components for consistent UI
- **Platform Support**: Both Material Design and Cupertino widgets
- **Third-Party Integration**: External package usage demonstration
- **Clean Architecture**: Organized code structure for maintainability

## Getting Started

1. Ensure Flutter SDK is installed
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application
4. Navigate through different screens using the drawer or bottom navigation
5. Explore the various layout demonstrations in the Layout Demo screen

## Dependencies

- `flutter_staggered_grid_view: ^0.7.0` - For staggered grid layouts
- `cupertino_icons: ^1.0.8` - iOS-style icons

This application serves as a comprehensive demonstration of Flutter development concepts, combining both basic and advanced techniques in a real-world mobile application context.