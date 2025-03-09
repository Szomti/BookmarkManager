import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatefulWidget {
  final String text;
  final Widget? icon;
  final Future<void> Function(ValueNotifier<bool> loading) onPressed;

  const CustomOutlinedButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
  });

  @override
  State<StatefulWidget> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> {
  static const _buttonSide = BorderSide(color: Color(0xFFD8D8D8), width: 2.0);
  static const _indicatorColor = Color(0xFFD8D8D8);
  static const _textStyle = TextStyle(color: Color(0xFFD8D8D8));
  static const _indicatorSize = 22.0;
  static const _indicatorWidth = 2.0;
  static final _buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  );
  final _loading = ValueNotifier(false);

  String get _text => widget.text;

  Widget? get _icon => widget.icon;

  Future<void> Function(ValueNotifier<bool> loading) get _onPressed =>
      widget.onPressed;

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
            shape: _buttonShape,
            side: _buttonSide,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child:
                loading
                    ? const SizedBox.square(
                      dimension: _indicatorSize,
                      child: CircularProgressIndicator(
                        color: _indicatorColor,
                        strokeWidth: _indicatorWidth,
                      ),
                    )
                    : Row(
                      children: [
                        Text(_text, style: _textStyle),
                        _icon ?? const SizedBox.shrink(),
                      ],
                    ),
          ),
        );
      },
    );
  }
}
