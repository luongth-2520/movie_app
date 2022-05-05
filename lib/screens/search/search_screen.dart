import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/screens/search/search_viewmodel.dart';
import 'package:movie_app/screens/search/widgets/list_movie_search_widget.dart';

import '../../constants/constanst.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.size_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search',
              style: TextStyle(fontSize: AppSize.size_40),
            ),
            Consumer(
              builder: (context, ref, __) => TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    ref.read(searchViewModelProvider).searchMovies(value);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(AppString.invalidDataMessage)));
                  }
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(AppSize.size_12),
                    fillColor: AppColor.ebb,
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(AppSize.size_10)),
                    hintText: "Search movies, genres ..."),
              ),
            ),
            const Expanded(
              child: ListMovieSearch(),
            )
          ],
        ),
      ),
    );
  }
}
