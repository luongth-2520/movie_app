import 'package:freezed_annotation/freezed_annotation.dart';

import 'cast.dart';
part 'casts.freezed.dart';
part 'casts.g.dart';

@freezed
class Casts with _$Casts {
  factory Casts({
    int? id,
    List<Cast>? cast,
  }) = _Casts;

  factory Casts.fromJson(Map<String, dynamic> json) => _$CastsFromJson(json);
}
