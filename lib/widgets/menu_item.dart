import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData mIcon;
  final Color iconColor;
  final String title;
  final Function onClick;

  const MenuItem({
    Key? key,
    required this.mIcon,
    required this.iconColor,
    required this.title,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        mIcon,
        color: iconColor,
      ),
      title: Text(title),
      onTap: () {
        onClick();
      },
    );
  }
}
