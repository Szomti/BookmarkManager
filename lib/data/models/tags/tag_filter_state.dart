import 'package:collection/collection.dart';

enum TagFilterState {
  none._(0),
  show._(1),
  exclude._(2);

  final int id;

  const TagFilterState._(this.id);

  static TagFilterState fromId(int? id) {
    return TagFilterState.values.firstWhereOrNull((state) => state.id == id) ??
        TagFilterState.none;
  }

  TagFilterState next() {
    return switch (id) {
      0 => show,
      1 => exclude,
      2 => none,
      int() => none,
    };
  }
}
