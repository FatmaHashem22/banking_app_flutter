import 'dart:ffi';

import 'package:banking_app/home.dart';
import 'package:banking_app/sqldb.dart';
import 'package:flutter/material.dart';

class EditUsers extends StatefulWidget {
  final name;
  final email;
  final balance;
  final id;
  EditUsers({Key? key, this.name, this.email, this.balance, this.id})
      : super(key: key);

  @override
  State<EditUsers> createState() => _EditUsersState();
}

class _EditUsersState extends State<EditUsers> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
                key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      controller: name,
                      decoration: InputDecoration(hintText: "name"),
                    ),
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(hintText: "email"),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: balance,
                      decoration: InputDecoration(hintText: "balance"),
                    ),
                    Container(height: 20),
                    MaterialButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        // int response = await sqlDb.updateData('''
                        //     UPDATE user SET
                        //     name    = "${name.text}",
                        //     email   = "${email.text}",
                        //     balance =  ${balance.text}
                        //     WHERE id = ${widget.id}
                        //     ''');
                        int response = await sqlDb.update(
                            "user",
                            {
                              "name": "${name.text}",
                              "email": "${email.text}",
                              "balance": "${balance.text}"
                            },
                            "id = ${widget.id}");

                        if (response > 0) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Home()),
                              (route) => false);
                        }
                      },
                      child: Text("Save Changes"),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
