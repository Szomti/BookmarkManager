import 'package:drift/drift.dart';
import 'package:logging/logging.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/bookmark.dart';
import '../../domain/entities/books.dart';
import '../../domain/repositories/bookmark_repository.dart';
import '../dao/books_dao.dart';
import '../mappers/book_mapper.dart';

final class BookmarkRepositoryImpl extends BookmarkRepository {
  final Logger log = Logger('BookmarkRepositoryImpl');
  final BooksDao dao;

  BookmarkRepositoryImpl(this.dao);

  @override
  // TODO: Add tags
  Future<int> addBook(String name, String website, Bookmark bookmark) async {
    final now = DateTime.timestamp();
    final insertedId = await dao.insertBook(
      BooksTableCompanion.insert(
        name: name,
        website: website,
        chapter: bookmark.chapter,
        chapterSuffix: bookmark.chapterSuffix,
        page: Value(bookmark.page),
        createdAt: now,
        updatedAt: now,
      ),
    );
    log.info('Created Book "$name" ID[$insertedId]');
    return insertedId;
  }

  @override
  Stream<Books> watchBooks() {
    return dao.watchBooksWithTags().map(
      (entries) => Books(entries.map((BookWithTags entry) => entry.toEntity())),
    );
  }
}
