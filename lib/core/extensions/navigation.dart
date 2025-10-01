import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

extension NavigationExtension on BuildContext {
  void pushTo(String routeName) {
    push(routeName);
  }

  Future<void> pushWithExtra(String routeName, {Object? extra}) async {
    await push(routeName, extra: extra);
  }

  void pushWithReplacement(String routeName,{Object? extra}) {
    pushReplacement(routeName, extra: extra);
  }

  void pushToBase(String routeName) {
    go(routeName);
  }
}
