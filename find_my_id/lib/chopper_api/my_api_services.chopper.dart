// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_api_services.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$MyApiService extends MyApiService {
  _$MyApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = MyApiService;

  @override
  Future<Response<dynamic>> postCard({
    http.MultipartFile? image,
    String? idString,
    int? owner,
    String? name,
    String? status,
    String? collegeName,
    String? regNumber,
    String? department,
    String? locationFound,
  }) {
    final String $url = '/cards/create';
    final Map<String, String> $headers = {
      'content-type': 'multipart/form-data',
    };
    final List<PartValue> $parts = <PartValue>[
      PartValue<http.MultipartFile?>(
        'image',
        image,
      ),
      PartValue<String?>(
        'id_string',
        idString,
      ),
      PartValue<int?>(
        'owner',
        owner,
      ),
      PartValue<String?>(
        'name',
        name,
      ),
      PartValue<String?>(
        'status',
        status,
      ),
      PartValue<String?>(
        'college_name',
        collegeName,
      ),
      PartValue<String?>(
        'reg_number',
        regNumber,
      ),
      PartValue<String?>(
        'department',
        department,
      ),
      PartValue<String?>(
        'location_found',
        locationFound,
      ),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCards({required String searchFilterString}) {
    final String $url = '/cards/list/${searchFilterString}';
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateCardStatus({
    required int id,
    required Map<String, String> status,
  }) {
    final String $url = '/cards/update/${id}/';
    final Map<String, String> $headers = {
      'content-type': 'application/json',
    };
    final $body = status;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
