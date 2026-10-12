import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/bookmark_repository_impl.dart';
import '../../domain/repositories/bookmark_repository.dart';
import 'books_dao_provider.dart';

part 'bookmark_repository_provider.g.dart';

@Riverpod(keepAlive: true)
BookmarkRepository bookmarkRepository(Ref ref) =>
    BookmarkRepositoryImpl(ref.read(booksDaoProvider));
