import 'package:flutter/cupertino.dart';

class TapOutSideToUnFocus extends StatelessWidget {
  TapOutSideToUnFocus({Key? key, this.child}) : super(key: key);
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
