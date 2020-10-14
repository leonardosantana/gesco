import 'package:flutter/material.dart';
import 'package:gesco/controller/order_controller.dart';
import 'package:gesco/getx_app/build/build_model.dart';
import 'package:gesco/getx_app/build/detailed_build/detailed_build_page.dart';
import 'package:gesco/getx_app/build/new_build/new_build_page.dart';
import 'package:gesco/getx_app/order/order_status_enum.dart';
import 'package:gesco/models/order.dart';
import 'package:gesco/ui/app_header.dart';
import 'package:gesco/ui/common_styles.dart';
import 'package:get/get.dart';

import 'home_page_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomePageController controller = Get.put(HomePageController());
    bool isSelected = true;

    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;

    return Stack(
      children: <Widget>[
        Container(
          child: AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            top: isSelected ? 0 : 0.2 * screenHeight,
            bottom: isSelected ? 0 : 0.2 * screenWidth,
            left: isSelected ? 0 : 0.6 * screenWidth,
            right: isSelected ? 0 : -0.4 * screenWidth,
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
                          AppHeader(
                            isMainPage: true,
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
                          children: buildHomeScreen(controller),
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

  List<Widget> buildHomeScreen(HomePageController controller) {
    return <Widget>[
      Text(
        'Obras',
        style: CommonStyles.SectionTextStyle(),
      ),
      SizedBox(
        height: 10.0,
      ),
      Container(height: 220, child: buildsListView(controller)),
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
      ordersListView(controller)
    ];
  }

  Widget ordersListView(HomePageController controller) {
    return Obx(() => ListView.builder(
          itemCount: controller.orders.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[orderTile(ticket: controller.orders[index])],
            );
          },
        ));
  }

  Container buildsListView(HomePageController controller) {
    return Container(
      child: Obx(() => ListView.builder(
            itemCount: controller.builds.length + 1,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return buildTile(
                  build: index == controller.builds.length
                      ? null
                      : controller.builds[index]);
            },
          )),
    );
  }

  buildTile({Build build}) {
    return Card(
      //color: Colors.white,
      elevation: 5.0,
      child: Container(
        width: 140.0,
        color: build == null || build.color == null
            ? Colors.blueAccent.withOpacity(0.4)
            : build.color.withOpacity(0.5),
        child: InkWell(
          onTap: () {
            build != null ?
              Get.to(DetailedBuildPage(buildObj: build,)):
              Get.to(NewBuildPage());
          },
          child: build == null ? buildEmptyTile() : buildDetailed(build: build),
        ),
      ),
    );
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

  Column buildDetailed({Build build}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 120,
          child: Image(
            fit: BoxFit.fill,
            image: NetworkImage(build.buildImage),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                build.name,
                style: CommonStyles.TileTextStyle(size: 16.0),
              ),
              Text(
                build.cust.toString(),
                style: CommonStyles.TileTextStyle(),
              ),
              Text(
                build.progress.toString(),
                style: CommonStyles.TileTextStyle(),
              ),
              Text(build.phase == null ? '' : build.phase,
                  style: CommonStyles.TileTextStyle()),
            ],
          ),
        ),
      ],
    );
  }

  orderTile({Order ticket}) {
    return InkWell(
      onTap: () {
        //Get.to(DetailedOrder( ticket));
      },
      child: Card(
        elevation: 5.0,
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(5.0),
          height: 60.0,
          //color: getColorFromCategory(widget.category).withOpacity(0.5),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      //width: 120.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            ticket.orderNumber != null
                                ? 'obra ${ticket.buildName} ordem nº${ticket.orderNumber}'
                                : 'nova ordem',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: OrderStatus.getColorFromStatus(
                                    OrderStatusEnum.values[ticket.status]),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 5),
                                child: Text(OrderStatus.getStatusFromEnum(OrderStatusEnum.values[ticket.status])),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('Itens: ${ticket.quantity}'),
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
