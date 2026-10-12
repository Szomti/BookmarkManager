import '../entities/bookmark.dart';
import '../entities/books.dart';

abstract class BookmarkRepository {
  Stream<Books> watchBooks();

  Future<int> addBook(String name, String website, Bookmark bookmark);
}
