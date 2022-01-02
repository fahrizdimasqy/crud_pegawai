import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'dart:io';
import 'package:async/async.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController namacontroller = new TextEditingController();
  TextEditingController posisicontroller = new TextEditingController();
  TextEditingController gajicontroller = new TextEditingController();

  void addData() {
    var url = "http://10.0.2.2/pegawai/adddata.php";
    var resJson = http.post(url, body: {
      "namaPegawai": namacontroller.text,
      "posisiPegawai": posisicontroller.text,
      "gajiPegawai": gajicontroller.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Add Data Pegawai'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Padding(padding: new EdgeInsets.only(top: 15.0)),
                new TextField(
                    controller: namacontroller,
                    decoration: new InputDecoration(
                        hintText: "Input Nama Pegawai",
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)))),
                new Padding(padding: new EdgeInsets.only(top: 5.0)),
                new TextField(
                    controller: posisicontroller,
                    decoration: new InputDecoration(
                        hintText: "Input Posisi Pegawai",
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)))),
                new Padding(padding: new EdgeInsets.only(top: 5.0)),
                new TextField(
                    controller: gajicontroller,
                    decoration: new InputDecoration(
                        hintText: "Input Gaji Pegawai",
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)))),
                new Padding(padding: const EdgeInsets.all(5.0)),
                new RaisedButton(
                  child: new Text(
                    "Add Data",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    addData();
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => MyApp()));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
