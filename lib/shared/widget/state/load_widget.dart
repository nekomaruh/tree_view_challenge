import 'package:flutter/material.dart';

class LoadWidget extends StatelessWidget {
  const LoadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      key: UniqueKey(),
      child: const CircularProgressIndicator(),
    );
  }
}
