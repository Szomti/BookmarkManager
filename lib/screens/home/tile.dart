part of 'library.dart';

class _TileWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends State<_TileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF757575),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'data',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFD8D8D8),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              _createBtn(Icons.remove, () {}),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '0',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFD8D8D8),
                    ),
                  ),
                ),
              ),
              _createBtn(Icons.add, () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _createBtn(IconData icon, void Function() onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.remove,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
