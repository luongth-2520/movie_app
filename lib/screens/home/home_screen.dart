import 'package:flutter/material.dart';
import 'package:movie_app/screens/home/widgets/now_playing_widget.dart';
import 'package:movie_app/screens/home/widgets/title_movie_widget.dart';

import '../../constants/constanst.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.size_16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Movies',
              style: TextStyle(fontSize: AppSize.size_40),
            ),
            Text(
              'Now Playing',
              style: TextStyle(fontSize: AppSize.size_25),
            ),
            NowPlaying(),
            TitleMovie(title: 'Upcomming')
          ],
        ),
      ),
    );
  }
}
