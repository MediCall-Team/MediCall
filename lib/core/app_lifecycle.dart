import 'dart:async';

class AppLifecycle {
  static final AppLifecycle _instance = AppLifecycle._internal();

  factory AppLifecycle() => _instance;

  AppLifecycle._internal();

  final StreamController<void> _resumeController =
      StreamController<void>.broadcast();

  Stream<void> get onResume => _resumeController.stream;

  void notifyResume() {
    _resumeController.add(null);
  }

  void dispose() {
    _resumeController.close();
  }
}