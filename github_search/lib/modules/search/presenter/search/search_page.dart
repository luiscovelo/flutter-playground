import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/modules/search/presenter/search/search_bloc.dart';
import 'package:github_search/modules/search/presenter/search/states/state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final searchBloc = Modular.get<SearchBloc>();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    searchBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (term) {
                if (term.isNotEmpty && term.length >= 3) {
                  searchBloc.add(term);
                }
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Search...",
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              child: StreamBuilder<SearchState>(
                stream: searchBloc.stream,
                builder: (context, snapshot) {
                  final state = searchBloc.state;

                  if (state is SearchStart) {
                    return const Center(
                      child: Text('Pesquise por um usuário...'),
                    );
                  }

                  if (state is SearchError) {
                    return const Center(
                      child: Text('Ocorreu um problema.'),
                    );
                  }
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final list = (state as SearchSuccess).list;
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, id) {
                      final item = list[id];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(item.img),
                        ),
                        title: Text(item.title),
                        subtitle: Text(item.content),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
