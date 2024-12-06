import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app/data/model/location.dart';
import 'package:local_search_app/data/repository/location_repository.dart';
import 'package:local_search_app/data/repository/vworld_repository.dart';

// 1. 상태 클래스 만들기 -> List<Location>

// 2. 뷰모델 만들기
class HomeViewModel extends AutoDisposeNotifier<List<Location>?> {
  @override
  List<Location>? build() {
    return null;
  }

  Future<void> searchLocations(String query) async {
    final locationRepository = LocationRepository();
    final locationDatas = await locationRepository.findByAddress(query);

    state = locationDatas;
  }

  Future<void> searchByLatLng(double lat, double lng) async {
    final vworldRepo = VworldRepository();
    final locationName = await vworldRepo.findByLatLng(lat, lng);

    // 가장 위치가 근접한 동네만 고르기
    if (locationName.isNotEmpty) {
      await searchLocations(locationName[0]);
    }
  }
}

// 3. 뷰모델 관리자 만들기
final homeViewModelProvider =
    NotifierProvider.autoDispose<HomeViewModel, List<Location>?>(
  () {
    return HomeViewModel();
  },
);
