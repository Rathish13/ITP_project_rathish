import 'dart:wasm';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Read.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  var _formKey = GlobalKey<FormState>();

  String itemId, itemName, supplierId;
  int quantityItem;
  double priceItem, costItem;
  String dateitem;

  getitemid(itemid) {
    this.itemId = itemid;
  }

  getitemname(itemname) {
    this.itemName = itemname;
  }

  getsupplierid(supplierid) {
    this.supplierId = supplierid;
  }

  getquantity(quantity) {
    this.quantityItem = int.parse(quantity);
  }

  getprice(price) {
    this.priceItem = double.parse(price);
  }

  getcost(cost) {
    this.costItem = double.parse(cost);
  }

  getdate(date) {
    this.dateitem = date;
  }

  /*read() async {
    DocumentReference documentReference =
        Firestore.instance.collection("Stock").document(itemId);

    documentReference.get().then((datasnapshot) {
      print(datasnapshot.data()['itemId']);
      print(datasnapshot.data()['itemName']);
      print(datasnapshot.data()['quantityName']);
    });
  }*/

  addstock() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    Firebase.initializeApp();
    print("Added Sucessfully");
    DocumentReference documentReference =
        Firestore.instance.collection("Stock").document(itemId);

    Map<String, dynamic> items = {
      "itemId": itemId,
      "itemName": itemName,
      "supplierId": supplierId,
      "quantityItem": quantityItem,
      "priceItem": priceItem,
      "costItem": costItem,
      "dateitem": dateitem,
    };
    documentReference
        .setData(items)
        .whenComplete(() => print("Added Sucessfully"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Stock"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Item ID",
                        fillColor: Colors.white,
                        errorStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0))),
                    validator: (String itemid) {
                      if (itemid.isEmpty) {
                        return 'Please Enter Item ID';
                      }
                    },
                    onChanged: (String itemid) {
                      getitemid(itemid);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Item Name",
                        fillColor: Colors.white,
                        errorStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0))),
                    validator: (String itemname) {
                      if (itemname.isEmpty) {
                        return 'Please Enter Item Name';
                      }
                    },
                    onChanged: (String itemname) {
                      getitemname(itemname);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Supplier ID",
                        fillColor: Colors.white,
                        errorStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0))),
                    validator: (String supplierid) {
                      if (supplierid.isEmpty) {
                        return 'Please Enter Item ID';
                      }
                    },
                    onChanged: (String supplierid) {
                      getsupplierid(supplierid);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        labelText: "Quantity",
                        fillColor: Colors.white,
                        errorStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0))),
                    validator: (String quantity) {
                      if (quantity.isEmpty) {
                        return 'Please Enter Quantity';
                      }
                    },
                    onChanged: (String quantity) {
                      getquantity(quantity);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        labelText: "Price Per Item",
                        fillColor: Colors.white,
                        errorStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0))),
                    validator: (String price) {
                      if (price.isEmpty) {
                        return 'Please Enter Price Per Item';
                      }
                    },
                    onChanged: (String price) {
                      getprice(price);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        labelText: "Total Cost",
                        fillColor: Colors.white,
                        errorStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0))),
                    validator: (String cost) {
                      if (cost.isEmpty) {
                        return 'Please Enter Cost ';
                      }
                    },
                    onChanged: (String cost) {
                      getcost(cost);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        labelText: "Date",
                        fillColor: Colors.white,
                        errorStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2.0))),
                    validator: (String date) {
                      if (date.isEmpty) {
                        return 'Please Enter Date';
                      }
                    },
                    onChanged: (String date) {
                      getdate(date);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Text("ADD STOCK"),
                      textColor: Colors.white,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          addstock();
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: Text('Added Successfully'),
                                );
                              },
                              barrierDismissible: true);
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
