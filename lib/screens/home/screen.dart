part of './library.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BookmarksStorage get _storage => BookmarksStorage.instance;

  Iterable<Bookmark> get _bookmarks => _storage.items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF454545),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListenableBuilder(
                listenable: _storage,
                builder: (BuildContext context, Widget? child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: _bookmarks.length + 1,
                    itemBuilder: (context, index) {
                      if (index < _bookmarks.length) {
                        return _TileWidget(_bookmarks.elementAt(index));
                      }
                      return const SizedBox(height: 16);
                    },
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              color: const Color(0xFF535353),
              child: Column(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: ValueListenableBuilder(
                      valueListenable: BookmarksStorage.edited,
                      builder: (BuildContext context, value, Widget? child) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: value
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: CustomOutlinedButton(
                                        text: 'Discard',
                                        onPressed: (ValueNotifier<bool>
                                            loading) async {
                                          loading.value = true;
                                          await BookmarksStorage.instance
                                              .load();
                                          await Future.delayed(const Duration(
                                              milliseconds: 250));
                                          loading.value = false;
                                          BookmarksStorage.changeEdited(false);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: CustomOutlinedButton(
                                        text: 'Save',
                                        onPressed: (ValueNotifier<bool>
                                            loading) async {
                                          loading.value = true;
                                          await BookmarksStorage.instance
                                              .save();
                                          await Future.delayed(const Duration(
                                              milliseconds: 250));
                                          loading.value = false;
                                          BookmarksStorage.changeEdited(false);
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        );
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const NewBookmarkScreen(),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFFD8D8D8),
                              width: 2.0,
                            ),
                          ),
                          child: Text(
                            'Add New'.toUpperCase(),
                            style: const TextStyle(
                              color: Color(0xFFD8D8D8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
