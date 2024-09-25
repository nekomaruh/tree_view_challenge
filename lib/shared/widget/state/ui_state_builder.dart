import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:tree_view_challenge/core/state/ui_state.dart';

class UiStateBuilder<T> extends StatefulWidget {
  final UiState<T> state;
  final Widget onLoad;
  final Widget Function(String message) onError;
  final Widget Function(T data) onData;
  final Widget noData;

  const UiStateBuilder({
    super.key,
    required this.state,
    required this.onLoad,
    required this.onError,
    required this.onData,
    required this.noData,
  });

  @override
  _UiStateBuilderState<T> createState() => _UiStateBuilderState<T>();
}

class _UiStateBuilderState<T> extends State<UiStateBuilder<T>> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _isInitialized = true);
    });
  }

  Widget _build() {
    if (!_isInitialized) {
      return SizedBox(key: UniqueKey());
    } else if (widget.state.isLoading) {
      return widget.onLoad;
    } else if (widget.state.data != null) {
      return widget.onData(widget.state.data as T);
    } else if (widget.state.error != null) {
      return widget.onError(widget.state.error!);
    } else {
      return widget.noData;
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
