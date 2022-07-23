import 'dart:ffi';

import 'package:banking_app/NavigationDrawerWidget.dart';
import 'package:banking_app/edit.dart';
import 'package:banking_app/sqldb.dart';
import 'package:banking_app/viewUser.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;

  List users = [];

  Future readData() async {
    List<Map> response = await sqlDb.read("user");
    users.addAll(response);
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
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text('Customers List'),
        backgroundColor: Colors.purple,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).popAndPushNamed("addusers");
      //   },
      //   child: Icon(Icons.add),
      // ),
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
                        return Card(
                            child: Material(
                          type: MaterialType.transparency,
                          child: ListTile(
                            focusColor: Colors.pink,
                            hoverColor: Colors.blue,
                            // enabled: false,
                            // onTap: () {},
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
                                              builder: (context) => viewUser(
                                                    name: users[i]['name'],
                                                    email: users[i]['email'],
                                                    balance: users[i]
                                                        ['balance'],
                                                    id: users[i]['id'],
                                                  )));
                                    },
                                    icon: Icon(
                                      Icons.remove_red_eye_outlined,
                                      size: 30.0,
                                      color: Colors.purple,
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
