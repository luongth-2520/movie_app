import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/screens/search/search_viewmodel.dart';

import '../../../constants/constanst.dart';
import 'movie_card_item_widget.dart';

class ListMovieSearch extends ConsumerWidget {
  const ListMovieSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchViewModel = ref.watch(searchViewModelProvider);
    return searchViewModel.searchData.when(
      data: (value) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: value.length,
          itemBuilder: (context, index) => MovieCardItem(movie: value[index]),
        );
      },
      error: (error, stack) =>
          const Center(child: Text(AppString.errorMessage)),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
