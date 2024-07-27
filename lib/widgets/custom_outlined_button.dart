import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatefulWidget {
  final String text;
  final Future<void> Function(ValueNotifier<bool> loading) onPressed;

  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<StatefulWidget> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> {
  final _loading = ValueNotifier(false);

  String get _text => widget.text;

  Future<void> Function(ValueNotifier<bool> loading) get _onPressed => widget.onPressed;

  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _loading,
      builder: (_, bool loading, __) {
        return OutlinedButton(
          onPressed: loading ? null : () => _onPressed(_loading),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: Color(0xFFD8D8D8),
              width: 2.0,
            ),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: loading
                ? const SizedBox.square(
                  dimension: 22,
                  child: CircularProgressIndicator(
                      color: Color(0xFFD8D8D8),
                    strokeWidth: 2,
                    ),
                )
                : Text(
                    _text,
                    style: const TextStyle(color: Color(0xFFD8D8D8)),
                  ),
          ),
        );
      },
    );
  }
}
