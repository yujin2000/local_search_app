import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app/ui/home/home_view_model.dart';

class SearchResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '최근 검색 기록',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(homeViewModelProvider);

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: state.searchTerms?.length ?? 0,
            itemBuilder: (context, index) {
              final text = state.searchTerms![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context, text);
                },
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
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(height: 1);
            },
          );
        },
      ),
    );
  }
}
