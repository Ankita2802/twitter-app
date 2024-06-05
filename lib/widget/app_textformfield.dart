import 'package:api_withgetx/theme/app_color.dart';
import 'package:api_withgetx/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    super.key,
    this.controller,
    this.errorText,
    this.textInputType,
    this.textInputAction,
    this.obscureText = false,
    this.validate,
    this.suffixIcon,
    this.hintText,
    this.labelText,
    this.labelStyle,
    this.onChange,
    this.contentPadding,
    this.prefix,
    this.cursorHeight = 14,
    this.minLines = 1,
    this.maxLines = 1,
    final bool? suffixArrow,
    this.initialValue,
    this.maxDigit,
    this.enabled = true,
    this.inputFormatters,
    this.suffix,
    this.onTap,
    String? error,
    this.readOnly = false,
  });
  final TextEditingController? controller;
  final String? errorText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final String? validate;
  final Widget? suffixIcon;
  final String? hintText;
  final TextStyle? labelStyle;
  final ValueChanged<String>? onChange;
  final EdgeInsetsGeometry? contentPadding;
  final String? labelText;
  final Widget? prefix;
  final double cursorHeight;
  final int minLines;
  final int? maxLines;
  final String? initialValue;
  final int? maxDigit;
  final bool enabled;
  final bool readOnly;

  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final VoidCallback? onTap;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: const Color(0xFF262C48),
        primaryColorDark: const Color(0xFF262C48),
      ),
      child: TextFormField(
        onTap: widget.onTap,
        readOnly: widget.readOnly,
        enabled: widget.enabled,
        initialValue: widget.initialValue,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        cursorHeight: widget.cursorHeight,
        cursorWidth: 1,
        obscureText: widget.obscureText,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        keyboardType: widget.textInputType,
        cursorColor: Colors.black,
        style: normalBlack,
        inputFormatters: widget.maxDigit != null
            ? [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(widget.maxDigit),
              ]
            : widget.textInputType != TextInputType.phone
                ? widget.inputFormatters
                : [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
        validator: (value) {
          if (value!.isEmpty) {
            return widget.errorText;
          }
          return widget.validate;
        },
        decoration: InputDecoration(
          hintStyle: normalBlack.copyWith(fontSize: 14),
          prefixIcon: widget.prefix,
          contentPadding: widget.contentPadding ?? const EdgeInsets.all(10),
          hintText: widget.hintText,
          fillColor: AppColors.appBlue.withOpacity(0.1),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
          suffixIcon: widget.suffixIcon,
          suffix: widget.suffix,
          alignLabelWithHint: false,
          filled: true,
          errorMaxLines: 3,
        ),
        onChanged: widget.onChange,
      ),
    );
  }
}
