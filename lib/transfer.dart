import 'dart:ffi';

import 'package:banking_app/amountTrans.dart';
import 'package:banking_app/edit.dart';
import 'package:banking_app/sqldb.dart';
import 'package:banking_app/viewUser.dart';
import 'package:flutter/material.dart';

class Transfer extends StatefulWidget {
  Transfer(
      {Key? key, required this.sId, this.sbalance, this.sname, this.semail})
      : super(key: key);
  final sId;
  final sbalance;
  final sname;
  final semail;
  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  bool isID = true;

  List users = [];

  Future readData() async {
    List<Map> response = await sqlDb.read("user");
    users.addAll(response);
    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
    print(widget.sId);
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: Text('Transfer to '),

        backgroundColor: Colors.purple,
      ),
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
                      itemCount: users.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        if (i == widget.sId - 1) {
                          users[i] = users[i + 1];
                        } else {
                          return Card(
                              child: ListTile(
                            title: Text(
                              "${users[i]['name']}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              "${users[i]['balance']} \$",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // IconButton(
                                //     onPressed: () async {
                                //       // int response = await sqlDb.deleteData(
                                //       //     "DELETE FROM user WHERE id = ${users[i]['id']}");
                                //       int response = await sqlDb.delete(
                                //           "user", "id = ${users[i]['id']}");
                                //       if (response > 0) {
                                //         users.removeWhere((element) =>
                                //             element['id'] == users[i]['id']);
                                //         setState(() {});
                                //       }
                                //     },
                                //     icon: Icon(
                                //       Icons.delete,
                                //       color: Colors.red,
                                //     )),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => amountTrans(
                                                    name: users[i]['name'],
                                                    email: users[i]['email'],
                                                    balance: users[i]
                                                        ['balance'],
                                                    id: users[i]['id'],
                                                    sender: widget.sId,
                                                    sbalance: widget.sbalance,
                                                    sname: widget.sname,
                                                    semail: widget.semail,
                                                  )));
                                    },
                                    icon: Icon(
                                      Icons.currency_exchange_outlined,
                                      size: 30.0,
                                      color: Color.fromARGB(215, 255, 217, 0),
                                    )),
                              ],
                            ),
                          ));
                        }
                        return Container();
                      })
                ],
              ),
            ),
    );
  }
}
