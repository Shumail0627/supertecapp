import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final int? maxline;
  final Color? color;
  final double? size;
  final FontWeight? fweight;
  final TextStyle? style;
  const TextComponent(
      {super.key,
      required this.text,
      this.textAlign,
      this.maxline,
      this.color,
      this.size,
      this.fweight,
      this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      textScaler: const TextScaler.linear(1),
      maxLines: maxline ?? 6,
      style: style ??
          TextStyle(color: color, fontSize: size ?? 15, fontWeight: fweight),
      overflow: TextOverflow.ellipsis,
    );
  }
}
