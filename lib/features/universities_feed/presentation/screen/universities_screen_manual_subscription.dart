import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart_state_management_article/features/universities_feed/presentation/models/university_screen_model.dart';
import 'package:rxdart_state_management_article/features/universities_feed/presentation/models/university_screen_state.dart';
import 'package:rxdart_state_management_article/features/universities_feed/presentation/screen/universities_view_model.dart';
import 'package:rxdart_state_management_article/network_config/app_result.dart';

class UniversitiesScreenManualSubscription extends StatefulWidget {
  const UniversitiesScreenManualSubscription({Key? key}) : super(key: key);

  @override
  State<UniversitiesScreenManualSubscription> createState() =>
      _UniversitiesScreenManualSubscriptionState();
}

class _UniversitiesScreenManualSubscriptionState
    extends State<UniversitiesScreenManualSubscription> {
  final UniversitiesViewModel _viewModel = UniversitiesViewModel();
  final CompositeSubscription _subscriptions = CompositeSubscription();

  AppResult<UniversityScreenState> _screenState = const AppResult.loading();

  @override
  void initState() {
    super.initState();
    _subscriptions.add(_viewModel.universities.listen((event) {
      setState(() {
        _screenState = event;
      });
    }));
  }

  @override
  void dispose() {
    _subscriptions.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RxDart State"),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              onChanged: _viewModel.searchByCountry,
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: _screenState.when(
                data: (e) => _buildUniversities(e.universities),
                loading: () => _buildLoading(),
                appError: (e) => _buildError(e.toString()),
                apiError: (e) => _buildError(e.toString())),
          ),
        ],
      ),
    );
  }

  Widget _buildUniversities(List<UniversityScreenModel> universities) {
    return ListView.builder(
      itemCount: universities.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 5,
          margin: const EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Text("Name: ${universities[index].name}"),
                Text("Country: ${universities[index].country}"),
                Text("Website: ${universities[index].website}"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(String error) {
    return Center(
      child: Text(
        error,
        style:
            Theme.of(context).textTheme.headline3?.copyWith(color: Colors.red),
      ),
    );
  }
}
