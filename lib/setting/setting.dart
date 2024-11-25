import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manger_app/app/view/cubit/app_cubit.dart';
import 'package:task_manger_app/setting/view/widgets.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SettingSection(
            sectionTitle: 'Pref',
            tiles: [
              SettingTile(
                  prefixIcon: Icons.room_preferences,
                  title: 'Theme',
                  desc: 'Change Your Theme',
                  suffixOnPressed: () {
                    context.push('/setting/theme');
                  },
                  suffixIcon: Icons.arrow_forward_ios_outlined,),
            ],
          ),
          SettingSection(
            sectionTitle: 'Profile',
            tiles: [
              SettingTile(
                  prefixIcon: Icons.person,
                  title: 'Profile',
                  desc: 'Logout',
                  suffixOnPressed: () {
                    context.read<AppCubit>().logOut();
                  },
                  suffixIcon: Icons.logout,),
            ],
          ),
        ],
      ),
    );
  }
}
