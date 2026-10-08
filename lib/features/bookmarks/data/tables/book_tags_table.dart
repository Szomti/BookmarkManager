import 'package:drift/drift.dart';

import '../../../tags/data/tables/tags_table.dart';
import 'books_table.dart';

@DataClassName('BookTagRow')
class BookTagsTable extends Table {
  IntColumn get bookId => integer().references(BooksTable, #id, onDelete: KeyAction.cascade)();

  IntColumn get tagId => integer().references(TagsTable, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>>? get primaryKey => {bookId, tagId};
}
