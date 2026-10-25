import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../tags/data/tables/tags_table.dart';
import '../tables/book_tags_table.dart';
import '../tables/books_table.dart';

part 'books_dao.g.dart';

typedef BookWithTags = ({BookRow book, List<TagRow> tags});

@DriftAccessor(tables: [BooksTable, TagsTable, BookTagsTable])
class BooksDao extends DatabaseAccessor<AppDatabase> with _$BooksDaoMixin {
  new(super.attachedDatabase);

  Stream<List<BookWithTags>> watchBooksWithTags() {
    final query = select(booksTable).join([
      leftOuterJoin(
        bookTagsTable,
        bookTagsTable.bookId.equalsExp(booksTable.id),
      ),
      leftOuterJoin(tagsTable, tagsTable.id.equalsExp(bookTagsTable.tagId)),
    ])..orderBy([OrderingTerm.desc(booksTable.id)]);

    return query.watch().map((rows) {
      final grouped = <int, BookWithTags>{};

      for (final row in rows) {
        final bookRow = row.readTable(booksTable);
        final tagRow = row.readTableOrNull(tagsTable);
        final entry = grouped.putIfAbsent(
          bookRow.id,
          () => (book: bookRow, tags: []),
        );
        if (tagRow != null) entry.tags.add(tagRow);
      }

      return grouped.values.toList();
    });
  }

  Future<int> insertBook(BooksTableCompanion entry) async {
    return into(booksTable).insert(entry);
  }
}
