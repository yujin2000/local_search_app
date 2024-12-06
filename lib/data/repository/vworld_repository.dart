import 'package:dio/dio.dart';

class VworldRepository {
  static const key = '3CFD57D9-5B73-3E2F-A43E-39292F5E842D';

  Dio client = Dio(BaseOptions(
    validateStatus: (status) => true,
  ));

  /// 위도 경도 정보로 위치 찾기
  Future<List<String>> findByLatLng(double lat, double lng) async {
    try {
      final response = await client.get(
        'https://api.vworld.kr/req/data',
        queryParameters: {
          'request': 'GetFeature',
          'key': key,
          'data': 'LT_C_ADEMD_INFO',
          'geomFilter': 'POINT($lng $lat)',
          'geometry': false,
          'size': 100,
        },
      );

      // response > result > featureCollection > features >> properties > full_nm
      if (response.statusCode == 200 &&
          response.data['response']['status'] == 'OK') {
        final features = response.data['response']['result']
            ['featureCollection']['features'];

        return List.from(features).map((feat) {
          return '${feat['properties']['full_nm']}';
        }).toList();
      }
    } catch (e) {
      print(e);
      return [];
    }

    return [];
  }
}
