import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

abstract class BasePlayMusicController<T> {
  T get value;

  @protected
  void updateValue(T newValue);

  void dispose();

  Future<void> lazyDispose();
}

abstract class BaseNotifierPlayMusicController<T>
    extends BasePlayMusicController<T> with ChangeNotifier {
  T _value;

  BaseNotifierPlayMusicController(this._value);

  @override
  T get value => _value;

  @override
  void updateValue(T newValue) {
    _value = newValue;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    dispose();
  }

  @override
  Future<void> lazyDispose() async {}
}

abstract class BaseStreamPlayMusicController<T>
    extends BasePlayMusicController<Stream<T>> {
  @protected
  final BehaviorSubject<T> behaviorSubject = BehaviorSubject<T>();

  @override
  Stream<T> get value => behaviorSubject.stream;

  @override
  void updateValue(Stream<T> newValue) {
    behaviorSubject.addStream(newValue);
  }

  @override
  void dispose() {}

  @override
  Future<void> lazyDispose() async {
    await behaviorSubject.close();
    log("Lazy dispose");
  }
}
