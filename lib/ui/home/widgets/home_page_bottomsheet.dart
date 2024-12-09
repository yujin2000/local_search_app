import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app/ui/home/home_view_model.dart';
import 'package:local_search_app/ui/search_result/search_result_page.dart';

class HomePageBottomsheet extends StatelessWidget {
  TextEditingController controller;
  HomePageBottomsheet(this.controller);

  // 검색 기록 클릭 시 텍스트 에디터에 글자 입력 후 검색
  void onTapTerm(String text, WidgetRef ref) {
    controller.text = text;
    final vm = ref.read(homeViewModelProvider.notifier);
    vm.searchLocations(text);
  }

  /// 검색 기록 옆 x 클릭 시 검색 기록 삭제
  void onTapXIcon(int index, WidgetRef ref) {
    final vm = ref.read(homeViewModelProvider.notifier);
    vm.deleteSearchTerm(index);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(homeViewModelProvider);

        return Container(
          padding: const EdgeInsets.all(10),
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.purple[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '최근 검색 기록',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RichText(
                  maxLines: 1,
                  text: TextSpan(
                    children: createTextSpans(state.searchTerms!, ref),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    child: const Text('더 보기'),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SearchResultPage(onTapXIcon);
                          },
                        ),
                      );
                      // result == null -> 페이지 뒤로가기
                      // result != null -> 검색 기록 받아옴
                      if (result != null) {
                        onTapTerm(result, ref);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 검색 기록 텍스트 추가
  List<TextSpan> createTextSpans(List<String> arrayStrings, WidgetRef ref) {
    List<TextSpan> arrayOfTextSpan = [];
    print('arrayStrings ==> $arrayStrings');
    for (int index = 0; index < arrayStrings.length; index++) {
      String text = arrayStrings[index];

      final span = TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black87,
          fontWeight: FontWeight.normal,
        ),
        // 검색 기록 누르면 해당 검색 기록 재검색
        recognizer: TapGestureRecognizer()..onTap = () => onTapTerm(text, ref),
        children: <InlineSpan>[
          WidgetSpan(
            child: GestureDetector(
              // x 누르면 검색 기록 삭제
              onTap: () => onTapXIcon(index, ref),
              child: Container(
                padding: const EdgeInsets.only(bottom: 2),
                child: Icon(
                  key: Key(text),
                  Icons.close,
                  size: 18,
                ),
              ),
            ),
          ),
          WidgetSpan(child: SizedBox(width: 5)),
        ],
      );

      arrayOfTextSpan.add(span);

      // 검색 기록 3개 이상일 때 중단
      if (index > 2) {
        break;
      }
    }
    return arrayOfTextSpan;
  }
}
