import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmark.freezed.dart';

@freezed
@immutable
final class Bookmark with _$Bookmark {
  final int chapter;
  final String chapterSuffix;
  final int? page;

  const Bookmark({
    required this.chapter,
    required this.chapterSuffix,
    required this.page,
  });
}
