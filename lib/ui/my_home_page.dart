import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesco/app/build/build_bloc.dart';
import 'package:gesco/app/build/build_model.dart';
import 'package:gesco/app/build/build_tiles.dart';
import 'package:gesco/app/order/order_bloc.dart';
import 'package:gesco/models/order.dart';

import 'app_header.dart';
import 'common_styles.dart';
import 'order_tile.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  bool isSelected = true;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  BuildBloc bloc = BuildBloc();
  OrderBloc blocOrders = OrderBloc();

  double screenWidth;
  double screenHeight;

  @override
  Widget build(BuildContext context) {

    bloc.getBuilding();
    blocOrders.getOrders();

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
                                child: StreamBuilder<List<Build>>(
                                  stream: bloc.buildsStream,
                                  builder: (context, builderSnap){
                                    if(builderSnap.connectionState != ConnectionState.active )
                                      return SizedBox();
                                    List<Build> builds = builderSnap.data;
                                    if(builds == null)
                                      builds = List<Build>();
                                    return ListView.builder(
                                      itemCount: builds.length + 1,
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return BuildTile(
                                            build: index == builds.length
                                                ? null
                                                : builds[index],
                                          bloc: bloc
                                        );
                                      },
                                    );
                                  },
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
                            StreamBuilder(
                              stream: blocOrders.ordersStream,
                              builder: (context, ordersSnap){
                                if(ordersSnap.connectionState != ConnectionState.active )
                                  return SizedBox();

                                List<Order> tickects = ordersSnap.data;

                                return ListView.builder(
                                  itemCount: tickects.length,
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        OrderTile(ticket: tickects[index],)
                                      ],
                                    );
                                  },
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
