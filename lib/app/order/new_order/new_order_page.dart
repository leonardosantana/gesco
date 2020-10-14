import 'package:flutter/material.dart';
import 'file:///C:/Users/Leonardo%20Santana/IdeaProjects/gesco/lib/getx_app/build/build_model.dart';
import 'package:gesco/app/order/new_order/new_order_bloc.dart';
import 'package:gesco/app/order/order_bloc.dart';
import 'package:gesco/controller/product_controller.dart';
import 'package:gesco/getx_app/order/order_status_enum.dart';
import 'package:gesco/models/item.dart';
import 'package:gesco/models/order.dart';
import 'package:gesco/models/product.dart';
import 'package:gesco/ui/app_header.dart';
import 'package:gesco/ui/common_styles.dart';
import 'package:gesco/ui/detailed_order.dart';

class NewOrderPage extends StatefulWidget {
  final String title;
  Build build;
  Order order;
  OrderBloc bloc;

  NewOrderPage(
      {@required this.build, this.order, Key key, this.title = "NewOrder", @required this.bloc})
      : super(key: key) {
    if (this.order == null) {
      this.order = Order(
          color: Colors.blue,
          category: '',
          status: OrderStatusEnum.CRIANDO.index,
          quantity: 0,
          cust: 0,
          items: new List<Item>());
      this.order.orderNumber = ++this.build.ordersNumber;
    }
  }

  @override
  _NewOrderPageState createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage> {
  NewOrderBloc _bloc = new NewOrderBloc();
  ProductController productController = new ProductController();

  final TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    Future<List<Product>> filteredList = productController.getProducts();
    Future<List<Product>> products = productController.getProducts();

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
                                  filteredList = productController
                                      .getFilteredProducts(text);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      FutureBuilder(
                        builder: (context, builderSnap) {
                          if (builderSnap.connectionState ==
                                  ConnectionState.none &&
                              builderSnap.hasData == null) return Container();
                          return ListView.builder(
                              itemCount: builderSnap.data.length > 50
                                  ? 50
                                  : builderSnap.data.length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Card(
                                  color:
                                      Colors.lightBlueAccent.withOpacity(0.4),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FlatButton(
                                      onPressed: () {
                                        return showDialog(
                                            context: context,
                                            builder: (_) => buildAlertDialog(
                                                _formKey,
                                                builderSnap.data[index]));
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                builderSnap.data[index].name,
                                                style:
                                                    CommonStyles.TileTextStyle(
                                                        size: 18),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        future: filteredList,
                      )
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

  AlertDialog buildAlertDialog(GlobalKey<FormState> _formKey, Product product) {
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
                        Order order = widget.order;
                        widget.order.items.add(Item(
                            productId: product.documentId,
                            product: product,
                            quantity: int.parse(myController.text)));
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailedOrder(
                                    build: widget.build, newOrder: order, orderBloc: widget.bloc)));
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
