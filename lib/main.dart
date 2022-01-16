import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cupertino Widgets',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const ItemPicker(),
    );
  }
}

class ItemPicker extends StatefulWidget {
  const ItemPicker({Key? key}) : super(key: key);

  @override
  _ItemPickerState createState() => _ItemPickerState();
}

class _ItemPickerState extends State<ItemPicker> {
  FixedExtentScrollController? scrollController;
  int selectedIndex = 1;
  String? selectedItem;
  List listItems = [
    'Item 1',
    'Item 2',
    'Item 3',
  ];

  @override
  initState() {
    super.initState();
    scrollController = FixedExtentScrollController(initialItem: selectedIndex);
  }

  @override
  dispose() {
    scrollController!.dispose();
    super.dispose();
  }

  showPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        // double mediaQueryHeight = MediaQuery.of(context).size.height;
        return CupertinoActionSheet(
          actions: [
            CustomCupertinoPicker(
              scrollController: scrollController,
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedIndex = index!;
                });
              },
              listItems: listItems,
              selectedIndex: selectedIndex,
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18.0,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cupertino picker demo"),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10.0),
          Text("Selected: ${listItems[selectedIndex]}"),
          const SizedBox(height: 10.0),
          Center(
            child: ElevatedButton(
              onPressed: () {
                scrollController!.dispose();
                scrollController =
                    FixedExtentScrollController(initialItem: selectedIndex);
                showPicker();
              },
              child: const Text("Show picker"),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCupertinoPicker extends StatelessWidget {
  final Function(int?)? onSelectedItemChanged;
  final List? listItems;
  final int? selectedIndex;
  final FixedExtentScrollController? scrollController;
  final Color? selectedItemColor;
  const CustomCupertinoPicker({
    Key? key,
    this.onSelectedItemChanged,
    this.listItems,
    this.selectedIndex,
    this.scrollController,
    this.selectedItemColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: mediaQueryHeight * 0.35,
      child: CupertinoPicker(
        scrollController: scrollController,
        backgroundColor: Colors.white,
        selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
          background: Colors.teal.withOpacity(0.2),
        ),
        onSelectedItemChanged: (index) {},
        itemExtent: 50.0,
        children: List.generate(
          listItems!.length,
          (index) {
            final item = listItems![index];
            return Center(
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 26.0,
                  color: Colors.black87,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
