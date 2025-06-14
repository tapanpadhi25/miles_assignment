import 'package:flutter/material.dart';

InputDecoration customInputDecoration({
  required String label,
  String? hint,
  Widget? prefixIcon,
  Widget? suffixIcon,
  required BuildContext context,
}) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.grey),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    errorBorder:  OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red),
    ),
  );
}
