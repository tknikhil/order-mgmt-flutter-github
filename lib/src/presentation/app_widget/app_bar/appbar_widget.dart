import 'package:flutter/material.dart';
import 'package:order_mgmt_flutter/src/service/service.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  AppBarWidget({Key? key, required this.cdate, required this.builder})
      : super(key: key);

  final String cdate;
  Builder builder;

  @override
  Widget build(BuildContext context) {
    return buildAppBar();
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xfffd4af37),
      // leading: buildBuilder(),
      leading: builder,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //menu
            Container(
              padding: const EdgeInsets.all(12),
            ),
            Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi ${LoginService.loginval.userName.toString()}',
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    cdate,
                    style: const TextStyle(
                        color: Color(0xffffbf1de),
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.yellow,
                    maxRadius: 25.0,
                    child: Icon(
                      Icons.account_circle_outlined,
                      color: Colors.brown,
                      size: 50,
                    ),
                  )
                ],
              ),
            ])
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
