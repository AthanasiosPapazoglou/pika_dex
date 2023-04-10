import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pika_dex/themes/app_themes.dart';

isLightThemeActive() => SchedulerBinding.instance.window.platformBrightness == Brightness.light;

setThemePrimary() => isLightThemeActive() ? AppThemes.lightTheme.primaryColor : AppThemes.darkTheme.primaryColor;
setThemeBackground() => isLightThemeActive() ? AppThemes.lightTheme.backgroundColor : AppThemes.darkTheme.backgroundColor;


