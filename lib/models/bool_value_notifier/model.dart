import 'package:flutter/material.dart';

class BoolValueNotifier extends ValueNotifier<bool> {
  bool _mounted = true;

  BoolValueNotifier(super.value);

  bool get mounted => _mounted;

  bool get notMounted => !_mounted;

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  void setTrue() {
    if(value || notMounted) return;
    value = true;
  }

  void setFalse() {
    if(!value || notMounted) return;
    value = false;
  }
}