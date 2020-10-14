import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Leonardo%20Santana/IdeaProjects/gesco/lib/getx_app/build/build_model.dart';
import 'package:gesco/controller/product_controller.dart';
import 'package:gesco/controller/user_controller.dart';
import 'package:gesco/models/item.dart';
import 'package:gesco/models/order.dart';
import 'package:gesco/models/product.dart';
import 'package:gesco/ui/common_styles.dart';
import 'package:gesco/ui/detailed_order.dart';

import 'app_header.dart';

class NewOrder extends StatefulWidget {
  Build build;

  Order order;

  List<Product> products = null;//ProductController.getProducts();

  List<Product> filteredList = null;//ProductController.getProducts();

  NewOrder({@required this.build, this.order}){
    if(this.order == null) {
      order = Order(
          quantity: 0,
          color: Colors.blue,
          category: '',
          cust: 0,
          //id: build.orders.length + 1,
          items: List<Item>());
    }
  }

  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  final TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Container(
      child: Material(
        elevation: 8,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: ListView(
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
                      SizedBox(
                        height: 10.0,
                      ),
                      Text('Escolha um\nproduto',
                          style: CommonStyles.SectionTextStyle()),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(Icons.search),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            width: 150,
                            height: 30,
                            child: TextField(
                              onChanged: (text) {
                                setState(() {
                                  widget.filteredList = null;/*ProductController
                                          .getProducts()
                                      .where((item) => item.name.contains(text))
                                      .toList();*/
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                          itemCount: widget.filteredList.length > 50
                              ? 50
                              : widget.filteredList.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.lightBlueAccent.withOpacity(0.4),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(
                                  onPressed: () {
                                    return showDialog(
                                        context: context,
                                        builder: (_) =>
                                            buildAlertDialog(_formKey, index));
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            widget.filteredList[index].name,
                                            style: CommonStyles.TileTextStyle(
                                                size: 18),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AlertDialog buildAlertDialog(GlobalKey<FormState> _formKey, int index) {
    final TextEditingController myController = TextEditingController();

    return AlertDialog(
      content: Container(
        height: 150.0,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                controller: myController,
                decoration: const InputDecoration(
                  hintText: 'Quantidade',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Entre um valor válido';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        widget.order.items.add(Item(
                            product: widget.filteredList[index],
                            quantity: int.parse(myController.text)));
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailedOrder(
                                    build: widget.build,
                                    orderPath: 'build/${widget.build.documentId()}/orders/${widget.order.documentId()}',
                                )));
                      });
                    }
                  },
                  child: Text('Confirmar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
