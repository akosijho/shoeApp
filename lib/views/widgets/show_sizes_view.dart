import 'package:flutter/widgets.dart';
import 'package:flutter_shoe_app/views/shoe_details/shoe_sizes_view.dart';

typedef OnSizeSelectedCallback = void Function(List<String> values);

const List<String> ALL_SHOE_SIZES = [
  'UK 6',
  'UK 7',
  'UK 8',
  'UK 9',
  'UK 10',
  'UK 11',
  'UK 12',
  'UK 13',
];

class ShowSizesView extends StatelessWidget {
  const ShowSizesView({
    Key? key,
    required this.availableSizes,
    required this.selectedSizes,
    required this.onSizeSelectedCallback,
    this.isMultiSelectMode = true,
  }) : super(key: key);
  final List<String> availableSizes;
  final List<String> selectedSizes;
  final OnSizeSelectedCallback onSizeSelectedCallback;
  final bool isMultiSelectMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Select Sizes',
                style: TextStyle(
                  color: Color(0xff1F2732),
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                )),
          ),
        ),
        Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              for (String item in ALL_SHOE_SIZES)
                ShoeSizesViewItem(
                  item,
                  onItemSelected: (String value) {
                    final selectedSets =
                        isMultiSelectMode ? selectedSizes.toSet() : <String>{};
                    if (selectedSets.contains(value)) {
                      selectedSets.remove(value);
                    } else {
                      selectedSets.add(value);
                    }
                    onSizeSelectedCallback.call(selectedSets.toList());
                  },
                  isSelected: isItemSelected(item),
                  isNotAvailable: !isItemAvailable(item),
                ),
            ]),
      ],
    );
  }

  bool isItemSelected(String value) => selectedSizes.contains(value);

  bool isItemAvailable(String item) {
    return availableSizes.contains(item);
  }
}
