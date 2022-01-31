import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_clean_arch/core/utils/converters/date_to_string_converter.dart';
import 'package:nasa_clean_arch/features/data/datasources/nasa_datasource_implementation.dart';
import 'package:nasa_clean_arch/features/data/repositories/space_media_repository_implementation.dart';
import 'package:nasa_clean_arch/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:nasa_clean_arch/features/presenter/controllers/home_store.dart';
import 'package:nasa_clean_arch/features/presenter/pages/home_page.dart';
import 'package:nasa_clean_arch/features/presenter/pages/picture_page.dart';
import 'package:http/http.dart' as http;

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.factory((i) => HomeStore(i())),
        Bind.lazySingleton((i) => GetSpaceMediaUsecaseFromDateUsecase(i())),
        Bind.lazySingleton((i) => SpaceMediaRepositoryImplementation(i())),
        Bind.lazySingleton(
            (i) => NasaDatasourceImplementation(converter: i(), client: i())),
        Bind.lazySingleton((i) => http.Client()),
        Bind.lazySingleton((i) => DateToStringConverter()),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => HomePage()),
        ChildRoute('/picture',
            child: (_, args) => PicturePage.fromArgs(args.data)),
      ];
}
