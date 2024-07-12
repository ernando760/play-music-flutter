import 'package:flutter/material.dart';

class BasePlayMusicBuilderWidget<T> extends StatelessWidget {
  const BasePlayMusicBuilderWidget({
    super.key,
    this.onLoading,
    this.onSuccess,
    this.onError,
  });

  final Widget Function()? onLoading;
  final Widget Function(T data)? onSuccess;
  final Widget Function()? onError;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
