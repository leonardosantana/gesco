import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesco/controller/order_controller.dart';
import 'package:gesco/getx_app/build/build_model.dart';
import 'package:gesco/getx_app/build/detailed_build/detailed_build_page.dart';
import 'package:gesco/getx_app/build/new_build/new_build_page.dart';
import 'package:gesco/getx_app/order/detailed_order/detailed_order_page.dart';
import 'package:gesco/getx_app/order/order_status_enum.dart';
import 'package:gesco/models/order.dart';
import 'package:gesco/ui/app_header.dart';
import 'package:gesco/ui/common_styles.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {

  HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;

    return Stack(
      children: <Widget>[
        Obx( (){
          return         Container(
            child: AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              top: controller.hideMenu.value ? 0 : 0.2 * screenHeight,
              bottom: controller.hideMenu.value ? 0 : 0.2 * screenWidth,
              left: controller.hideMenu.value ? 0 : 0.6 * screenWidth,
              right: controller.hideMenu.value ? 0 : -0.4 * screenWidth,
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
                            InkWell(
                              onTap: ( () => controller.changeSelectedMenu()),
                              child: Row(
                                children: <Widget>[
                                  AppHeader(
                                    isMainPage: true,
                                  ),
                                ],
                              ),
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
                                children: buildHomeScreen(),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  List<Widget> buildHomeScreen() {
    return <Widget>[
      Text(
        'Obras',
        style: CommonStyles.SectionTextStyle(),
      ),
      SizedBox(
        height: 10.0,
      ),
      Container(height: 220, child: buildsListView()),
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
      ordersListView()
    ];
  }

  Widget ordersListView() {
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

  Container buildsListView() {
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

  buildTile({Rx<Build> build}) {
    return Card(
      //color: Colors.white,
      elevation: 5.0,
      child: Container(
        width: 140.0,
        color: build == null || build.value.color == null
            ? Colors.blueAccent.withOpacity(0.4)
            : build.value.color.withOpacity(0.5),
        child: InkWell(
          onTap: () {
            build != null ?
              Get.to(DetailedBuildPage(buildObj: build.value,)):
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

  Column buildDetailed({Rx<Build> build}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 120,
          child: Stack(
            children: [
              Image(
                height: 120 ,
                width: 140,
                fit: BoxFit.cover,
                image: NetworkImage(build.value.buildImage),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(top: 5, right: 5),
                      child:
                    Text(controller.getUserBuildRole(build.value),),
                    )
                  ],
                ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    build.value.name,
                    style: CommonStyles.TileTextStyle(size: 16.0),
                  ),
                ],
              ),
              Obx(()=> Text(
                build.value.cust.toString(),
                style: CommonStyles.TileTextStyle(),
              )),
              Text(
                build.value.progress.toString(),
                style: CommonStyles.TileTextStyle(),
              ),
              Text(build.value.phase == null ? '' : build.value.phase,
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
        Get.reset();
        Get.to(DetailedOrderPage(orderPath: ticket.path));
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
                                ? '${ticket.buildName} #${ticket.orderNumber}'
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
                      Text('${DateFormat('d/M/y').format(DateTime.fromMillisecondsSinceEpoch(ticket.date.millisecondsSinceEpoch))}')
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
