import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// TODO: Clean up
class CustomTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final TextInputType? type;
  final bool showClearBtn;
  final Iterable<TextInputFormatter> formatters;

  const CustomTextField(
    this.text,
    this.controller, {
    this.type,
    this.formatters = const Iterable.empty(),
    this.showClearBtn = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: type,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      inputFormatters: formatters.toList(),
      style: const TextStyle(
        color: Color(0xFFD8D8D8),
        decoration: TextDecoration.none,
        decorationThickness: 0,
      ),
      cursorColor: const Color(0xFFD8D8D8),
      decoration: InputDecoration(
        labelText: text,
        suffixIcon: showClearBtn
            ? IconButton(
                onPressed: controller.clear,
                icon: const Icon(Icons.clear),
              )
            : null,
        suffixIconColor: showClearBtn ? const Color(0xFFD8D8D8) : null,
        labelStyle: const TextStyle(
          color: Color(0xFF9F9F9F),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Color(0xFFD8D8D8),
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Color(0xFF9A9A9A),
            width: 2.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Color(0xFFD8D8D8),
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
