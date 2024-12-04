import 'package:flutter_test/flutter_test.dart';
import 'package:local_search_app/data/repository/location_repository.dart';

void main() {
  test('LocationRepository: findByAddress', () async {
    final repo = LocationRepository();
    final result = await repo.findByAddress('삼성동');
    expect(result != null, true);
  });
}
