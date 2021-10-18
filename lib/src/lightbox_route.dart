library lightbox;

import 'package:flutter/material.dart';

class LightBoxRoute extends PopupRoute {
  ///LightBoxRoute class creates the overlay with scale transition to show the LightBox
  LightBoxRoute({
    required this.builder,
    this.dismissible = true,
    this.label,
    this.color,
    RouteSettings? setting,
  }) : super(settings: setting);

  /// This function defines the widget to be build when navigate to the LightBoxRoute
  final WidgetBuilder builder;

  /// boolean to control if the LightBox can be dismiss or not
  final bool dismissible;

  /// barrier label
  final String? label;

  /// barrier colors
  final Color? color;

  @override
  Color? get barrierColor => color;

  @override
  bool get barrierDismissible => dismissible;

  @override
  String? get barrierLabel => label;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        ),
      ),
      child: child,
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);
}
