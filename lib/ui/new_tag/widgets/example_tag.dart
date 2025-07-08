part of '../library.dart';

class ExampleTag extends StatefulWidget {
  final NewTagScreenViewModel viewModel;

  const ExampleTag(this.viewModel, {super.key});

  @override
  State<StatefulWidget> createState() => _ExampleTagState();
}

class _ExampleTagState extends State<ExampleTag> {
  NewTagScreenViewModel get _viewModel => widget.viewModel;

  Color get _labelColor => _viewModel.labelColor;

  Color get _backgroundColor => _viewModel.backgroundColor;

  Color get _borderColor => _viewModel.borderColor;

  TextEditingController get _labelController => _viewModel.labelController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD8D8D8), width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const Text('Your Tag:', style: TextStyle(fontSize: 20.0)),
                const SizedBox(height: 16.0),
                ListenableBuilder(
                  listenable: _viewModel,
                  builder: (BuildContext context, Widget? child) {
                    String label = _labelController.text;
                    return CustomTag(
                      Tag(
                        label: label.isEmpty ? 'Example' : label,
                        labelColor: _labelColor,
                        backgroundColor: _backgroundColor,
                        borderColor: _borderColor,
                      ),
                      forceCustom: true,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
