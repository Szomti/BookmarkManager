import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final TextInputType? type;
  final Iterable<TextInputFormatter> formatters;

  const CustomTextField(
    this.text,
    this.controller, {
    this.type,
    this.formatters = const Iterable.empty(),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: type,
      inputFormatters: formatters.toList(),
      style: const TextStyle(
        color: Color(0xFFD8D8D8),
        decoration: TextDecoration.none,
        decorationThickness: 0,
      ),
      cursorColor: const Color(0xFFD8D8D8),
      decoration: InputDecoration(
        labelText: text,
        labelStyle: const TextStyle(
          color: Color(0xFF9F9F9F),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFD8D8D8),
            width: 2.0,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFD8D8D8),
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
