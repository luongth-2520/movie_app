import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/constants/constanst.dart';
import 'package:movie_app/extensions/string_extensions.dart';
import 'package:movie_app/screens/detail/detail_viewmodel.dart';

class CastsList extends ConsumerWidget {
  const CastsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(detailViewModelProvider).casts.when(
          data: (value) => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: value.length,
            itemBuilder: (_, index) => ClipOval(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: value[index].profilePath?.toImageUrl() ??
                      "https://toiyeubitcoin.sgp1.digitaloceanspaces.com/wp-content/uploads/2021/05/10191256/gia-cho-shiba-inu-02-768x768_0.jpeg",
                ),
              ),
            ),
          ),
          error: (error, stack) => const Center(child: Text(AppString.errorMessage)),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
