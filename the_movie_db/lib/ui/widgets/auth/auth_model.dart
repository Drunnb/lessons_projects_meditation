// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/api_client/api_client_exception.dart';
import 'package:the_movie_db/ui/navigation/main_navigation_actions.dart';

abstract class AuthViewModelLoginProvider {
  Future<void> login(String login, String password);
}

class AuthViewModel extends ChangeNotifier {
  final MainNavigationAction mainNavigationAction;
  final AuthViewModelLoginProvider loginProvider;

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;

  AuthViewModel(
      {required this.mainNavigationAction, required this.loginProvider});
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  bool _isValid(String login, String password) =>
      login.isNotEmpty && password.isNotEmpty;

  Future<String?> _login(String login, String password) async {
    try {
      await loginProvider.login(login, password);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          return 'Сервер не допуспен, проверьте подключение к интернету';

        case ApiClientExceptionType.auth:
          return 'Неправильный логин пароль!';

        case ApiClientExceptionType.other:
          return 'Произошла ошибка. Попробуйте еще раз';

        case ApiClientExceptionType.sessionExpired:
          return 'Сессия истекла. Обновите сессию';
      }
    } catch (e) {
      return 'Неизвестная ошибка, поторите попытку';
    }
    return null;
  }

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (!_isValid(login, password)) {
      _updateState('Заполните логин и пароль', false);
      return;
    }
    _updateState(null, true);

    _errorMessage = await _login(login, password);
    if (_errorMessage == null) {
      mainNavigationAction.resetNavigation(context);
    } else {
      _updateState(_errorMessage, false);
    }
  }

  void _updateState(String? errorMessage, bool isAuthProgress) {
    if (_errorMessage == errorMessage && _isAuthProgress == isAuthProgress) {
      return;
    }
    _errorMessage = errorMessage;
    _isAuthProgress = isAuthProgress;
    notifyListeners();
  }
}
