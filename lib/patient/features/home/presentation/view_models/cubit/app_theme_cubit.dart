import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:grad_project/core/helper/chach_helper.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeLight()) {
    loadTheme(); // 🔥 أول ما الكيوبت يشتغل
  }

  void loadTheme() {
    bool isDark = CacheHelper.getData(key: "isDark") ?? false;

    if (isDark) {
      emit(AppThemeDark());
    } else {
      emit(AppThemeLight());
    }
  }

  void toggleTheme() {
    if (state is AppThemeLight) {
      CacheHelper.saveData(key: "isDark", value: true); // 🔥 حفظ
      emit(AppThemeDark());
    } else {
      CacheHelper.saveData(key: "isDark", value: false); // 🔥 حفظ
      emit(AppThemeLight());
    }
  }

  bool get isDark => state is AppThemeDark;
}