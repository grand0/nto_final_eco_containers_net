import 'package:flutter/material.dart';

class ExpandableButton extends StatefulWidget {
  final Widget icon;
  final Widget label;
  final Widget contents;

  const ExpandableButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.contents,
  }) : super(key: key);

  @override
  State<ExpandableButton> createState() => _ExpandableButtonState();
}

class _ExpandableButtonState extends State<ExpandableButton> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.grey.shade100,
      child: InkWell(
        overlayColor: MaterialStateProperty.all(Colors.grey.shade200),
        borderRadius: BorderRadius.circular(15.0),
        onTap: () {
          setState(() {
            _expanded = !_expanded;
          });
        },
        child: Column(
          children: [
            Container(
              width: 400,
              height: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: widget.icon,
                  ),
                  widget.label,
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Icon(_expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down),
                  ),
                ],
              ),
            ),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 100),
              sizeCurve: Curves.easeIn,
              crossFadeState: !_expanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Container(width: 400),
              secondChild: Container(
                width: 400,
                child: widget.contents,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
