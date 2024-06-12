
import 'package:flutter/material.dart';

class Block extends StatelessWidget {
  const Block({
    Key? key,
    required this.label,
    this.textColor,
    this.fontSize,
    this.size,
  }) : super(key: key);

  final String label;
  final Color? textColor;
  final double? fontSize;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    final text = Text(
      label,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: textColor ?? Colors.white,
            fontSize: fontSize,
          ),
    );

    return Container(
      width: size?.width,
      height: size?.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        border: Border.all(
          color: Colors.white,
          width: 3.0,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      padding: const EdgeInsets.all(15),
      child: size == null ? text : FittedBox(child: text),
    );
  }
}
