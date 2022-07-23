import 'dart:ffi';
import 'package:banking_app/NavigationDrawerWidget.dart';

import "amountTrans.dart";
import 'package:banking_app/sqldb.dart';
import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {
  Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;

  List trans = [];

  Future readData() async {
    List<Map> response = await sqlDb.read("transfers");
    trans.addAll(response);
    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List rtrans = trans.reversed.toList();
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text('Transactions List'),
        backgroundColor: Colors.purple,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          Navigator.of(context).popAndPushNamed("home");
        },
        child: Icon(Icons.home),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: isLoading == true
          ? Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                    Colors.purple.shade900,
                    Colors.purple.shade600,
                    Colors.blue
                  ])),
              child: Center(
                child: Text("Loading..",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
              ))
          : Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                    Colors.purple.shade900,
                    Colors.purple.shade600,
                    Colors.blue
                  ])),
              child: ListView(
                children: [
                  // MaterialButton(
                  //     onPressed: () async {
                  //       await sqlDb.mydeleteDatabase();
                  //     },
                  //     child: Text("delete database")),

                  ListView.builder(
                      itemCount: rtrans.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return Card(
                            child: Material(
                          type: MaterialType.transparency,
                          child: ListTile(
                            focusColor: Colors.pink,
                            hoverColor: Colors.blue,
                            // enabled: false,
                            // onTap: () {},
                            title: Text(
                              "${rtrans[i]['amount']} \$",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              "${rtrans[i]['sender']} to ${rtrans[i]['receiver']}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${rtrans[i]['time']}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      // int response = await sqlDb.deleteData(
                                      //     "DELETE FROM user WHERE id = ${users[i]['id']}");
                                      int response = await sqlDb.delete(
                                          "transfers",
                                          "id = ${rtrans[i]['id']}");
                                      if (response > 0) {
                                        rtrans.removeWhere((element) =>
                                            element['id'] == rtrans[i]['id']);
                                        setState(() {});
                                      }
                                    },
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: Colors.blue,
                                      size: 20,
                                    )),
                              ],
                            ),
                          ),
                        ));
                      })
                ],
              ),
            ),
    );
  }
}
