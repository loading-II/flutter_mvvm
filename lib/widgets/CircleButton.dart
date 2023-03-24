import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CircleButton extends StatelessWidget {
  late Widget _mChild;
  late VoidCallback _mCallBack;

  CircleButton(Widget child, VoidCallback mCallback, {super.key}) {
    _mChild = child;
    _mCallBack = mCallback;
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor.withAlpha(255);
    return Container(
        width: double.infinity,
        height: 55,
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: CupertinoButton(
          padding: const EdgeInsets.all(0),
          color: color,
          disabledColor: color,
          borderRadius: BorderRadius.circular(20),
          pressedOpacity: 0.5,
          onPressed: _mCallBack,
          child: _mChild,
        ));
  }
}
