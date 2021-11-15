import 'package:flutter/material.dart';
import 'package:pi_papers_2021_2/models/operation_selection.dart';
import 'package:pi_papers_2021_2/widgets/input/selector/selector_button.dart';

class Selector extends StatefulWidget {
  const Selector({
    Key? key,
    required this.options,
  }) : super(key: key);

  final List<OperationSelection> options;

  @override
  State<StatefulWidget> createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  var selected = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 350),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widget.options
            .map(
              (e) => SelectorButton(
                groupValue: selected,
                value: e.value,
                icon: e.icon,
                onPressed: () {
                  setState(() => selected = e.value);
                  e.onPressed();
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
