import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database_provider.dart';
import '../../data/dao/books_dao.dart';

part 'books_dao_provider.g.dart';

@Riverpod(keepAlive: true)
BooksDao booksDao(Ref ref) => ref.read(appDatabaseProvider).booksDao;
