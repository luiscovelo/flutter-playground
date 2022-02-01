import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/modules/search/presenter/search/search_bloc.dart';
import 'package:github_search/modules/search/presenter/search/widgets/custom_app_bar_widget.dart';
import 'package:github_search/modules/search/presenter/search/widgets/custom_listview_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = Modular.get<SearchBloc>();
  final TextEditingController inputController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
    inputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final heightStatusBar = MediaQuery.of(context).viewPadding.top;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBarWidget(
        bloc: bloc,
        inputController: inputController,
        size: size,
        heightStatusBar: heightStatusBar,
      ),
      body: CustomListviewWidget(bloc: bloc),
    );
  }
}
