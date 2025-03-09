import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  static const _borderWidth = 2.0;
  static const _activeColor = Color(0xFFD8D8D8);
  static const _clearIcon = Icon(Icons.clear);
  static const _labelTextStyle = TextStyle(color: Color(0xFF9F9F9F));
  static const _mainTextStyle = TextStyle(
    color: _activeColor,
    decoration: TextDecoration.none,
    decorationThickness: 0,
  );
  static final _activeBorder = OutlineInputBorder(
    borderRadius: _borderRadius,
    borderSide: BorderSide(color: _activeColor, width: _borderWidth),
  );
  static final _enabledBorder = OutlineInputBorder(
    borderRadius: _borderRadius,
    borderSide: const BorderSide(color: Color(0xFF9A9A9A), width: _borderWidth),
  );
  static final _borderRadius = BorderRadius.circular(8.0);
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
      style: _mainTextStyle,
      cursorColor: _activeColor,
      decoration: InputDecoration(
        labelText: text,
        suffixIcon:
            showClearBtn
                ? IconButton(onPressed: controller.clear, icon: _clearIcon)
                : null,
        suffixIconColor: showClearBtn ? _activeColor : null,
        labelStyle: _labelTextStyle,
        enabledBorder: _enabledBorder,
        focusedBorder: _activeBorder,
        border: _activeBorder,
      ),
    );
  }
}
