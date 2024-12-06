import 'package:dio/dio.dart';
import 'package:local_search_app/data/model/location.dart';

class LocationRepository {
  static const clientId = 'kZGERaAVvVW1XM2SjeEG';
  static const clientSecret = '47Bc3qL5eV';

  Dio client = Dio(BaseOptions(
    // 설정 안하면 실패 응답올 때 throw 던져서 에러남
    validateStatus: (status) => true,
    // 헤더 추가
    headers: {
      'X-Naver-Client-Id': clientId,
      'X-Naver-Client-Secret': clientSecret
    },
  ));

  /// 지역정보 검색한 데이터 요청
  Future<List<Location>?> findByAddress(String query) async {
    try {
      // api 에 파라미터 입력해서 응답 값 받기
      final response = await client.get(
        'https://openapi.naver.com/v1/search/local.json',
        queryParameters: {
          'query': query,
          'display': 5,
        },
      );

      // 요청 성공
      if (response.statusCode == 200) {
        // 리스트로 변환
        final items = List.from(response.data['items']);
        return items.map((item) {
          return Location.fromJson(item);
        }).toList();
      }
    } catch (e) {
      print(e);
      return null;
    }

    // 실패하면 null
    return null;
  }
}
