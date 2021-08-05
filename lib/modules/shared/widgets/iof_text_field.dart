import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:screen_util_test/styling/colors.dart';

class IoFTextField extends StatefulWidget {
  final String label;
  final String labelSemantic;
  final bool markRequired;
  final String hint;
  final String hintSemantic;
  final Widget prefixIcon;
  final Widget suffix;
  final Widget suffixIcon;
  final String error;
  final String errorSemantic;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool isReadOnly;
  final bool dispatchFocusNotification;
  final bool shouldRequestFocus;
  final TextEditingController textController;
  final List<TextInputFormatter> inputFormatter;

  @override
  _IoFTextFieldState createState() => _IoFTextFieldState();

  IoFTextField({this.label = '', this.labelSemantic = '', this.markRequired = false,
    this.hint = '', this.hintSemantic = '', this.prefixIcon, this.suffix, this.suffixIcon,
    this.error = '', this.errorSemantic = '', this.keyboardType = TextInputType.text,
    this.obscureText = false, this.isReadOnly = false, this.inputFormatter,
    this.dispatchFocusNotification = false, this.shouldRequestFocus = false,
    @required this.textController
  });

}

class _IoFTextFieldState extends State<IoFTextField> {
  FocusNode _focus = new FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if(_focus.hasFocus != _isFocused) {
      setState(() {
        _isFocused = _focus.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(widget.shouldRequestFocus) {
      this._focus.requestFocus();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _getLabel(),
        SizedBox(height: 10.0),
        Neumorphic(
          padding: EdgeInsets.only(left: 14.0),
          style: NeumorphicStyle(
            color: Colors.white.withOpacity(0.4),
            border: _getBorder(),
            shadowDarkColor: neuroStart,
            shadowLightColor: neuroEnd,
            intensity: 2.0,
            depth: -3,
          ),
          child: TextField(
            focusNode: _focus,
            obscureText: widget.obscureText,
            controller: widget.textController,
            readOnly: widget.isReadOnly,
            decoration: InputDecoration(
              border: InputBorder.none,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: widget.hint,
              hintStyle: TextStyle(fontSize: 14.0),
              prefixIcon: widget.prefixIcon ?? null,
              suffix: widget.suffix ?? null,
              suffixIcon: widget.suffixIcon ?? null,
              contentPadding: widget.prefixIcon == null ? null : EdgeInsets.only(top: 16.0),
            ),
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatter ?? [],
            textAlignVertical: widget.suffixIcon == null ? null : TextAlignVertical.center,
          ),
        ),
        SizedBox(height: 10.0),
        widget.error.isEmpty ? Container() : Text(
          widget.error,
          style: TextStyle(
            color: stmRed,
            fontSize: 12.0
          ),
        ),
      ],
    );
  }

  Widget _getLabel() {
    if(widget.label.isEmpty) {
      return Container();
    } else if(widget.markRequired) {
      return RichText(
        text: TextSpan(
          text: "${widget.label} ",
          semanticsLabel: widget.labelSemantic,
          style: TextStyle(
            color: stmBlack,
            fontSize: 16.0
          ),
          children: <TextSpan>[
            TextSpan(
              text: "*",
              style: TextStyle(
                color: stmRed,
              ),
            ),
          ],
        ),
      );
    }
    else {
      return Text(
        widget.label,
        semanticsLabel: widget.labelSemantic,
        style: TextStyle(
          fontSize: 16.0,
          color: stmBlack
        ),
      );
    }
  }

  NeumorphicBorder _getBorder() {
    if(widget.error.isNotEmpty) {
      return NeumorphicBorder(
          color: stmRed,
          width: 1.0
      );
    } else if(_isFocused){
      return NeumorphicBorder(
          color: schucoGreen,
          width: 1.0
      );
    } else {
      return NeumorphicBorder.none();
    }
  }
}
