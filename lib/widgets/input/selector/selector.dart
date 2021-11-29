import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pi_papers_2021_2/models/operation_selection.dart';
import 'package:pi_papers_2021_2/widgets/input/selector/selector_button.dart';

class Selector extends HookWidget {
  const Selector({
    Key? key,
    required this.options,
  }) : super(key: key);

  final List<OperationSelection> options;

  @override
  Widget build(BuildContext context) {
    var selected = useState('');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 350),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: options
            .map(
              (e) => SelectorButton(
                groupValue: selected.value,
                value: e.value,
                icon: e.icon,
                onPressed: () {
                  selected.value = e.value;
                  e.onPressed();
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
