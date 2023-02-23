import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../model/login.dart';
import '../app_widget/app_widget.dart';
import '../presentation.dart';
import 'bottom_navigation_bar_page.dart';


class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // String? username=Login.userName.toString();
  @override
  Widget build(BuildContext context) {
    String cdate = DateFormat("dd-MM-yyyy").format(DateTime.now());
    final searchController=TextEditingController();
    final orderListView=OrderListView();
    return SizedBox(
      //takes host mobile complete screen size
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        //drawer
        drawer: const MenuDrawer(),
        //appbar
        appBar: AppBarWidget(cdate: cdate,builder: Builder(builder: (context) =>
                    IconButton(
                        icon: const Icon(Icons.menu),
                        color: Colors.brown,
                        onPressed: () => Scaffold.of(context).openDrawer()
                    ),
                )),
        backgroundColor: const Color(0xfffd4af37),
        body: RefreshIndicator(
          onRefresh: () {

            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (a, b, c) =>  BottomNavigationBarPage(),
                    transitionDuration: Duration(seconds: 0)));
            return Future.value(false);
          },
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value)=> OrderListViewState().runFilter2(value),
                        controller: searchController,
                        onTap: OrderListViewState().search(searchController),
                        style: TextStyle(
                          color: Palette.text,
                          fontSize: 20
                        ),
                        decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          hintStyle: const TextStyle(color: Color.fromRGBO(105, 105,105, 0.5),fontSize: 20),
                          labelStyle: const TextStyle(
                            fontSize: 20,),
                          filled: true,
                          fillColor: Colors.white70,
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                BorderRadius.all(Radius.circular(9
                                )
                                )
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      //  Search Bar
                      Container(
                        // decoration: BoxDecoration(
                        //     color: const Color(0xffffbf1de),
                        //     borderRadius: BorderRadius.circular(12)),
                        // padding: const EdgeInsets.all(10),

                        child: Row(
                          children:  [
                            // Icon(Icons.search, color: Colors.grey),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            // Text(
                            //   "Search",
                            //   style: TextStyle(fontSize: 20, color: Colors.grey),
                            // ),

                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                    child: Container(
                      color: const Color(0xffff0ead6),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(15.0),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //card
                              OrderDetailCardWidget(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
