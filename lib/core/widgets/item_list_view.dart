import 'package:flex_belt/core/constants/enum.dart';
import 'package:flex_belt/models/payload.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

class ItemListView extends StatefulWidget {
  final Payload payload;
  const ItemListView({super.key, required this.payload});

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView>
    with TickerProviderStateMixin {
  late final GifController _controller;
  bool showDetails = false;

  @override
  void initState() {
    super.initState();
    _controller = GifController(vsync: this);
    _controller.repeat(
      min: 0.0,
      max: 1.0,
      period: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the GifController to stop the Ticker
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              widget.payload.description,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            subtitle: Text(
              widget.payload.dateTime.toString().substring(11, 19),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 13.0,
                  ),
            ),
            leading: const Icon(Icons.circle),
            iconColor: widget.payload.status.getColor(),
            trailing: _hertaKuruKuru(),
            onTap: () => setState(() => showDetails = !showDetails),
          ),
          if (showDetails)
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDetailContainer(
                          'Angle X', widget.payload.angleX.toStringAsFixed(1)),
                      _buildDetailContainer(
                          'Angle Y', widget.payload.angleY.toStringAsFixed(1)),
                      _buildDetailContainer(
                          'Angle Z', widget.payload.angleZ.toStringAsFixed(1)),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDetailContainer(
                          'Flex', widget.payload.flex.toStringAsFixed(1)),
                      _buildDetailContainer(
                          'Encoder', widget.payload.encoder.toStringAsFixed(1)),
                      _buildDetailContainer(
                          'Battery', widget.payload.battery.toStringAsFixed(1)),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _hertaKuruKuru() {
    return Gif(
      image: AssetImage('assets/9r07fn.gif'),
      controller: _controller,
    );
  }

  Widget _buildDetailContainer(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.blue.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
            ),
            const SizedBox(height: 4.0),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
