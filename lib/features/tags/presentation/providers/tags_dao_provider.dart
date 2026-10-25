import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database_provider.dart';
import '../../data/dao/tags_dao.dart';

part 'tags_dao_provider.g.dart';

@Riverpod(keepAlive: true)
TagsDao tagsDao(Ref ref) => ref.read(appDatabaseProvider).tagsDao;
