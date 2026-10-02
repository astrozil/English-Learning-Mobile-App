import 'package:flutter/material.dart';

class RichTextWidget extends StatefulWidget {
  final String firstText;
  final String secondText;

  const RichTextWidget({
    super.key,
    required this.firstText,
    required this.secondText,
  });

  @override
  State<RichTextWidget> createState() => _RichTextWidgetState();
}

class _RichTextWidgetState extends State<RichTextWidget> {
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: widget.firstText,
          style: const TextStyle(color: Colors.black, height: 2)),
      const TextSpan(
          text: " ________ ", style: TextStyle(color: Colors.black, height: 2)),
      TextSpan(
          text: widget.secondText.isEmpty ? "." : widget.secondText,
          style: const TextStyle(color: Colors.black, height: 2)),
    ]));
  }
}
