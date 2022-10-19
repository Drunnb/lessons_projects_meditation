import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  final loginTextConroller = TextEditingController();
  final passwordTextConroller = TextEditingController();
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;

  Future<void> auth(BuildContext context) async {}
}

class AuthProvider extends InheritedNotifier {
  final AuthModel model;
  const AuthProvider({
    super.key,
    required this.model,
    required Widget child,
  }) : super(
          notifier: model,
          child: child,
        );

  static AuthProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
  }

  static AuthProvider? read(BuildContext context) {
    final widget =
        context.getElementForInheritedWidgetOfExactType<AuthProvider>()?.widget;
    return widget is AuthProvider ? widget : null;
  }
}
