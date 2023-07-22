import 'package:flutter/material.dart';

class DropdownSelectionWidget extends StatefulWidget {
  final List<String> options;
  final String selectedOption;
  final Function(String) onChanged;

  DropdownSelectionWidget({
    required this.options,
    required this.selectedOption,
    required this.onChanged,
  });

  @override
  _DropdownSelectionWidgetState createState() =>
      _DropdownSelectionWidgetState();
}

class _DropdownSelectionWidgetState extends State<DropdownSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.selectedOption,
      onChanged: (newValue) {
        setState(() {
          widget.onChanged(newValue!);
        });
      },
      items: widget.options.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
    );
  }
}
