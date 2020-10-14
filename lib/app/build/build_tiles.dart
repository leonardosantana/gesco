import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Leonardo%20Santana/IdeaProjects/gesco/lib/getx_app/build/build_model.dart';
import 'package:gesco/app/build/new_build/new_build_page.dart';
import 'package:gesco/app/order/order_bloc.dart';
import 'package:gesco/ui/common_styles.dart';
import 'package:gesco/ui/menu_page.dart';

import '../../ui/detailed_build.dart';
import 'build_bloc.dart';

class BuildTile extends StatefulWidget {
  Build build;
  BuildBloc bloc;
  OrderBloc orderBloc;

  BuildTile({@required this.build, @required this.bloc, @required this.orderBloc});

  @override
  _BuildTileState createState() => _BuildTileState();
}

class _BuildTileState extends State<BuildTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      //color: Colors.white,
      elevation: 5.0,
      child: Container(
        width: 140.0,
        color: widget.build == null
            ? Colors.blueAccent.withOpacity(0.4)
            : widget.build.color.withOpacity(0.5),
        child: InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => widget.build == null
                        ? NewBuildPage(bloc: widget.bloc)
                        : DetailedBuild(build: widget.build, bloc: widget.orderBloc)));
          },
          child: widget.build == null ? buildEmptyTile() : buildDetailed(),
        ),
      ),
    );
    /*return Container(
      padding: EdgeInsets.all(10.0),
      width: 150,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: widget.tileColor.withOpacity(0.4),
        image: DecorationImage(
          image: NetworkImage(widget.buildImage),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 18.0,
            ),
          ),
          Text(widget.cust.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 14.0,
              )),
          Text(widget.progress.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 14.0,
              )),
          Text(widget.phase,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 14.0,
              )),
        ],
      ),
    );*/
  }

  Column buildEmptyTile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          height: 120,
          child: Column(
            children: <Widget>[
              Container(
                width: 70,
                height: 70,
                child: CircleAvatar(
                  child: Icon(
                    Icons.add,
                    size: 70,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Incluir obra',
                style: CommonStyles.TileTextStyle(),
              )
            ],
          ),
        ),
      ],
    );
  }

  Column buildDetailed() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 120,
          child: Image(
            fit: BoxFit.fill,
            image: NetworkImage(widget.build.buildImage),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.build.name,
                style: CommonStyles.TileTextStyle(size: 16.0),
              ),
              Text(
                widget.build.cust.toString(),
                style: CommonStyles.TileTextStyle(),
              ),
              Text(
                widget.build.progress.toString(),
                style: CommonStyles.TileTextStyle(),
              ),
              Text(widget.build.phase==null?'':widget.build.phase, style: CommonStyles.TileTextStyle()),
            ],
          ),
        ),
      ],
    );
  }
}
