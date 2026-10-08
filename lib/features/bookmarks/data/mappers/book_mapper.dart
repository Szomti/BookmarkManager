import '../../../../core/database/app_database.dart';
import '../../../tags/domain/entities/tags.dart';
import '../../domain/entities/book.dart';
import '../../domain/entities/bookmark.dart';

extension BookExtension on Book {
  /// Conversion loses tags
  BookRow toRow() {
    return BookRow(
      id: id,
      name: name,
      website: website,
      chapter: bookmark.chapter,
      chapterSuffix: bookmark.chapterSuffix,
      page: bookmark.page,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension BookRowExtension on BookRow {
  Book toEntity(Tags tags) {
    return Book(
      id: id,
      name: name,
      website: website,
      tags: tags,
      bookmark: Bookmark(
        chapter: chapter,
        chapterSuffix: chapterSuffix,
        page: page,
      ),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
