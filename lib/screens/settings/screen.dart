part of 'library.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _createSortBySection(),
            _createPureDownloadBtn(),
            _createJsonAsTxtDownloadBtn(),
            _createJsonDownloadBtn(),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _createSortBySection() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFF656565),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Sort by:',
                  style: TextStyle(
                    color: Color(0xFFD8D8D8),
                    fontSize: 20.0,
                  ),
                ),
                for (final type in SortType.values) _createSortByTile(type),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createSortByTile(SortType type) {
    return ListenableBuilder(
      listenable: BookmarksStorage.sortType,
      builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => BookmarksStorage.instance.changeSortType(type),
          child: Container(
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    type.text,
                    style: const TextStyle(
                      color: Color(0xFFD8D8D8),
                      fontSize: 16.0,
                    ),
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: BookmarksStorage.sortType.value == type
                      ? const Icon(
                          Icons.check_circle_outline,
                          size: 24.0,
                          color: Color(0xFFD8D8D8),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _createPureDownloadBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: CustomOutlinedButton(
              text: 'Download text file (.txt)',
              onPressed: (_) async {
                var status = await Permission.storage.status;
                if (!status.isGranted) await Permission.storage.request();
                Directory tempDir = Directory('/storage/emulated/0/Download/');
                String tempPath = tempDir.path;
                final DateFormat formatter = DateFormat('yyyy-MM-dd-HH-mm-ss');
                final DateTime now = DateTime.now();
                var filePath = '$tempPath/bookmarks_${formatter.format(now)}.txt';
                String data = '';
                for (final item in BookmarksStorage.instance.items) {
                  final title = 'Title: ${item.title}';
                  final chapter = 'Chapter: ${item.chapter.main}${item.chapter.sub}';
                  data += '$title, $chapter\n';
                }
                await File(filePath).writeAsString(data);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _createJsonAsTxtDownloadBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: CustomOutlinedButton(
              text: 'Download json file (.txt)',
              onPressed: (_) async {
                var status = await Permission.storage.status;
                if (!status.isGranted) await Permission.storage.request();
                Directory tempDir = Directory('/storage/emulated/0/Download/');
                String tempPath = tempDir.path;
                final DateFormat formatter = DateFormat('yyyy-MM-dd-HH-mm-ss');
                final DateTime now = DateTime.now();
                var filePath = '$tempPath/bookmarks_${formatter.format(now)}.txt';
                await File(filePath).writeAsString('\n${BookmarksStorage.instance.bookmarksToSave().toList()}\n');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _createJsonDownloadBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: CustomOutlinedButton(
              text: 'Download json file (.json)',
              onPressed: (_) async {
                var status = await Permission.storage.status;
                if (!status.isGranted) await Permission.storage.request();
                Directory tempDir = Directory('/storage/emulated/0/Download/');
                String tempPath = tempDir.path;
                final DateFormat formatter = DateFormat('yyyy-MM-dd-HH-mm-ss');
                final DateTime now = DateTime.now();
                var filePath = '$tempPath/bookmarks_${formatter.format(now)}.json';
                await File(filePath).writeAsString('\n${BookmarksStorage.instance.bookmarksToSave().toList()}\n');
              },
            ),
          ),
        ],
      ),
    );
  }
}
