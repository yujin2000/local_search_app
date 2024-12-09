import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app/ui/home/home_view_model.dart';

class SearchTermPage extends StatelessWidget {
  void Function(int index, WidgetRef ref) onTapXIcon;
  SearchTermPage(this.onTapXIcon);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(homeViewModelProvider);
        final searchTerm = state.searchTerms;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              '최근 검색 기록',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  final vm = ref.read(homeViewModelProvider.notifier);
                  vm.deleteAllSearchTerms();
                },
                child: const Text(
                  '모두 삭제',
                  style: TextStyle(color: Colors.redAccent),
                ),
              )
            ],
          ),
          body: searchTerm == null || searchTerm.isEmpty
              ? const Align(
                  child: Text(
                    '최근 검색 기록이 없습니다.',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: state.searchTerms?.length ?? 0,
                  itemBuilder: (context, index) {
                    final text = searchTerm[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context, text);
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.all(10),
                              child: Wrap(
                                children: [
                                  Text(
                                    text,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          CloseButton(
                            onPressed: () => onTapXIcon(index, ref),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(height: 1);
                  },
                ),
        );
      },
    );
  }
}
