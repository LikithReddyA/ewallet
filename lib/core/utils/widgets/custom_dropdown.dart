import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final String Function(T) itemTextMapper; // Function to get display text
  final ValueChanged<T?>? onChanged;
  final String hintText;

  const CustomDropdown({
    super.key,
    required this.items,
    this.selectedItem,
    required this.itemTextMapper,
    this.onChanged,
    this.hintText = 'Select an item',
  });

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  T? _currentSelectedItem;

  @override
  void initState() {
    super.initState();
    _currentSelectedItem = widget.selectedItem;
  }

  @override
  void didUpdateWidget(covariant CustomDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedItem != oldWidget.selectedItem) {
      _currentSelectedItem = widget.selectedItem;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the InputDecorationTheme from the current theme
    final InputDecorationThemeData themeDecoration = Theme.of(
      context,
    ).inputDecorationTheme;

    // Merge the provided decoration with the theme decoration
    // The provided widget.decoration will override properties from the themeDecoration
    // if they are explicitly set.
    final InputDecoration effectiveDecoration =
        (const InputDecoration()) // Start with an empty InputDecoration if none is provided
            .applyDefaults(themeDecoration) // Apply theme defaults
            .copyWith(
              hintText: widget.hintText,
              // If you want to ensure a border is always present when using theme,
              // you might explicitly set it here if not already set by the theme.
              // For example: border: themeDecoration?.border ?? const OutlineInputBorder(),
            );
    return InputDecorator(
      decoration: effectiveDecoration,
      isEmpty: _currentSelectedItem == null,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: _currentSelectedItem,
          onChanged: (T? newValue) {
            setState(() {
              _currentSelectedItem = newValue;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(newValue);
            }
          },
          items: widget.items.map<DropdownMenuItem<T>>((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(widget.itemTextMapper(item)), // Use the mapper here
            );
          }).toList(),
        ),
      ),
    );
  }
}
