import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:order_mgmt_flutter/src/cubit/cubit.dart';
import 'package:order_mgmt_flutter/src/presentation/presentation.dart';
import 'package:order_mgmt_flutter/src/service/service.dart';

import 'package:provider/provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var orderSummeryService=OrderSummeryService();
  var addItemService=AddItemService();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent),
  );
  //fix the screen orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  //MultiProvider for more than one cubit
  runApp(MultiProvider(
    providers: [
      Provider(create: (_)=>OrderService()),
      Provider(create: (_)=>OrderSummeryCubit(orderSummeryService)),
      Provider(create: (_)=>ItemNameCubit(addItemService))
    ],
    child:const MaterialApp(
      debugShowCheckedModeBanner: false,
       home: Login(),
    ),
  ));
}
