import 'package:material_ui/material_ui.dart';

import '../../domain/entities/tag.dart';
import '../../domain/entities/tag_style.dart';

class TagWidget extends StatelessWidget {
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;
  final String label;
  final bool isPreset;

  const TagWidget({
    required this.label,
    this.isPreset = false,
    required this.borderColor,
    required this.backgroundColor,
    required this.textColor,
    super.key,
  });

  factory TagWidget.fromTag(Tag tag) {
    return TagWidget(
      label: tag.label,
      borderColor: tag.style.borderColor,
      backgroundColor: tag.style.backgroundColor,
      textColor: tag.style.textColor,
    );
  }

  factory TagWidget.preset(TagStyle style) {
    return TagWidget(
      label: 'Aa',
      isPreset: true,
      borderColor: style.borderColor,
      backgroundColor: style.backgroundColor,
      textColor: style.textColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (label.isEmpty) return const Text('<No Label>');
    final textTheme = Theme.of(context).textTheme.bodySmall
        ?.copyWith(color: textColor);
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: .all(color: borderColor),
        borderRadius: .circular(8.0),
      ),
      child: Padding(
        padding: const .all(4.0),
        child: isPreset
            ? SizedBox.square(
                dimension: 18.0,
                child: FittedBox(
                  fit: .scaleDown,
                  child: Text(label, style: textTheme),
                ),
              )
            : Text(label, style: textTheme),
      ),
    );
  }
}
