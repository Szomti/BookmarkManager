part of 'library.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final BoolValueNotifier _isLoadingNotifier = BoolValueNotifier(false);
  final DateFormat _formatter = DateFormat('yyyy-MM-dd-HH-mm-ss-SSS');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _createSortBySection(),
            _createLoaderColumn([
              _createHeader('Bookmarks'),
              // _createCustomDownloadBtn(),
              _createExportBtn(),
              _createImportBtn(),
            ]),
            const SizedBox(height: 16.0),
            _createHeader('Other'),
            _createSwitch(
              "Text Tags",
              SettingsStorage.instance.textTags,
              SettingsStorage.instance.setTextTags,
            ),
            const Spacer(),
            const MainNavigationBar(useMargin: true),
          ],
        ),
      ),
    );
  }

  Widget _createHeader(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFFD8D8D8),
        fontSize: 20.0,
      ),
    );
  }

  Widget _createLoaderColumn(Iterable<Widget> widgets) {
    return ValueListenableBuilder(
      valueListenable: _isLoadingNotifier,
      builder: (context, isLoading, widget) {
        if (!isLoading) return Column(children: widgets.toList());
        return const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: CircularProgressIndicator(
            color: Color(0xFFD8D8D8),
          ),
        );
      },
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
                _createHeader('Sort by:'),
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

  Widget _createSwitch(String text, bool value, void Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFFD8D8D8),
            fontSize: 16.0,
          ),
        ),
        const SizedBox(width: 16.0),
        GestureDetector(
          onTap: () {
            onChanged(!value);
            setState(() {});
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: const Color(0xFF656565),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              value ? 'ON' : 'OFF',
              style: const TextStyle(
                color: Color(0xFFD8D8D8),
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _createCustomDownloadBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: CustomOutlinedButton(
              text: 'Custom Download',
              onPressed: (_) async {
                var status = await Permission.storage.status;
                if (!status.isGranted) await Permission.storage.request();
                Directory tempDir = Directory('/storage/emulated/0/Download/');
                String tempPath = tempDir.path;
                final DateTime now = DateTime.now();
                var filePath =
                    '$tempPath/bookmarks_${_formatter.format(now)}.txt';
                String data = '';
                for (final item in BookmarksStorage.instance.items) {
                  final title = 'Title: ${item.title}';
                  final chapter =
                      'Chapter: ${item.chapter.main}${item.chapter.sub}';
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

  Widget _createExportBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: CustomOutlinedButton(
              text: 'Export',
              onPressed: (_) async {
                try {
                  _isLoadingNotifier.setTrue();
                  var status = await Permission.storage.status;
                  if (!status.isGranted) await Permission.storage.request();
                  Directory tempDir =
                      Directory('/storage/emulated/0/Download/');
                  String tempPath = tempDir.path;
                  final DateTime now = DateTime.now();
                  var filePath =
                      '$tempPath/bookmarks_${_formatter.format(now)}.json';
                  await File(filePath)
                      .writeAsString(BookmarksStorage.instance.exported());
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Success'),
                    backgroundColor: Colors.green,
                    duration: Duration(milliseconds: 750),
                  ));
                } catch (error, stackTrace) {
                  debugPrint('[ERROR] $error\n$stackTrace');
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Error occurred'),
                    backgroundColor: Colors.red,
                    duration: Duration(milliseconds: 750),
                  ));
                } finally {
                  await Future.delayed(const Duration(milliseconds: 100));
                  _isLoadingNotifier.setFalse();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _createImportBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: CustomOutlinedButton(
              text: 'Import',
              onPressed: (_) async {
                _isLoadingNotifier.setTrue();
                await showDialog(
                  context: context,
                  builder: (context) => _createDialog(context),
                );
                await Future.delayed(const Duration(milliseconds: 350));
                _isLoadingNotifier.setFalse();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDialog(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: const Color(0xFF454545),
                borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Imported data will override local one. Are you sure?',
                    style: TextStyle(
                      color: Color(0xFFD8D8D8),
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _createDialogBtn('Cancel', () {
                        if (context.mounted) Navigator.pop(context);
                      }),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: _createDialogBtn('Confirm', () async {
                        try {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['json', 'txt'],
                          );
                          String path = result?.files.single.path ?? '';
                          if (path.isEmpty) return;
                          File file = File(path);
                          String jsonData = await file.readAsString();
                          await BookmarksStorage.instance.import(jsonData);
                        } catch (error, stackTrace) {
                          debugPrint('[ERROR] $error\n$stackTrace');
                        }
                        if (context.mounted) Navigator.pop(context);
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDialogBtn(String text, void Function() onPressed) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Color(0xFFD8D8D8),
                width: 2.0,
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text,
                style: const TextStyle(color: Color(0xFFD8D8D8)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
