import 'package:meta/meta.dart';

import 'book.dart';

@immutable
final class Books extends Iterable<Book> {
  final Set<Book> elements;

  Books(Iterable<Book> elements) : elements = Set.unmodifiable(elements);

  @override
  Iterator<Book> get iterator => elements.iterator;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Books &&
          runtimeType == other.runtimeType &&
          elements.length == other.elements.length &&
          elements.containsAll(other.elements);

  @override
  int get hashCode => Object.hashAllUnordered(elements);
}
