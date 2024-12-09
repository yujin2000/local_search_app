import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app/data/model/location.dart';
import 'package:local_search_app/data/repository/location_repository.dart';
import 'package:local_search_app/data/repository/vworld_repository.dart';

// 1. 상태 클래스 만들기 -> List<Location>
class HomeState {
  List<Location>? locations;
  List<String>? searchTerms;

  HomeState({
    required this.locations,
    required this.searchTerms,
  });

  HomeState copyWith({
    List<Location>? locations,
    List<String>? searchTerms,
  }) {
    return HomeState(
      locations: locations ?? this.locations,
      searchTerms: searchTerms ?? this.searchTerms,
    );
  }
}

// 2. 뷰모델 만들기
class HomeViewModel extends AutoDisposeNotifier<HomeState> {
  @override
  HomeState build() {
    return HomeState(locations: null, searchTerms: null);
  }

  Future<void> searchLocations(String query) async {
    final locationRepository = LocationRepository();
    final locationDatas = await locationRepository.findByAddress(query);

    final newValue = addSearchTerm(query);
    state = HomeState(locations: locationDatas, searchTerms: newValue);
  }

  Future<String?> searchByLatLng(double lat, double lng) async {
    final vworldRepo = VworldRepository();
    final locationName = await vworldRepo.findByLatLng(lat, lng);

    // 가장 위치가 근접한 동네만 고르기
    if (locationName.isNotEmpty) {
      return locationName[0];
    }
    return null;
  }

  // 검색 기록 추가
  List<String> addSearchTerm(String term) {
    final oldValue = state.searchTerms;
    late final List<String> newValue;

    if (oldValue == null) {
      // 기존 검색 기록이 없으면 새로운 배열
      newValue = [term];
    } else {
      // 기존 검색 기록 맨 앞에 추가
      oldValue.remove(term);
      newValue = [term, ...oldValue];
    }

    return newValue;
  }

  /// 검색 기록 삭제
  void deleteSearchTerm(int index) {
    state.searchTerms!.removeAt(index);

    state = state.copyWith(searchTerms: state.searchTerms);
  }

  /// 모든 검색 기록 삭제
  void deleteAllSearchTerms() {
    state = state.copyWith(searchTerms: []);
  }
}

// 3. 뷰모델 관리자 만들기
final homeViewModelProvider =
    NotifierProvider.autoDispose<HomeViewModel, HomeState>(
  () {
    return HomeViewModel();
  },
);
