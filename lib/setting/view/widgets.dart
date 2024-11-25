import 'package:flutter/material.dart';

class SettingSection extends StatelessWidget {
  const SettingSection({
    required this.tiles, required this.sectionTitle, super.key,
  });
  final String sectionTitle;
  final List<SettingTile> tiles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              sectionTitle,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          for (final tile in tiles)
            Padding(
              padding: const EdgeInsets.all(8),
              child: tile,
            ),
        ],
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  const SettingTile({
    required this.prefixIcon,
    required this.title,
    required this.desc,
    required this.suffixOnPressed,
    required this.suffixIcon,
    super.key,
  });

  final IconData prefixIcon;
  final String title;
  final String desc;
  final void Function()? suffixOnPressed;
  final IconData suffixIcon;

  @override
  Widget build(BuildContext context) {
    final themeMode = Theme.of(context).brightness;

    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: themeMode == Brightness.light
            ? Colors.grey.shade200 : Colors.transparent,
      ),
      padding: const EdgeInsets.all(8),
      height: height * 0.10,
      width: width,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(prefixIcon),
          ),
          Expanded(
            flex: 2,
            child: Text.rich(
              TextSpan(
                text: title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    children: [
                      TextSpan(
                        text: ' \n $desc',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: suffixOnPressed,
            icon: Icon(
              suffixIcon,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
    );
  }
}
