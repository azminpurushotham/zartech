import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zartech/router.gr.dart';

late SharedPreferences prefs;
String userName = '', emailId = '', userId = '', image = '';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.green,
                            Colors.lightGreen,
                            Colors.greenAccent,
                          ]),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Container(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: Image.network(
                            image,
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(userName,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(emailId,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 10)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            title: InkWell(
              onTap: () async {
                await prefs.clear();
                await AutoRouter.of(context).push(LoginRoute());
              },
              child: const Text(
                'Log out',
                style: TextStyle(color: Colors.black38, fontSize: 15),
              ),
            ),
            leading: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('name')!;
    emailId = prefs.getString('email')!;
    userId = prefs.getString('userid')!;
    image = prefs.getString('image')!;
  }
}
