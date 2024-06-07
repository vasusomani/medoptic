import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyboardVisibilityBuilder extends StatefulWidget {
  final Widget child;
  final void Function(bool isVisible) onVisibilityChange;

  KeyboardVisibilityBuilder({
    required this.child,
    required this.onVisibilityChange,
    super.key,
  });

  @override
  State<KeyboardVisibilityBuilder> createState() =>
      _KeyboardVisibilityBuilderState();
}

class _KeyboardVisibilityBuilderState extends State<KeyboardVisibilityBuilder>
    with WidgetsBindingObserver {
  var _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
