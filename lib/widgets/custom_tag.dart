import 'package:bookmark_manager/storage/tags/tag.dart';
import 'package:flutter/material.dart';

import '../storage/settings/settings.dart';

class CustomTag extends StatelessWidget {
  static final SettingsStorage _settingsStorage = SettingsStorage.instance;
  final Tag tag;
  final bool forceCustom;

  const CustomTag(
    this.tag, {
    this.forceCustom = false,
    super.key,
  });

  bool get textTags => _settingsStorage.textTags;

  @override
  Widget build(BuildContext context) {
    if (textTags && !forceCustom) return _createText();
    return Container(
      decoration: BoxDecoration(
        color: tag.backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: tag.borderColor,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: _createText(),
      ),
    );
  }

  Widget _createText() {
    return Text(
      tag.label,
      style: TextStyle(
        fontSize: 12,
        color: tag.labelColor,
      ),
    );
  }
}
