import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesco/models/item.dart';
import 'package:gesco/models/order.dart';

import 'app_header.dart';
import 'common_styles.dart';

class CheckItems extends StatefulWidget {
  Order order;

  List<Item> items;

  CheckItems({this.order}) {
    items = this.order.items;
  }

  @override
  _CheckItemsState createState() => _CheckItemsState();
}

class _CheckItemsState extends State<CheckItems> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    print(
        'A checar ${widget.items.where((item) => item.delivered == null).length}');
    print(
        'Checados ${widget.items.where((item) => item.delivered != null).length}');

    widget.items.forEach((item) => print(
        '${item.product.name} com ${item.delivered} para entregar ${item.quantity}'));

    widget.items.where((item) => item.delivered == null).forEach((item) => print(
        '----filtrado ${item.product.name} com ${item.delivered} para entregar ${item.quantity}'));

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
                      if (widget.items
                              .where((item) => item.delivered == null)
                              .length >
                          0)
                        Text(
                          'A checar',
                          style: CommonStyles.SectionTextStyle(),
                        ),
                      ListView.builder(
                        itemCount: widget.items
                            .where((item) => item.delivered == null)
                            .length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final item = widget.items
                              .where((item) => item.delivered == null)
                              .toList()[index];

                          return Card(
                            elevation: 5.0,
                            child: Container(
                              height: 60.0,
                              child: FlatButton(
                                onPressed: () {
                                  return showDialog(
                                      context: context,
                                      builder: (_) =>
                                          buildAlertDialog(_formKey, index));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      widget.items
                                          .where(
                                              (item) => item.delivered == null)
                                          .toList()[index]
                                          .product
                                          .name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Text(
                        'Checados',
                        style: CommonStyles.SectionTextStyle(),
                      ),
                      ListView.builder(
                        itemCount: widget.items
                            .where((item) => item.delivered != null)
                            .length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final item = widget.items
                              .where((item) => item.delivered != null)
                              .toList()[index];

                          return Card(
                            elevation: 5.0,
                            child: Dismissible(
                              background: Container(color: Colors.red),
                              key: Key(item.product.name),
                              onDismissed: (direction) {
                                // Remove the item from the data source.
                                setState(() {
                                  widget.items
                                      .where((item) => item.delivered != null)
                                      .toList()[index]
                                      .delivered = null;
                                });
                              },
                              child: Container(
                                color: item.quantity == item.delivered
                                    ? Colors.green
                                    : Colors.yellow,
                                height: 60.0,
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      item.product.name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                        'Pedido: ${item.quantity} entregue: ${item.delivered}')
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      if (widget.items
                              .where((item) => item.delivered == null)
                              .length ==
                          0)
                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.red,
                          ),
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                //widget.order.status = 'entregue';
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              'Finalizar Entrega',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                    ]),
              ),
            ],
          ),
        )),
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
                  hintText: 'Quantidade recebida',
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
                        widget.items
                            .where((item) => item.delivered == null)
                            .toList()[index]
                            .delivered = int.parse(myController.text);
                        Navigator.pop(context, true);
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
