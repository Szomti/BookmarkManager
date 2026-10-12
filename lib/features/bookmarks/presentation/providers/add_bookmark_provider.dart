import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/bookmark.dart';
import 'bookmark_repository_provider.dart';

part 'add_bookmark_provider.g.dart';

typedef BookData = ({String name, String website, Bookmark bookmark});

@riverpod
class AddBookmark extends _$AddBookmark {
  @override
  Future<void> build() async {}

  Future<void> addBookmark(BookData book) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(bookmarkRepositoryProvider)
          .addBook(book.name, book.website, book.bookmark);
    });
  }
}
