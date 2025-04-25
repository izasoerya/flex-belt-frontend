import 'package:flex_belt/models/payload.dart';
import 'package:flex_belt/core/widgets/item_list_view.dart';
import 'package:flutter/material.dart';

class PayloadList extends StatefulWidget {
  const PayloadList({super.key});

  @override
  State<PayloadList> createState() => PayloadListState();
}

class PayloadListState extends State<PayloadList> {
  final List<Payload> _payloadItems = [];

  void addPayload(Payload payload) {
    setState(() {
      if (_payloadItems.length >= 10) {
        _payloadItems.removeLast(); // Correctly remove the oldest item
      }
      _payloadItems.add(payload); // Add the new payload
    });
    _payloadItems
        .sort((a, b) => b.dateTime.compareTo(a.dateTime)); // Sort by dateTime
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _payloadItems.length,
        itemBuilder: (context, index) {
          return ItemListView(payload: _payloadItems[index]);
        },
      ),
    );
  }

  // Expose a method to clear the list
  void clear() {
    setState(() => _payloadItems.clear());
  }
}
