import 'dart:ui';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/tag.dart';
import '../../domain/entities/tag_style.dart';

extension TagExtension on Tag {
  TagRow toRow() {
    return TagRow(
      id: id,
      label: label,
      borderColor: style.borderColor.toARGB32(),
      backgroundColor: style.backgroundColor.toARGB32(),
      textColor: style.textColor.toARGB32(),
    );
  }
}

extension TagRowExtension on TagRow {
  Tag toEntity() {
    return Tag(
      id: id,
      label: label,
      style: TagStyle(
        borderColor: Color(borderColor),
        backgroundColor: Color(backgroundColor),
        textColor: Color(textColor),
      ),
    );
  }
}
