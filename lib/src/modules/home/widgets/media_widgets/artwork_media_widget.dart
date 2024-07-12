import 'dart:typed_data';

import 'package:flutter/material.dart';

class ArtworkMediaWidget extends StatelessWidget {
  const ArtworkMediaWidget(
      {super.key,
      required this.art,
      this.width,
      this.height,
      this.boxFit,
      this.cacheHeight,
      this.cacheWidth,
      this.borderRadius});
  final Uint8List art;
  final double? width;
  final BorderRadius? borderRadius;
  final double? height;
  final int? cacheHeight;
  final int? cacheWidth;
  final BoxFit? boxFit;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius:
            borderRadius ?? const BorderRadius.all(Radius.circular(10)),
        child: Image.memory(
          art,
          width: width,
          height: height,
          cacheHeight: cacheHeight,
          cacheWidth: cacheWidth,
          fit: boxFit,
        ));
  }
}
