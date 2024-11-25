import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


class AppThemeCubit extends Cubit<ThemeMode> {
  AppThemeCubit() : super(ThemeMode.system);
  void darkTheme()=>emit(ThemeMode.dark);
  void lightTheme()=>emit(ThemeMode.light);
  void systemTheme()=>emit(ThemeMode.system);
}
