import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/modules/search/domain/usecases/search_by_text_implementation.dart';
import 'package:github_search/modules/search/external/datasources/github_datasource.dart';
import 'package:github_search/modules/search/infra/repositories/search_repository_implementation.dart';
import 'package:github_search/modules/search/presenter/search/search_bloc.dart';
import 'package:github_search/modules/search/presenter/search/search_page.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => Dio()),
        Bind((i) => GithubDatasource(i())),
        Bind((i) => SearchRepositoryImplementation(i())),
        Bind((i) => SearchByTextImplementation(i())),
        Bind((i) => SearchBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, __) => const SearchPage()),
      ];
}
