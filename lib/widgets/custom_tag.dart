import 'package:bookmark_manager/storage/tags/tag.dart';
import 'package:flutter/material.dart';

class CustomTag extends StatelessWidget {
  final Tag tag;

  const CustomTag(this.tag, {super.key});

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(5.0),
        child: Text(
          tag.label,
          style: TextStyle(
            color: tag.labelColor,
          ),
        ),
      ),
    );
  }
}
