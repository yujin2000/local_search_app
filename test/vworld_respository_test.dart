import 'package:flutter_test/flutter_test.dart';
import 'package:local_search_app/data/repository/vworld_repository.dart';

void main() {
  test('VworldRepository : findByLatLng', () async {
    final vworldRepo = VworldRepository();
    final success = await vworldRepo.findByLatLng(37.4816664, 126.6457594);
    expect(success.isEmpty, false);

    final fail = await vworldRepo.findByLatLng(32.4816664, 126.6457594);
    expect(fail.isEmpty, true);
  });
}
