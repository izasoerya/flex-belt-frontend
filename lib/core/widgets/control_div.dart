import 'dart:async';

// import 'package:flex_belt/core/constants/enum.dart';
// import 'package:flex_belt/core/widgets/boxed_icon.dart';
import 'package:flex_belt/core/widgets/modal_dialog.dart';
import 'package:flex_belt/core/widgets/slider_value.dart';
import 'package:flex_belt/core/widgets/switch_button.dart';
import 'package:flex_belt/core/widgets/toggle_button_general.dart';
import 'package:flutter/material.dart';

class ControlDiv extends StatefulWidget {
  // final ValueNotifier<StatusType> statusNotifier;
  final void Function(Map<bool, int>) heaterValues;

  const ControlDiv({
    super.key,
    // required this.statusNotifier,
    required this.heaterValues,
  });

  @override
  State<ControlDiv> createState() => _ControlDivState();
}

class _ControlDivState extends State<ControlDiv> {
  bool isCold = true;
  void setCold(bool value) => setState(() {
        isCold = value;
        on
            ? widget.heaterValues({isCold: heaterValue.toInt()})
            : widget.heaterValues({isCold: 0});
      });

  double heaterValue = 0;
  double previousHeaterValue = 0;
  void previewHeaterValue(double value) {
    setState(() {
      heaterValue = value;
    });
  }

  Future<void> commitHeaterValue(double value) async {
    if (value > 70) {
      final confirmed = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => ModalDialog(callback: (_) {}),
      );
      if (confirmed != true) {
        setState(() => heaterValue = previousHeaterValue);
        return;
      }
    }
    setState(() {
      heaterValue = value;
      previousHeaterValue = heaterValue;
      on
          ? widget.heaterValues({isCold: value.toInt()})
          : widget.heaterValues({isCold: 0});
    });
  }

  bool on = false;
  void setOn(bool value) => setState(() {
        on = value;
        on
            ? widget.heaterValues({isCold: heaterValue.toInt()})
            : widget.heaterValues({isCold: 0});
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Heater is ${on ? 'ON' : 'OFF'}!')));
      });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            alignment: Alignment.center,
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SwitchButton(on: on, onChanged: setOn),
                    Padding(padding: EdgeInsets.only(right: 10)),
                    ToggleButtonGeneral(
                      items: ['Dingin', 'Panas'],
                      onChanged: setCold,
                    ),
                  ],
                ),
                CustomSlider(
                  value: heaterValue,
                  onChanged: previewHeaterValue,
                  onChangeEnd: commitHeaterValue,
                ),
              ],
            ),
          ),
        ),
        // Container(
        //   padding: const EdgeInsets.all(10.0),
        //   margin: const EdgeInsets.symmetric(vertical: 5.0),
        //   alignment: Alignment.center,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(8.0),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.black.withOpacity(0.1),
        //         blurRadius: 4.0,
        //         offset: const Offset(0, 2),
        //       ),
        //     ],
        //   ),
        //   child: ValueListenableBuilder(
        //       valueListenable: widget.statusNotifier,
        //       builder: (context, status, _) {
        //         return Column(
        //           children: [
        //             BoxedIcon(icon: Icons.vibration),
        //             const SizedBox(height: 10),
        //             Text(
        //               status == StatusType.safe
        //                   ? 'Vibrator\nOFF'
        //                   : 'Vibrator\nON',
        //               style: Theme.of(context).textTheme.bodySmall!.copyWith(
        //                     color: const Color.fromRGBO(2, 84, 100, 1),
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 14,
        //                   ),
        //               textAlign: TextAlign.center,
        //             ),
        //           ],
        //         );
        //       }),
        // )
      ],
    );
  }
}
