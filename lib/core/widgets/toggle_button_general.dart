import 'package:flutter/material.dart';

class ToggleButtonGeneral extends StatefulWidget {
  final List<String> items;
  final void Function(bool)? onChanged;

  const ToggleButtonGeneral({super.key, required this.items, this.onChanged});

  @override
  State<ToggleButtonGeneral> createState() => _ToggleButtonGeneralState();
}

class _ToggleButtonGeneralState extends State<ToggleButtonGeneral> {
  bool _isAdmin = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: ToggleButtons(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width * 0.25,
            minHeight: 5,
          ),
          borderRadius: BorderRadius.circular(5),
          isSelected: [_isAdmin, !_isAdmin],
          color: const Color.fromRGBO(2, 84, 100, 1),
          selectedColor: Colors.white,
          fillColor: _isAdmin
              ? const Color.fromRGBO(
                  2, 84, 100, 1) // Current color for items[0]
              : Colors.red, // Red color for items[1]
          borderColor: const Color.fromRGBO(2, 84, 100, 1),
          selectedBorderColor: _isAdmin
              ? const Color.fromRGBO(
                  2, 84, 100, 1) // Current color for items[0]
              : Colors.red, // Red color for items[1],
          onPressed: (index) async {
            setState(() {
              _isAdmin = index == 0;
              widget.onChanged!(_isAdmin);
            });
          },
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person, size: 13),
                SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.items[0],
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: _isAdmin
                                ? Colors.white
                                : const Color.fromRGBO(2, 84, 100, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          )),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person, size: 13),
                SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.items[1],
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: _isAdmin
                                ? const Color.fromRGBO(2, 84, 100, 1)
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
