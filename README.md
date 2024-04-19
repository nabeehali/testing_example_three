# unit_testing_example_three

Welcome to the Flutter Software Testing Project repository! This project aims to demonstrate various software testing techniques and best practices in Flutter app development.

 
## Overview

This example demonstrates how to implement unit tests for all layers in clean architecture (data, domain, and presentation layers). We apply Mockito to the remote data source to understand how testing methods depend on data from the backend in Flutter.

This project includes examples and implementations of different types of software testing in Flutter:

- Unit Testing
  
## Project Structure
The project is structured as follows:

- `lib/`: Contains the main Flutter application code.
- `test/features/data/datasources/remote_datasource_test.dart/`: We Apply unit test for get posts using mokito.
- `test/features/data/model/post_model_test.dart/`: We apply unit tests to ensure that the template or model of incoming data is compatible with the model that I have.
- `test/features/domain/repository/posts_repository_test.dart/`: We Apply unit  tests for get posts method in domain layer.
- `test/features/presentation/cubit/posts_cubit_test.dart/`: We Apply unit  tests for get posts method in presentation layer(cubit).

  
## Testing Tools and Libraries
To apply build runner when use mock notation for any class in this project, Ensure that you are in the project directory before running this command in the terminal:

```bash
flutter pub run build --delete-conflicting--outputs ```

This project utilizes the following testing tools and libraries:

- `flutter_test`: Official Flutter testing library for unit and widget tests.
- `flutter_driver`: Flutter package for writing E2E tests using Flutter Driver.
- `test`: Dart testing library for writing tests and assertions.
- `build_runner`: to generate mock classes.
- `mockito`: this package helps to apply to test for remote data in the Flutter application.

## UI Example
![Example Testing Three example testing_example_3](https://github.com/nabeehali/testing_example_three/assets/90058504/17cee17a-08e1-4481-a353-c71062467301)

Happy testing! 🧪✨
