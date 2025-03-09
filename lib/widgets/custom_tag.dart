import 'package:flutter/material.dart';

import '../models/tags/tag.dart';
import '../storage/settings/settings.dart';

class CustomTag extends StatelessWidget {
  static const _padding = EdgeInsets.all(4.0);
  static const _labelSize = 12.0;
  static final SettingsStorage _settingsStorage = SettingsStorage.instance;
  static final _borderRadius = BorderRadius.circular(8.0);
  final Tag tag;
  final bool forceCustom;

  const CustomTag(this.tag, {this.forceCustom = false, super.key});

  bool get _textTags => _settingsStorage.textTags;

  @override
  Widget build(BuildContext context) {
    if (_textTags && !forceCustom) return _createText();
    return Container(
      decoration: BoxDecoration(
        color: tag.backgroundColor,
        borderRadius: _borderRadius,
        border: Border.all(color: tag.borderColor, width: 1.5),
      ),
      child: Padding(padding: _padding, child: _createText()),
    );
  }

  Widget _createText() {
    return Text(
      tag.label,
      style: TextStyle(fontSize: _labelSize, color: tag.labelColor),
    );
  }
}
