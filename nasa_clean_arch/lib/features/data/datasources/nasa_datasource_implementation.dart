import 'dart:convert';

import 'package:nasa_clean_arch/core/usecase/errors/exceptions.dart';
import 'package:nasa_clean_arch/core/utils/converters/date_to_string_converter.dart';
import 'package:nasa_clean_arch/core/utils/keys/nasa_api_keys.dart';
import 'package:nasa_clean_arch/features/data/datasources/endpoints/nasa_endpoints.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:http/http.dart' as http;

class NasaDatasourceImplementation implements ISpaceMediaDatasource {
  final http.Client client;
  final DateToStringConverter converter;

  NasaDatasourceImplementation({
    required this.client,
    required this.converter,
  });

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final dateConverted = converter.convert(date);
    final response = await client.get(NasaEndpoints.getSpaceMedia(
      NasaApiKeys.apiKey,
      dateConverted,
    ));
    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
