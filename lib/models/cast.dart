import 'package:freezed_annotation/freezed_annotation.dart';

part 'cast.freezed.dart';
part 'cast.g.dart';

@freezed
class Cast with _$Cast {
  factory Cast({
    bool? adult,
    int? gender,
    @JsonKey(name: "profile_path") String? profilePath,
    String? name,
  }) = _Cast;

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
}
