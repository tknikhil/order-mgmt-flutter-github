import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:order_mgmt_flutter/src/service/service.dart';
import 'package:order_mgmt_flutter/src/presentation/presentation.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("Drawer");
    }
    return Drawer(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xfffd4af37),
        child: SafeArea(
          child: Column(
            children:  [
               InfoCard(name:LoginService.loginval.userName.toString()),
            Padding(
              padding: const EdgeInsets.only(left: 24,top: 32),
              child: Text("Browser".toUpperCase(),style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.brown)),
            ),
              const SideMenuTile()
            ],
          ),
        ),
      ),
    );
  }
}




