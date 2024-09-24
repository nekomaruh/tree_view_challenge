import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:tree_view_challenge/core/state/ui_state.dart';

class StateWrapper extends StatelessWidget {
  final UiState state;
  final Widget onLoad;
  final Function(String message) onError;
  final Function() onData;

  const StateWrapper({
    super.key,
    required this.state,
    required this.onLoad,
    required this.onError,
    required this.onData,
  });

  _build() {
    if (state.isLoading) {
      return onLoad;
    }
    if (state.data != null) {
      return onData();
    }
    if (state.error != null) {
      return onError(state.error!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (
        Widget child,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      child: _build(),
    );
  }
}
