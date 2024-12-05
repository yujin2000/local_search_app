import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app/data/model/location.dart';
import 'package:local_search_app/data/repository/location_repository.dart';

// 1. 상태 클래스 만들기 -> List<Location>

// 2. 뷰모델 만들기
class HomeViewModel extends AutoDisposeNotifier<List<Location>?> {
  @override
  List<Location>? build() {
    return null;
  }

  Future<void> searchLocations(String query) async {
    final locationRepository = LocationRepository();
    final books = await locationRepository.findByAddress(query);

    state = books;
  }
}

// 3. 뷰모델 관리자 만들기
final homeViewModelProvider =
    NotifierProvider.autoDispose<HomeViewModel, List<Location>?>(
  () {
    return HomeViewModel();
  },
);
