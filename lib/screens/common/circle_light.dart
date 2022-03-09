import 'package:flutter/material.dart';

class CircleLight extends StatelessWidget {
  final Color enabledColor;
  final Color disabledColor;
  final bool enabled;
  final Widget enabledIcon;
  final Widget disabledIcon;

  const CircleLight({
    Key? key,
    required this.enabledColor,
    required this.disabledColor,
    required this.enabled,
    required this.enabledIcon,
    required this.disabledIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: enabled ? enabledColor : disabledColor,
      ),
      child: enabled ? enabledIcon : disabledIcon,
    );
  }
}
