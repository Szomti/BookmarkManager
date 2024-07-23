class Bookmark {
  final int id;
  final String text;
  final int ordinal;
  final Chapter chapter;

  Bookmark({
    required this.id,
    required this.text,
    required this.ordinal,
    required this.chapter,
  });
}

class Chapter {
  final int main;
  final int sub;

  Chapter({
    required this.main,
    required this.sub,
  });
}
