import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../tables/tags_table.dart';

part 'tags_dao.g.dart';

@DriftAccessor(tables: [TagsTable])
class TagsDao extends DatabaseAccessor<AppDatabase> with _$TagsDaoMixin {
  new(super.attachedDatabase);

  Future<int> insertTag(TagsTableCompanion entry) async {
    return into(tagsTable).insert(entry);
  }
}
