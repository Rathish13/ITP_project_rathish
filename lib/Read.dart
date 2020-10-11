import 'dart:wasm';
import 'package:canteenapp/Detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Add.dart';
import 'main.dart';
import 'dart:async';

class Check extends StatefulWidget {
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  var _formKey = GlobalKey<FormState>();

  String itemId, itemName, supplierId;
  int quantityItem;
  double priceItem, costItem;
  String dateitem;

  crudMethods crudobj = new crudMethods();

  Future<bool> updateDialog(BuildContext context, selecteddoc) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: AlertDialog(
                title: Text('Update Data', style: TextStyle(fontSize: 15.0)),
                content: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: "Item ID"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Item ID';
                        }
                      },
                      onChanged: (value) {
                        this.itemId = value;
                      },
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Item Name"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Item Name';
                        }
                      },
                      onChanged: (value) {
                        this.itemName = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Supplier ID"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Supplier ID';
                        }
                      },
                      onChanged: (value) {
                        this.supplierId = value;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(hintText: "Quantity"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Quantity';
                        }
                      },
                      onChanged: (value) {
                        this.quantityItem = int.parse(value);
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(hintText: "Price"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Price';
                        }
                      },
                      onChanged: (value) {
                        this.priceItem = double.parse(value);
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(hintText: "Cost"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Cost';
                        }
                      },
                      onChanged: (value) {
                        this.costItem = double.parse(value);
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(hintText: "Date"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Date';
                        }
                      },
                      onChanged: (value) {
                        this.dateitem = value;
                      },
                    ),
                  ],
                ),
                actions: [
                  FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.of(context).pop();
                        crudobj.updatestock(selecteddoc, {
                          "itemId": this.itemId,
                          "itemName": this.itemName,
                          "supplierId": this.supplierId,
                          "quantityItem": this.quantityItem,
                          "priceItem": this.priceItem,
                          "costItem": this.costItem,
                          "dateitem": this.dateitem,
                        });
                        return showDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text('Updated Successfully'),
                              );
                            },
                            barrierDismissible: true);
                      }
                    },
                    child: Text('Update'),
                    textColor: Colors.red,
                  )
                ],
              ),
            ),
          );
        });
  }

  deletestock(String itemId) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    Firebase.initializeApp();

    DocumentReference documentReference =
        Firestore.instance.collection("Stock").document('itemId');

    documentReference
        .delete()
        .whenComplete(() => print("Deleted Successfully"));
  }

  navigationtodetail(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Detailpage(
                  post: post,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("CHECK AVAILABILITY"),
        ),
        body: Container(
          color: Colors.grey[50],
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      textDirection: TextDirection.ltr,
                      children: [
                        Expanded(
                            child: Text(
                          "Item ID",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        )),
                        Expanded(
                            child: Text(
                          "Name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        )),
                        Expanded(
                            child: Text(
                          "Quantity",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        )),
                        Expanded(child: Text(""))
                      ],
                    ),
                  ),
                  Card(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 10,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: StreamBuilder(
                        stream:
                            Firestore.instance.collection("Stock").snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (BuildContext context, int index) {
                                  DocumentSnapshot ds =
                                      snapshot.data.documents[index];
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          child: Text(
                                            ds.get('itemId'),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onLongPress: () {
                                            updateDialog(
                                                context, ds.documentID);
                                          },
                                          onTap: () => navigationtodetail(ds),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          ds.get('itemName'),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          ds.get('quantityItem').toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: RaisedButton(
                                          color: Colors.yellow[800],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: Text("Delete"),
                                          textColor: Colors.white,
                                          elevation: 3.0,
                                          onPressed: () async {
                                            await Firestore.instance
                                                .collection('Stock')
                                                .document(ds.documentID)
                                                .delete();
                                            return showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return CupertinoAlertDialog(
                                                    title: Text(
                                                        'Deleted Successfully'),
                                                  );
                                                },
                                                barrierDismissible: true);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            return Align(
                              alignment: FractionalOffset.center,
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              )),
        ));
  }
}

class crudMethods {
  getdata() async {
    return await Firestore.instance.collection("Stock").snapshots();
  }

  updatestock(selecteddoc, newvalues) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    Firebase.initializeApp();

    Firestore.instance
        .collection("Stock")
        .document(selecteddoc)
        .update(newvalues)
        .catchError((e) {
      print(e);
    });
  }
}
