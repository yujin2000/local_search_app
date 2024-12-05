import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app/data/model/location.dart';
import 'package:local_search_app/ui/detail/detail_page.dart';
import 'package:local_search_app/ui/home/home_view_model.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// 검색
  void onSubmitted(String query) {
    // 뷰모델 읽기(read)
    final vm = ref.read(homeViewModelProvider.notifier);
    vm.searchLocations(query);
  }

  @override
  Widget build(BuildContext context) {
    // 값이 변경되는지 확인(watch)
    final locations = ref.watch(homeViewModelProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            child: TextField(
              controller: controller,
              onSubmitted: (value) => onSubmitted(value),
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                hintText: '검색어를 입력해 주세요',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            locations == null
                ? SizedBox()
                : Expanded(
                    child: ListView.separated(
                      itemCount: locations.length,
                      itemBuilder: (context, index) {
                        return item(locations[index]);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 20);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  /// 검색된 주소 아이템
  Padding item(Location location) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return DetailPage(location.link);
              },
            ));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                // 테두리 둥글게
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  // 테두리 색상
                  color: Colors.grey[300]!,
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  location.category,
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  location.roadAddress,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
