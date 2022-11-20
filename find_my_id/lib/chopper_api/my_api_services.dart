import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:find_my_id/chopper_api/converters.dart';

import 'package:http/http.dart' as http;

part 'my_api_services.chopper.dart';

@ChopperApi(baseUrl: '')
abstract class MyApiService extends ChopperService {
  @Post(path: '/cards/create', headers: {'content-type': 'multipart/form-data'})
  @multipart
  Future<Response> postCard({
    @Part("image") http.MultipartFile? image,
    @Part("id_string") String? idString,
    @Part("owner") int? owner,
    @Part("name") String? name,
    @Part("status") String? status,
    @Part("college_name") String? collegeName,
    @Part("reg_number") String? regNumber,
    @Part("department") String? department,
    @Part("location_found") String? locationFound,
  });

  @Get(path: '/cards/list/{slug}')
  Future<Response> getCards({
    @Path('slug') required String searchFilterString,
  });

  @Put(path: '/cards/update/{id}/', headers: {'content-type': 'application/json'})
  Future<Response> updateCardStatus({
    @Path('id') required int id,
    @Body() required Map<String, String> status,
  });

  static MyApiService create() {
    final client = ChopperClient(
      baseUrl: "http://192.168.0.101:8000/api",
      services: [
        _$MyApiService(),
      ],
      converter: BuiltValueConverter(),
    );

    return _$MyApiService(client);
  }
}
