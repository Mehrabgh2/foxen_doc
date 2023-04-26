import 'package:flutter/material.dart';
import '../util/app_theme.dart';
import 'custom_svg_widget.dart';

class CustomTextField extends StatefulWidget {
  static const height = 35.0;
  final String? hintText;
  final bool isPassword;
  final Function(String)? onchanged;
  final int maxLine;
  final TextInputType type;
  final int? maxLength;
  final TextEditingController? controller;
  final bool textEnable;
  final TextInputAction action;
  final Widget? subChild;
  final bool isError;
  final bool autoFocus;
  final TextAlign textAlign;
  final FocusNode? focusNode;
  final Widget? leftWidget;
  final VoidCallback? onPressed;

  const CustomTextField({
    this.type = TextInputType.text,
    this.hintText,
    this.onchanged,
    this.maxLength,
    this.maxLine = 1,
    this.isPassword = false,
    this.controller,
    this.textEnable = true,
    this.action = TextInputAction.next,
    this.subChild,
    this.textAlign = TextAlign.left,
    this.isError = false,
    this.autoFocus = false,
    this.focusNode,
    this.leftWidget,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isPasswordShown = widget.isPassword;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppTheme.textFieldBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1,
              color:
                  widget.isError ? AppTheme.errorTextColor : Colors.transparent,
            ),
          ),
          height: CustomTextField.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.leftWidget != null) widget.leftWidget!,
              Expanded(
                child: TextFormField(
                  focusNode: widget.focusNode,
                  textAlign: widget.textAlign,
                  obscureText: isPasswordShown,
                  controller: widget.controller,
                  onChanged: widget.onchanged,
                  maxLines: widget.maxLine,
                  cursorColor: Colors.black,
                  keyboardType: widget.type,
                  textInputAction: widget.action,
                  maxLength: widget.maxLength,
                  autofocus: widget.autoFocus,
                  readOnly: widget.onPressed != null,
                  onTap: () {
                    if (widget.onPressed != null) {
                      widget.onPressed!();
                    } else {
                      if (widget.controller != null) {
                        if (widget.controller!.selection ==
                            TextSelection.fromPosition(TextPosition(
                                offset: widget.controller!.text.length - 1))) {
                          widget.controller!.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: widget.controller!.text.length));
                        }
                      }
                    }
                  },
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: 'YekanBakh-Regular',
                    fontSize: size.width * .03,
                    color: AppTheme.textFieldTextColor,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    enabled: widget.textEnable,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(
                      fontFamily: 'YekanBakh-Regular',
                      fontSize: size.width * .0275,
                      color: AppTheme.textFieldTextColor,
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(
                      color: Color(0xFF979797),
                      fontSize: 12.0,
                      fontFamily: 'YekanBakh-Regular',
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: size.width * .02,
                      vertical: size.height * .01,
                    ),
                  ),
                ),
              ),
              if (widget.isPassword)
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      setState(() {
                        isPasswordShown = !isPasswordShown;
                      });
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.all(CustomTextField.height / 4.5),
                      width: CustomTextField.height,
                      height: CustomTextField.height,
                      child: CustomSvgWidget(
                        isPasswordShown
                            ? 'assets/authentication/close_eye.svg'
                            : 'assets/authentication/open_eye.svg',
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * .005,
        ),
        if (widget.subChild != null) widget.subChild!,
      ],
    );
  }
}
