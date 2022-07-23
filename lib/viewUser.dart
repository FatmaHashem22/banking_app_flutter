import 'dart:ffi';

import 'package:banking_app/home.dart';
import 'package:banking_app/sqldb.dart';
import 'package:banking_app/transfer.dart';
import 'package:flutter/material.dart';

class viewUser extends StatefulWidget {
  final name;
  final email;
  final balance;
  final id;

  viewUser({Key? key, this.name, this.email, this.balance, this.id})
      : super(key: key);

  @override
  State<viewUser> createState() => _viewUserState();
}

class _viewUserState extends State<viewUser> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController balance = TextEditingController();

  @override
  void initState() {
    name.text = widget.name;
    email.text = widget.email;
    balance.text = widget.balance.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // int sId = widget.id;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Transfer(
                  sId: widget.id,
                  sname: widget.name,
                  semail: widget.email,
                  sbalance: widget.balance)));
        },
        label: Text('Transfer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        icon: Icon(
          Icons.monetization_on_outlined,
          color: Color.fromARGB(215, 255, 217, 0),
        ),
        backgroundColor: Colors.purple,
      ),
      appBar: AppBar(
        title: const Text('User Information'),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Colors.purple.shade900,
              Colors.purple.shade600,
              Colors.blue
            ])),
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment(0, 0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // =================Username==========================
                    Text(
                      "Username",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Center(
                      child: Container(
                        width: 250,
                        height: 50,
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.indigo, Colors.blueAccent]),
                            // border: Border.all(color: Colors.blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          "${name.text}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    //================Email==============================
                    Text(
                      "Email",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Center(
                      child: Container(
                        width: 250,
                        height: 50,
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.indigo, Colors.blueAccent]),
                            // border: Border.all(color: Colors.blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          "${email.text}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // =================Balance==========================
                    Text(
                      "Balance",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Center(
                      child: Container(
                        width: 250,
                        height: 50,
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.indigo, Colors.blueAccent]),
                            // border: Border.all(color: Colors.blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          "${balance.text} \$",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
          //   Form(
          //       key: formstate,
          //       child: Column(
          //         children: [
          //           TextFormField(
          //             controller: name,
          //             decoration: InputDecoration(hintText: "name"),
          //           ),
          //           TextFormField(
          //             controller: email,
          //             decoration: InputDecoration(hintText: "email"),
          //           ),
          //           TextFormField(
          //             keyboardType: TextInputType.number,
          //             controller: balance,
          //             decoration: InputDecoration(hintText: "balance"),
          //           ),
          //           Container(height: 20),
          //           MaterialButton(
          //             textColor: Colors.white,
          //             color: Colors.blue,
          //             onPressed: () async {
          //               // int response = await sqlDb.updateData('''
          //               //     UPDATE user SET
          //               //     name    = "${name.text}",
          //               //     email   = "${email.text}",
          //               //     balance =  ${balance.text}
          //               //     WHERE id = ${widget.id}
          //               //     ''');
          //               int response = await sqlDb.update(
          //                   "user",
          //                   {
          //                     "name": "${name.text}",
          //                     "email": "${email.text}",
          //                     "balance": "${balance.text}"
          //                   },
          //                   "id = ${widget.id}");

          //               if (response > 0) {
          //                 Navigator.of(context).pushAndRemoveUntil(
          //                     MaterialPageRoute(builder: (context) => Home()),
          //                     (route) => false);
          //               }
          //             },
          //             child: Text("Save Changes"),
          //           )
          //         ],
          //       ))
        ),
      ),
    );
  }
}
