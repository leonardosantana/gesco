import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesco/controller/ticket_controller.dart';
import 'package:gesco/models/build.dart';
import 'package:gesco/models/ticket.dart';
import 'package:gesco/ui/ticket_tile.dart';

import 'app_header.dart';

class DetailedBuild extends StatefulWidget {
  Build build;
  bool isSelected = true;

  List<Ticket> tickects = TicketController.getTickets();

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
                                        Text(widget.build.phase),
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
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      /*Container(
                          height: 350,
                          child: ListView.builder(
                            itemCount: tickects.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  TicketTile(
                                    tileColor: tickects[index].color,
                                  ),
                                ],
                              );
                            },
                          ),
                      ),*/
                      ListView.builder(
                        itemCount: widget.tickects.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              TicketTile(ticket: widget.tickects[index])
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
