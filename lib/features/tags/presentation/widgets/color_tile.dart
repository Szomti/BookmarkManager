import 'package:material_ui/material_ui.dart';

class ColorTile extends StatelessWidget {
  final Color color;

  const ColorTile(this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, borderRadius: .circular(4.0)),
      child: const SizedBox.square(dimension: 24.0),
    );
  }
}
