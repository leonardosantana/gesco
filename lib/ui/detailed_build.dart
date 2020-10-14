import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Leonardo%20Santana/IdeaProjects/gesco/lib/getx_app/build/build_model.dart';
import 'package:gesco/app/order/new_order/new_order_page.dart';
import 'package:gesco/app/order/order_bloc.dart';
import 'package:gesco/models/order.dart';
import 'package:gesco/ui/order_tile.dart';

import 'app_header.dart';
import 'common_styles.dart';

class DetailedBuild extends StatefulWidget {
  Build build;
  bool isSelected = true;
  OrderBloc bloc;

  DetailedBuild({@required this.build, @required this.bloc}) {
    bloc.getOrdersByBuild(build);
    bloc.getOrders();
  }

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
                                        Text(widget.build.phase == null
                                            ? ''
                                            : widget.build.phase),
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
                                    builder: (context) => NewOrderPage(
                                        build: widget.build,
                                        bloc: widget.bloc)));
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
                      StreamBuilder(
                        stream: widget.bloc.buildOrdersStream,
                        builder: (context, ordersSnap) {
                          if (ordersSnap.connectionState !=
                              ConnectionState.active) return SizedBox();
                          List<Order> orders = ordersSnap.data;
                          return ListView.builder(
                            itemCount: orders == null ? 0 : orders.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  buildOrderTile(orders[index])
                                ],
                              );
                            },
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

  OrderTile buildOrderTile(Order order) {
    if (order.documentId() == null) return OrderTile(ticket: order);
    return OrderTile(orderPath: 'build/${widget.build.documentId()}/orders/${order.documentId()}');
  }
}
