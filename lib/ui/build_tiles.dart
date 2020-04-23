import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesco/models/build.dart';

import 'detailed_build.dart';

class BuildTile extends StatefulWidget {

  Build build;

  BuildTile({@required this.build});

  @override
  _BuildTileState createState() => _BuildTileState();
}

class _BuildTileState extends State<BuildTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        elevation: 5.0,
        child: Container(
          width: 140.0,
          color: widget.build.color.withOpacity(0.5),
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DetailedBuild(build: widget.build)));
            },
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[
              Container(
                  height: 120,
                  color: Colors.white,
                  child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.build.buildImage)
                  )
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.build.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(widget.build.cust.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 14.0,
                        )),
                    Text(widget.build.progress.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 14.0,
                        )),
                    Text(widget.build.phase,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 14.0,
                        )),
                  ],
                ),
              ),
            ],
          ),
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
}

