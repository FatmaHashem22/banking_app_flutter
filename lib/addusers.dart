import 'package:banking_app/home.dart';
import 'package:banking_app/sqldb.dart';
import 'package:flutter/material.dart';

class AddUsers extends StatefulWidget {
  AddUsers({Key? key}) : super(key: key);

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController balance = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Users'),
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
                        // int response = await sqlDb.insert('''
                        //     INSERT INTO user(name,email,balance)
                        //     VALUES ("${name.text}", "${email.text}", ${int.parse(balance.text)})
                        //     ''');
                        int response = await sqlDb.insert("user", {
                          "name": "${name.text}",
                          "email": "${email.text}",
                          "balance": "${int.parse(balance.text)}",
                        });

                        if (response > 0) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Home()),
                              (route) => false);
                        }
                      },
                      child: Text("Add User"),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
