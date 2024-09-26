import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension InitProvider on BuildContext {
  void initProvider<T>(Future<void> Function(T provider) method) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await method(read<T>());
    });
  }
}