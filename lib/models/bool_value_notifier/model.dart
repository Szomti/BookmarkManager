import 'package:flutter/material.dart';

class BoolValueNotifier extends ValueNotifier<bool> {
  bool _mounted = true;

  BoolValueNotifier(super.value);

  bool get mounter => _mounted;

  bool get notMounter => !_mounted;

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  void setTrue() {
    if(value || notMounter) return;
    value = true;
  }

  void setFalse() {
    if(!value || notMounter) return;
    value = false;
  }
}