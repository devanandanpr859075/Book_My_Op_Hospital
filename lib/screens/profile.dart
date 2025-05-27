import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../Widgets/ProfilemenuWidget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(LineAwesomeIcons.angle_left_solid),
        ),
        title: Center(
            child: Text(
              "Profile",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
        actions: [
          // IconButton(
          //     onPressed: () {},
          //     icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            SizedBox(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: const Image(
                  image: AssetImage("lib/Asset_Images/img_1.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Coding with t",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("anaghaAdmin@gmail.com"),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context){return ProfileEditPage();}));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.black),
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            Divider(
              color: Colors.transparent,
            ),
            SizedBox(
              height: 10,
            ),
            ProfileMenuWidget(
              title: 'Settings',
              icon: LineAwesomeIcons.cog_solid,
              onpress: () {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => booking_page()));
              },
            ),
            ProfileMenuWidget(
              title: 'Share to a friend',
              iconcolor: Colors.black,
              icon: LineAwesomeIcons.share_square_solid,
              onpress: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => booking_page()));
              },
            ),
            ProfileMenuWidget(
              title: 'Contact Us',
              icon: LineAwesomeIcons.phone_alt_solid,
              onpress: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Categories()));
                },
            ),
            ProfileMenuWidget(
              title: 'Rate Us',
              icon: LineAwesomeIcons.star,
              onpress: () {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => ));
              //
              },
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                // sigout();
              },
              leading: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.withOpacity(0.1)),
                child: Icon(
                  Icons.login,
                  color: Colors.black,
                ),
              ),
              title: Text(
                "log out",
                style:
                TextStyle(color: Colors.red, fontWeight: FontWeight.w500,),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ]),
        ),
      ),
    );
  }
}
