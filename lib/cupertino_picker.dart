import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoItemPicker extends StatefulWidget {
  const CupertinoItemPicker({Key? key}) : super(key: key);

  @override
  _CupertinoItemPickerState createState() => _CupertinoItemPickerState();
}

class _CupertinoItemPickerState extends State<CupertinoItemPicker> {
  late TextEditingController textEditingController;
  late FixedExtentScrollController scrollController;
  int index = 2;
  final items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: items[index]);
    scrollController = FixedExtentScrollController(initialItem: index);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   items[index],
            //   style: const TextStyle(
            //     fontSize: 48.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: CupertinoTextField(
                controller: textEditingController,
                readOnly: true,
                enableInteractiveSelection: false,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 48.0, fontWeight: FontWeight.bold),
                decoration: BoxDecoration(
                  border: Border.all(width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CupertinoButton.filled(
                child: const Text('Open Picker'),
                onPressed: () {
                  scrollController.dispose();
                  scrollController =
                      FixedExtentScrollController(initialItem: index);
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      actions: [
                        buildPicker(),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        child: const Text('Done'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPicker() => SizedBox(
        height: 350.0,
        child: StatefulBuilder(builder: (context, setState) {
          return CupertinoPicker(
            scrollController: scrollController,
            itemExtent: 64,
            selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
              background: Colors.teal.withOpacity(0.2),
            ),
            children: List.generate(items.length, (index) {
              final isSelected = this.index == index;
              final textColor = isSelected ? Colors.teal : Colors.black;
              final item = items[index];
              return Center(
                child: Text(
                  item,
                  style: TextStyle(color: textColor, fontSize: 32.0),
                ),
              );
            }),
            onSelectedItemChanged: (index) {
              setState(() => this.index = index);
              final item = items[index];
              textEditingController.text = item;
              debugPrint(item);
            },
          );
        }),
      );
}
