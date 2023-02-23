import 'package:flutter/material.dart';

import 'package:order_mgmt_flutter/src/presentation/presentation.dart';
class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: Drawer(
        child: SideMenu(),
      ),
    );
  }
}