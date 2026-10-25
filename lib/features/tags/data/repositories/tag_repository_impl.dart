import 'package:logging/logging.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/tag_style.dart';
import '../../domain/repositories/tag_repository.dart';
import '../dao/tags_dao.dart';

final class TagRepositoryImpl extends TagRepository {
  final Logger log = Logger('TagRepositoryImpl');
  final TagsDao tagsDao;

  TagRepositoryImpl(this.tagsDao);

  @override
  Future<int> addTag(String label, TagStyle style) async {
    final insertedId = await tagsDao.insertTag(
      TagsTableCompanion.insert(
        label: label,
        borderColor: style.borderColor.toARGB32(),
        backgroundColor: style.backgroundColor.toARGB32(),
        textColor: style.textColor.toARGB32(),
      ),
    );
    log.info('Created Tag "$label" ID[$insertedId]');
    return insertedId;
  }
}
