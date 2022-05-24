import 'package:flutter/material.dart';
import 'package:rxdart_state_management_article/features/universities_feed/presentation/models/university_screen_model.dart';
import 'package:rxdart_state_management_article/features/universities_feed/presentation/models/university_screen_state.dart';
import 'package:rxdart_state_management_article/features/universities_feed/presentation/screen/universities_view_model.dart';
import 'package:rxdart_state_management_article/network_config/app_result.dart';

class UniversitiesScreen extends StatefulWidget {
  const UniversitiesScreen({Key? key}) : super(key: key);

  @override
  State<UniversitiesScreen> createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  final UniversitiesViewModel _viewModel = UniversitiesViewModel();

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
            child: StreamBuilder(
              stream: _viewModel.universities,
              builder: (BuildContext context,
                  AsyncSnapshot<AppResult<UniversityScreenState>> snapshot) {
                return snapshot.data?.when(
                        data: (e) => _buildUniversities(e.universities),
                        loading: () => _buildLoading(),
                        appError: (e) => _buildError(e.toString()),
                        apiError: (e) => _buildError(e.toString())) ??
                    _buildLoading();
              },
            ),
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
