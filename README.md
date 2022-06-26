# rxdart_state_management_article

RxDart State Management

Project describes a Flutter application which displays a list of universities which can be queried
by the country they are based into. It fetch the data by connecting to open API:
"https://universities.hipolabs.com" and uses a clean and testable architecture for processing the
information received from the API and displaying it on the screen.

Technologies used:

* MVVM + Clean Architecture pattern
* RxDart for state management
* Retrofit with Dio for Networking Layer
* Freezed and JsonSerializable for generating models' boilerplate

## Getting Started

Before running the app, you have to run: `flutter pub run build_runner build`
