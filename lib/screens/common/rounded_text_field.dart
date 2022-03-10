import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final bool obscure;
  final void Function(String)? onSubmitted;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;

  const RoundedTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscure = false,
    this.onSubmitted,
    this.autofocus = false,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        labelText: label,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 12.0),
          child: prefixIcon,
        ),
        suffixIcon: suffixIcon,
      ),
      obscureText: obscure,
      onSubmitted: onSubmitted,
      autofocus: autofocus,
      inputFormatters: inputFormatters,
    );
  }
}

class RoundedTextFieldWithObscure extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final Widget prefixIcon;
  final void Function(String)? onSubmitted;
  final bool autofocus;

  const RoundedTextFieldWithObscure({
    Key? key,
    required this.controller,
    required this.label,
    required this.prefixIcon,
    this.onSubmitted,
    this.autofocus = false,
  }) : super(key: key);

  @override
  _RoundedTextFieldWithObscureState createState() =>
      _RoundedTextFieldWithObscureState();
}

class _RoundedTextFieldWithObscureState
    extends State<RoundedTextFieldWithObscure> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return RoundedTextField(
      controller: widget.controller,
      label: widget.label,
      prefixIcon: widget.prefixIcon,
      obscure: obscure,
      autofocus: widget.autofocus,
      suffixIcon: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: IconButton(
          icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              obscure = !obscure;
            });
          },
        ),
      ),
      onSubmitted: widget.onSubmitted,
    );
  }
}
