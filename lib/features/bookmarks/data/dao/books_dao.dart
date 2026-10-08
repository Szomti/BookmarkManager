import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../tags/data/mappers/tag_mapper.dart';
import '../../../tags/data/tables/tags_table.dart';
import '../../../tags/domain/entities/tags.dart';
import '../../domain/entities/book.dart';
import '../../domain/entities/books.dart';
import '../mappers/book_mapper.dart';
import '../tables/book_tags_table.dart';
import '../tables/books_table.dart';

part 'books_dao.g.dart';

@DriftAccessor(tables: [BooksTable, TagsTable, BookTagsTable])
class BooksDao extends DatabaseAccessor<AppDatabase> with _$BooksDaoMixin {
  BooksDao(super.attachedDatabase);

  Stream<Books> watchBooks() {
    final query = select(booksTable).join([
      leftOuterJoin(
        bookTagsTable,
        bookTagsTable.bookId.equalsExp(booksTable.id),
      ),
      leftOuterJoin(tagsTable, tagsTable.id.equalsExp(bookTagsTable.tagId)),
    ]);

    return query.watch().map((rows) {
      final bookRows = <int, BookRow>{};
      final bookTags = <int, List<TagRow>>{};

      for (final row in rows) {
        final bookRow = row.readTable(booksTable);
        final tagRow = row.readTableOrNull(tagsTable);
        bookRows.putIfAbsent(bookRow.id, () => bookRow);
        final tagList = bookTags.putIfAbsent(bookRow.id, () => []);
        if (tagRow != null) tagList.add(tagRow);
      }

      const books = <Book>[];
      bookTags.forEach((key, value) {
        final book = bookRows[key]?.toEntity(
          Tags(value.map((tagRow) => tagRow.toEntity())),
        );
        if (book != null) books.add(book);
      });

      return Books(books);
    });
  }
}
