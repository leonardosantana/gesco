import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesco/controller/build_controller.dart';
import 'package:gesco/models/build.dart';
import 'package:gesco/models/order.dart';
import 'package:gesco/ui/build_tiles.dart';
import 'package:gesco/ui/order_tile.dart';

import 'app_header.dart';
import 'common_styles.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  bool isSelected = true;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double screenWidth;
  double screenHeight;

  @override
  Widget build(BuildContext context) {
    Future<List<Build>> buildings = new BuildController().getBuilding();
    List<Order> tickects = List<Order>();

    /*buildings.forEach((item) {
      if (item.orders != null && item.orders.length > 0)
        tickects.addAll(item.orders);
    });*/

    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Stack(
      children: <Widget>[
        Container(
          child: AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            top: widget.isSelected ? 0 : 0.2 * screenHeight,
            bottom: widget.isSelected ? 0 : 0.2 * screenWidth,
            left: widget.isSelected ? 0 : 0.6 * screenWidth,
            right: widget.isSelected ? 0 : -0.4 * screenWidth,
            child: Container(
              child: Material(
                elevation: 8,
                child: SafeArea(
                    child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                widget.isSelected = !widget.isSelected;
                              });
                            },
                            child: AppHeader(
                              isMainPage: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.search),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'Buscar',
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(5),
                          scrollDirection: Axis.vertical,
                          children: <Widget>[
                            Text(
                              'Obras',
                              style: CommonStyles.SectionTextStyle(),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                                height: 220,
                                child: FutureBuilder(
                                  builder: (context, builderSnap){
                                    if(builderSnap.connectionState == ConnectionState.none && builderSnap.hasData == null)
                                      return BuildTile(build: null);
                                    return ListView.builder(
                                      itemCount: builderSnap.data.length + 1,
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return BuildTile(
                                            build: index == builderSnap.data.length
                                                ? null
                                                : builderSnap.data[index]);
                                      },
                                    );
                                  },
                                  future: buildings,
                                )),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'Últimas Solicitações',
                              style: CommonStyles.SectionTextStyle(),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            ListView.builder(
                              itemCount: tickects.length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    OrderTile(
                                      order: tickects[index],
                                      buildPage: true,
                                    )
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
