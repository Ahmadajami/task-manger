import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeScreenContents extends StatefulWidget {
  const ThemeScreenContents({super.key});

  @override
  State<ThemeScreenContents> createState() => _ThemeScreenContentsState();
}

class _ThemeScreenContentsState extends State<ThemeScreenContents> {
  @override
  Widget build(BuildContext context) {
    const List<ThemeMode> themes = ThemeMode.values;
    final ThemeMode theme = context
        .watch<AppThemeCubit>()
        .state;
    return ListView.separated(
      itemCount: themes.length,
      itemBuilder: (context, index) =>
          ListTile(
            title: Text(themes[index].name),
            leading: Radio<ThemeMode>(value: themes[index],
              groupValue: theme,
              onChanged: (value) => _onChange(context, value!),),
          ),
      separatorBuilder: (context, index) => const Divider(),

    );
  }

  void _onChange(BuildContext context, ThemeMode theme) {
    switch (theme) {
      case ThemeMode.system:
        context.read<AppThemeCubit>().systemTheme();
      case ThemeMode.dark:
        context.read<AppThemeCubit>().darkTheme();
      case ThemeMode.light:
        context.read<AppThemeCubit>().lightTheme();
    }
  }
}


class ThemeChangeScreen extends StatefulWidget {
  const ThemeChangeScreen({super.key});

  @override
  State<ThemeChangeScreen> createState() => _ThemeChangeScreenState();
}

class _ThemeChangeScreenState extends State<ThemeChangeScreen> {
  @override
  Widget build(BuildContext context) {
    return const ThemeScreenContents();
  }


}
