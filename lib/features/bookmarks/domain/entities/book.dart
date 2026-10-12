import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../tags/domain/entities/tags.dart';
import 'bookmark.dart';

part 'book.freezed.dart';

@freezed
@immutable
final class Book with _$Book {
  final int id;
  final String name;
  final String website;
  final Tags tags;
  final Bookmark bookmark;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Book({
    required this.id,
    required this.name,
    required this.website,
    required this.tags,
    required this.bookmark,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Book && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
