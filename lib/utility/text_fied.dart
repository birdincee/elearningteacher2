import 'package:elearningteacher2/utility/font_thai.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFields {
  static Widget textFieldSignIN({
    required TextEditingController controller,
    bool obscureText = false,
    TextInputAction textInputAction = TextInputAction.done,
    TextInputType keyboardType = TextInputType.text,
    IconData? icon,
    String? hint,
    List<TextInputFormatter>? inputFormatters,
    Function(String)? onChanged,
    FocusNode? focusNode,
  }) {
    return TextField(
      style: FontThai.text16BlackNormal,
      obscureText: obscureText,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      focusNode: focusNode,
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(8),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.pink,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        icon: Icon(
          icon,
          color: Colors.pink,
          size: 20,
        ),
        hintText: hint,
      ),
    );
  }

  static Widget textFieldEdit({
    required TextEditingController controller,
    bool obscureText = false,
    TextInputAction textInputAction = TextInputAction.done,
    TextInputType keyboardType = TextInputType.text,
    String? hint,
    List<TextInputFormatter>? inputFormatters,
    Function(String)? onChanged,
    FocusNode? focusNode,
    IconData? iconData,
  }) {
    return TextField(
      style: FontThai.text16BlackNormal,
      obscureText: obscureText,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      focusNode: focusNode,
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(8),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.pink,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        prefixIcon: Icon(iconData),
        hintText: hint,
      ),
    );
  }

  static Widget textFieldCreate({
    required TextEditingController controller,
    bool obscureText = false,
    TextInputAction textInputAction = TextInputAction.done,
    TextInputType keyboardType = TextInputType.text,
    String? hint,
    List<TextInputFormatter>? inputFormatters,
    Function(String)? onChanged,
    VoidCallback? onTap,
  }) {
    return TextField(
      style: FontThai.text16BlackNormal,
      obscureText: obscureText,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onTap: onTap,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(8),
        enabledBorder: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.grey,
        )),
        hintText: hint,
      ),
    );
  }
}
