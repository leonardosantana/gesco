import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesco/controller/order_controller.dart';
import 'package:gesco/models/build.dart';
import 'package:gesco/models/order.dart';
import 'package:gesco/ui/order_tile.dart';

import 'app_header.dart';
import 'common_styles.dart';
import 'new_order.dart';

class DetailedBuild extends StatefulWidget {
  Build build;
  bool isSelected = true;

  DetailedBuild({@required this.build});

  @override
  _DetailedBuildState createState() => _DetailedBuildState();
}

class _DetailedBuildState extends State<DetailedBuild> {
  double screenWidth;
  double screenHeight;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Container(
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
                      Navigator.pop(context);
                    },
                    child: AppHeader(isMainPage: false),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(5),
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Card(
                        elevation: 5.0,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                //width: 100.0,
                                //height: 100.0,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 100.0,
                                      height: 100.0,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            widget.build.buildImage),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          widget.build.name,
                                          style: TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(widget.build.cust.toString()),
                                        Text(widget.build.progress.toString()),
                                        Text(widget.build.phase==null?'':widget.build.phase),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                        ),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NewOrder(build: widget.build)));
                          },
                          child: Text(
                            'Nova solicitação',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Últimas\nSolicitações',
                        style: CommonStyles.SectionTextStyle(),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ListView.builder(
                        itemCount: widget.build.orders==null?0: widget.build.orders.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              OrderTile(order: widget.build.orders[index], buildPage: false,)
                            ],
                          );
                        },
                      ),
                    ]),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

