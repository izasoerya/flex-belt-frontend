import 'package:flex_belt/core/constants/enum.dart';
import 'package:flex_belt/core/widgets/boxed_icon.dart';
import 'package:flex_belt/core/widgets/slider_value.dart';
import 'package:flex_belt/core/widgets/toggle_button_general.dart';
import 'package:flutter/material.dart';

class ControlDiv extends StatefulWidget {
  final ValueNotifier<StatusType> statusNotifier;
  final void Function(Map<bool, int>) heaterValues;

  const ControlDiv({
    super.key,
    required this.statusNotifier,
    required this.heaterValues,
  });

  @override
  State<ControlDiv> createState() => _ControlDivState();
}

class _ControlDivState extends State<ControlDiv> {
  bool isCold = true;
  void setCold(bool value) => setState(() {
        isCold = value;
        widget.heaterValues({isCold: heaterValue.toInt()});
      });

  double heaterValue = 0;
  void setHeaterValue(double value) => setState(() {
        heaterValue = value;
        widget.heaterValues({isCold: value.toInt()});
      });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.65,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ToggleButtonGeneral(
                    items: ['Dingin', 'Panas'],
                    onChanged: setCold,
                  ),
                ],
              ),
              CustomSlider(value: 50, onChanged: setHeaterValue),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.symmetric(vertical: 5.0),
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
          child: ValueListenableBuilder(
              valueListenable: widget.statusNotifier,
              builder: (context, status, _) {
                return Column(
                  children: [
                    BoxedIcon(icon: Icons.vibration),
                    const SizedBox(height: 10),
                    Text(
                      status == StatusType.safe
                          ? 'Vibrator\nOFF'
                          : 'Vibrator\nON',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: const Color.fromRGBO(2, 84, 100, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }),
        )
      ],
    );
  }
}
