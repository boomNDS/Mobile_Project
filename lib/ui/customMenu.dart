import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Color myColor = Color(0x2ec4b6);

class Add extends StatefulWidget {
  final FirebaseUser user;
  const Add({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _Add();
  }
}

class _Add extends State<Add> {
  final _formKey = GlobalKey<FormState>();
  final txtControl1 = TextEditingController();
  final txtControl2 = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 30, 30, 0),
              children: <Widget>[
                const Divider(height: 25.0),
                TextFormField(
                  controller: txtControl1,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(),
                    ),
                    hintText: "อาหารของคุณ",
                    prefixIcon: Icon(Icons.kitchen),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "โปรดกรอกอาหารของคุณ";
                    }
                  },
                ),
                const Divider(height: 5.0),
                TextFormField(
                  controller: txtControl2,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(),
                    ),
                    hintText: "พลังงาน (kcal)",
                    prefixIcon: Icon(Icons.fitness_center),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "โปรดกรอกพลังงานของอาหาร";
                    }
                  },
                ),
                const Divider(height: 15.0),
                RaisedButton(
                  color: Colors.orange,
                  child: Text("เพิ่ม",
                    style: TextStyle(fontSize: 18),
                  ),
                  textColor: Colors.white,
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("โปรดกรอกข้อมูล")));
                    } else {
                      List<Map<String, String>> list =
                          new List<Map<String, String>>();

                      Map<String, String> list2 = Map<String, String>();
                      list2['name'] = txtControl1.text;
                      list2['cal'] = txtControl2.text;

                      list.add(list2);

                      Firestore.instance
                        .collection('calorie_food')
                        .document(widget.user.uid)
                        .updateData(
                          {"food": FieldValue.arrayUnion(list)});
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
