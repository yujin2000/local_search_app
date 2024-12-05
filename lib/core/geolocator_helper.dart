import 'package:geolocator/geolocator.dart';

class GeolocatorHelper {
  /// 위치정보 가져오는 메서드
  /// 권한 설정 확인 -> 위치 정보 반환
  static Future<Position?> getPosition() async {
    // 현재 권한 확인
    final permission = await Geolocator.checkPermission();
    // 1. 현재 권한이 허용되지 않았을 때
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // 권한 요청하기(알림창 생성)
      final permission2 = await Geolocator.requestPermission();

      // 2. 권한 요청 후 결과가 거부일 때
      if (permission2 == LocationPermission.denied ||
          permission2 == LocationPermission.deniedForever) {
        // 권한 거부
        return null;
      }
    }

    // 권한 허용되면 위치 정보 가져오기
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        // 위치 정확도
        accuracy: LocationAccuracy.high,
        // __ 미터 차이날 경우 위치 갱신
        distanceFilter: 100,
      ),
    );

    return position;
  }
}
