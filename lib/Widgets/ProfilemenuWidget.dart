import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onpress,
    this.endicon = true,
    this.textcolor,
    this.iconcolor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onpress;
  final bool endicon;
  final Color? textcolor;
  final Color? iconcolor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onpress,
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.blue.withOpacity(0.1)),
        child:  Icon(icon,
          color: iconcolor,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(color: textcolor, fontWeight: FontWeight.w500),
      ),
      trailing: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1)),
        child: Icon(LineAwesomeIcons.angle_right_solid,),
      ),
    );
  }
}
