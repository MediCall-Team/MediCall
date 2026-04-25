import 'dart:async';

class AppLifecycle {
  static final AppLifecycle _instance = AppLifecycle._internal();

  factory AppLifecycle() => _instance;
   bool isForeground = true;

  AppLifecycle._internal();

  final StreamController<void> _resumeController =
      StreamController<void>.broadcast();

  Stream<void> get onResume => _resumeController.stream;

  void notifyResume() {
     isForeground = true;
    _resumeController.add(null);
  }
  
    void notifyPause() {
    isForeground = false;
  }

  void dispose() {
    _resumeController.close();
  }
}