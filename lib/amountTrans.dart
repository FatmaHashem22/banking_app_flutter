import 'dart:ffi';
import 'package:intl/intl.dart';
import 'package:banking_app/Transactions.dart';
import 'package:banking_app/home.dart';
import 'package:banking_app/sqldb.dart';
//import 'package:banking_app/viewUser.dart';
import 'package:banking_app/transfer.dart';
import 'package:banking_app/viewUser.dart';
import 'package:flutter/material.dart';

class amountTrans extends StatefulWidget {
  final name;
  final email;
  final balance;
  final id;
  final sender;
  final sbalance;
  final sname;
  final semail;

  amountTrans(
      {Key? key,
      this.name,
      this.email,
      this.balance,
      this.id,
      this.sender,
      this.sbalance,
      this.sname,
      this.semail})
      : super(key: key);

  @override
  State<amountTrans> createState() => _amountTransState();
}

class _amountTransState extends State<amountTrans> {
  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController balance = TextEditingController();
  TextEditingController amount = TextEditingController();

  @override
  void initState() {
    name.text = widget.name;
    email.text = widget.email;
    balance.text = widget.balance.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int sId = widget.id;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Amount'),
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
                    Form(
                        key: formstate,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                            ),
                            Container(
                              child: Text(
                                "Enter Amount",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 50,
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: amount,
                                decoration: InputDecoration(hintText: "Amount"),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(height: 20),
                            MaterialButton(
                              textColor: Colors.white,
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onPressed: () async {
                                // int response = await sqlDb.updateData('''
                                //     UPDATE user SET
                                //     name    = "${name.text}",
                                //     email   = "${email.text}",
                                //     balance =  ${balance.text}
                                //     WHERE id = ${widget.id}
                                //     ''');
                                // int response = await sqlDb.update(
                                //     "user",
                                //     {
                                //       "name": "${name.text}",
                                //       "email": "${email.text}",
                                //       "balance": "${balance.text}"
                                //     },
                                //     "id = ${widget.id}");

                                // if (response > 0) {
                                //   // Navigator.of(context).pushAndRemoveUntil(
                                //   //     MaterialPageRoute(
                                //   //         builder: (context) => Home()),
                                //   //     (route) => false);
                                //   print(amount.text);
                                // }
                                int intAmount = int.parse(amount.text);
                                print(widget.sbalance);
                                if (widget.sbalance < intAmount) {
                                  print("Not enough Cash");
                                } else {
                                  int snewbalance = widget.sbalance - intAmount;
                                  int rnewbalance = widget.balance + intAmount;
                                  int sresponse = await sqlDb.update(
                                      "user",
                                      {
                                        "name": "${widget.sname}",
                                        "email": "${widget.semail}",
                                        "balance": "${snewbalance}"
                                      },
                                      "id = ${widget.sender}");
                                  int rresponse = await sqlDb.update(
                                      "user",
                                      {
                                        "name": "${widget.name}",
                                        "email": "${widget.email}",
                                        "balance": "${rnewbalance}"
                                      },
                                      "id = ${widget.id}");
                                  DateTime dt = DateTime.now();
                                  String formatDT =
                                      DateFormat('yyy-MM-dd - kk:mm')
                                          .format(dt);
                                  if (sresponse > 0 && rresponse > 0) {
                                    int r = await sqlDb.insert("transfers", {
                                      "sender": "${widget.sname}",
                                      "senderId": "${widget.sender}",
                                      "receiver": "${widget.name}",
                                      "receiverId": "${widget.id}",
                                      "amount": "${intAmount}",
                                      "time": "${formatDT}",
                                    });
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => Home()),
                                        (route) => false);
                                    //print(amount.text);
                                  }
                                  print(snewbalance);
                                  print(rnewbalance);
                                }
                              },
                              child: Text("Save Changes"),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            MaterialButton(
                              textColor: Colors.white,
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onPressed: () async {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Transactions()));
                              },
                              child: Text("View Transactions"),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
