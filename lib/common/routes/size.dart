import 'package:flutter/material.dart';

class SizeRoute extends PageRouteBuilder {
  SizeRoute({required this.page})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              animation = CurvedAnimation(
                  curve: Curves.fastOutSlowIn, parent: animation);

              return Align(
                child: SizeTransition(
                  sizeFactor: animation,
                  child: child,
                ),
              );
            });

  @override
  Duration get transitionDuration => const Duration(milliseconds: 1000);
  final Widget page;
}
