import 'package:flutter/material.dart';

class OverlayWidget extends StatelessWidget {
  final Function onTap;
  final Widget child;

  const OverlayWidget({
    Key key,
    this.onTap,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
            minWidth: constraints.maxWidth,
          ),
          child: GestureDetector(
            onTap: () => null, //onTap,
            child: Material(
              color: Colors.black.withOpacity(.8),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 150,
                  ),
                  child: Center(child: child),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
