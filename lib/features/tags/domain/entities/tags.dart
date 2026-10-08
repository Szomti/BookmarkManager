import 'package:meta/meta.dart';

import 'tag.dart';

@immutable
final class Tags extends Iterable<Tag> {
  final Set<Tag> _elements;


  Tags(Iterable<Tag> elements) : _elements = Set.unmodifiable(elements);

  @override
  Iterator<Tag> get iterator => _elements.iterator;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tags &&
          runtimeType == other.runtimeType &&
          _elements.length == other._elements.length &&
          _elements.containsAll(other);

  @override
  int get hashCode => Object.hashAllUnordered(_elements);
}