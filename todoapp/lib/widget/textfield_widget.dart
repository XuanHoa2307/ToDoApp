import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.maxLines,
    required this.txtController
  });

  final String hintText;
  final int maxLines;
  final TextEditingController txtController;
  @override
  State<TextFieldWidget> createState() => _TextFieldState();
  
}
  class _TextFieldState extends State<TextFieldWidget> {
    @override
    Widget build(BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          ),
          
        child: TextField(
          controller: widget.txtController,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: widget.hintText
          ),
          
        )
        );
    }
  }