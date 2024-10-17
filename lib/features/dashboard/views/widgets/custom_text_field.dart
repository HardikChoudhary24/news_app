import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  static const textFieldColor = Color(0xFFEDECEC);
  final TextEditingController controller;
  final String name;
  final IconData prefixIcon;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final TextInputType inputType;
  final Function(String)? onSubmit;
  final bool allowDebouncing;
  Timer? _debounce = null;

  CustomTextField({
    Key? key,
    required this.allowDebouncing,
    required this.onSubmit,
    required this.controller,
    required this.name,
    required this.prefixIcon,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    required this.inputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: TextField(
        onChanged: (query) {
          if (_debounce != null && _debounce!.isActive) {
            _debounce!.cancel();
          } else {
            _debounce = Timer(const Duration(milliseconds: 300), () {
              if (onSubmit != null && query.isNotEmpty) {
                onSubmit!(query);
              }
            });
          }
        },
        onSubmitted: onSubmit,
        enabled: true,
        controller: controller,
        textCapitalization: textCapitalization,
        maxLength: 32,
        maxLines: 1,
        obscureText: obscureText,
        keyboardType: inputType,
        textAlign: TextAlign.start,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          fillColor: textFieldColor,
          filled: true,
          prefixIcon: Icon(prefixIcon),
          isDense: true,
          hintText: name,
          counterText: "",
          labelStyle: const TextStyle(color: Color(0xFFB3B3B3)),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: textFieldColor),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: textFieldColor),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: textFieldColor),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
