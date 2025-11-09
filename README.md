# Heunets Assessment App

A comprehensive job search and application management Flutter app built with clean architecture principles.

## 📱 Features

- **Job Search**: Browse and search through available job listings
- **Job Details**: View comprehensive job information including requirements and benefits
- **Job Applications**: Apply for jobs with resume upload and cover letter
- **Application Tracking**: Monitor application status (Pending, Under Review, Accepted, Rejected)
- **Job Posting**: Post new job opportunities (for employers)
- **Profile Management**: Manage user profile information
- **Responsive Design**: Optimized for different screen sizes using ScreenUtil

## 🏗️ Architecture

This project follows **Clean Architecture** principles with a clear separation of concerns:

```
lib/
├── core/                     # Shared components and utilities
│   ├── config/              # App configuration
│   ├── resources/           # Colors, strings, assets
│   ├── utils/               # Utility functions and helpers
│   └── widgets/             # Reusable UI components
│
├── features/                # Feature-based modules
│   ├── dashboard/           # Dashboard navigation
│   ├── home/                # Job listings and search
│   ├── job/                 # Job-related functionality
│   │   ├── data/
│   │   │   └── model/       # Data models
│   │   └── presentation/
│   │       └── widgets/     # Job-specific widgets
│   └── profile/             # User profile management
```

### Architecture Layers

#### 1. **Presentation Layer**
- **Pages**: UI screens and navigation
- **Widgets**: Reusable UI components
- **Controllers**: State management using Provider/ChangeNotifier

#### 2. **Domain Layer**
- **Models**: Data entities and business objects
- **Use Cases**: Business logic and rules

#### 3. **Data Layer**
- **Models**: Data transfer objects
- **Repositories**: Data access abstraction

## 🛠️ Technical Stack

- **Framework**: Flutter 3.x
- **State Management**: Provider
- **Architecture**: Clean Architecture
- **Navigation**: Flutter Navigator 2.0
- **UI Responsiveness**: ScreenUtil
- **File Operations**: file_picker
- **Testing**: flutter_test, widget testing

## 📦 Key Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1
  flutter_screenutil: ^5.9.0
  file_picker: ^6.1.1
  flutter_svg: ^2.0.9
  flutter_hicons: ^1.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

## 🚀 Getting Started

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd heunets_assessment_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Running Tests

```bash

# Run specific test file
flutter test test/post_job_page_test


```

## 🎨 Design Decisions

### State Management
- **Provider**: Chosen for its simplicity and tight integration with Flutter
- **ChangeNotifier**: Used for reactive state management
- **Separation of Concerns**: Each feature has its own controller

### UI/UX Decisions
- **Material Design**: Following Material 3 design guidelines
- **Responsive Layout**: ScreenUtil for consistent sizing across devices
- **Custom Components**: Reusable widgets for consistency
- **Color System**: Centralized color management in `AppColors`

### File Organization
- **Feature-First**: Organized by features rather than technical layers
- **Shared Components**: Core widgets and utilities shared across features
- **Clean Separation**: Clear boundaries between presentation, domain, and data

### Data Flow
```
UI Widget → Controller → Model → Update UI
```

1. User interactions trigger controller methods
2. Controllers update models and business logic
3. ChangeNotifier notifies UI of state changes
4. UI rebuilds with new data

## 🔧 Core Components

### Custom Widgets
- **CustomTextField**: Reusable input field with validation
- **CustomDropdown**: Overlay dropdown with search functionality
- **CustomButton**: Styled buttons with loading states
- **JobCardWidget**: Job listing display component

### Controllers
- **HomeController**: Manages job listings, search, and applications
- **ProfileController**: Handles user profile data
- **ApplicationsController**: Manages job application states

### Models
- **Job**: Job listing with requirements and benefits
- **JobApplication**: Application tracking with status
- **UserProfile**: User information and preferences

## 📱 Screens Overview

### Home Screen
- Job search functionality
- Job listings with filtering
- Navigation to job details

### Job Details Screen
- Comprehensive job information
- Application submission dialog
- Requirements and benefits display

### Applications Screen
- Application status tracking
- Filter by status (All, Pending, Completed)
- Application history

### Profile Screen
- User information management
- Account settings
- Profile customization

### Post Job Screen
- Job creation form
- Requirement specification
- Job validation and submission

## 🧪 Testing Strategy

### Widget Tests
- UI component testing
- Form validation testing
- User interaction simulation
- State management verification

### Unit Tests
- Controller logic testing
- Model validation
- Business rule verification
- Edge case handling

## 🚧 Future Enhancements

- [ ] Network layer implementation
- [ ] Local database integration (SQLite/Hive)
- [ ] Push notifications
- [ ] Social authentication
- [ ] Advanced filtering and sorting
- [ ] Real-time chat with employers
- [ ] Resume builder
- [ ] Job recommendations AI

## 📄 Project Structure Details

### Core Directory
```
core/
├── config/              # App configuration and constants
├── resources/
│   ├── styles/          # Colors, text styles, themes
│   └── assets/          # Images, icons, fonts
├── utils/               # Helper functions and utilities
└── widgets/             # Reusable UI components
```

### Feature Modules
Each feature follows the same structure:
```
feature/
├── data/
│   └── model/           # Data models and DTOs
├── domain/              # Business logic (future)
└── presentation/
    ├── controller/      # State management
    ├── pages/          # Screen widgets
    └── widgets/        # Feature-specific widgets
```

## 🔒 Code Quality

### Code Style
- Follows Dart/Flutter style guidelines
- Consistent naming conventions
- Comprehensive documentation
- Error handling best practices

### Performance
- Efficient state management
- Optimized list rendering
- Memory leak prevention
- Image optimization

### Maintainability
- Modular architecture
- Separation of concerns
- Reusable components
- Clear code organization

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Implement changes with tests
4. Follow code style guidelines
5. Submit a pull request

## 📋 Development Guidelines

### Adding New Features
1. Create feature directory structure
2. Implement models and controllers
3. Build UI components
4. Add comprehensive tests
5. Update documentation

### Code Review Checklist
- [ ] Follows clean architecture principles
- [ ] Includes unit/widget tests
- [ ] Proper error handling
- [ ] Performance considerations
- [ ] Documentation updated