import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SideMenuTile extends StatelessWidget {
  const SideMenuTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(
            color: Colors.brown,
            height: 15,
          ),
        ),
        ListTile(
          leading: const SizedBox(
            height: 30,
            width: 30,
            child: Icon(
              Icons.logout,
              color: Colors.brown,
            ),
          ),
          title: const Text(
            "LogOut",
            style: TextStyle(
                color: Colors.brown, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else {
              exit(0);
            }
          },
        ),
      ],
    );
  }
}
