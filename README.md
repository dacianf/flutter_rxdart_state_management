# RxDart State Management Using MVVM With Clean Architecture and Unit Testing

This project is a Flutter application that fetches and displays a list of universities with the help of an external API. The project also lets us filter the list by country. To make all this magic happen, we used clean and testable architecture to provide an easy-to-maintain and scalable code.

### Technologies Used:

* MVVM and Clean Architecture pattern
* RxDart for state management
* Retrofit with Dio for the Network layer
* Freezed and JsonSerializable for generating the models' boilerplates
* Mockito for data mocking

### API Used:
* [universities.hipolabs.com](http://universities.hipolabs.com/search)

### Related Reading by Dacian Florea:
<b>You can find me on [LinkedIn](https://www.linkedin.com/in/dacian-florea/) and [Toptal](https://www.toptal.com/resume/dacian-florea).</b>

* Clean architecture facilitates unit testing, which we demonstrate in the corresponding blog article at the Toptal Engineering Blog https://www.toptal.com/flutter/unit-testing-flutter.
* RxDart combined MVVM with clean architecture facilitates state management in Flutter, as demonstrated in https://hackernoon.com/flutter-state-management-with-rxdart-streams.

## Getting Started

Before running the app, you have to run: `flutter pub run build_runner build`
