import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Detail.dart';
import 'main.dart';
import 'package:crud_pegawai/editdata.dart';

class EditData extends StatefulWidget {
  final List list;
  final int index;

  EditData({this.list, this.index});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController namaController;
  TextEditingController posisiController;
  TextEditingController gajiController;

  void editData() {
    var url = "http://10.0.2.2/pegawai/editPegawai.php";
    http.post(url, body: {
      "id": widget.list[widget.index]['id'],
      "namaPegawai": namaController.text,
      "posisiPegawai": posisiController.text,
      "gajiPegawai": gajiController.text,
    });
  }

  @override
  void initState() {
    namaController =
        new TextEditingController(text: widget.list[widget.index]['nama']);
    posisiController =
        new TextEditingController(text: widget.list[widget.index]['posisi']);
    gajiController =
        new TextEditingController(text: widget.list[widget.index]['gaji']);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data Pegawai'),
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
                    controller: namaController,
                    decoration: new InputDecoration(
                        hintText: "Input nama pegawai",
                        labelText: "Nama Pegawai",
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)))),
                new Padding(padding: new EdgeInsets.only(top: 5.0)),
                new TextField(
                    controller: posisiController,
                    decoration: new InputDecoration(
                        hintText: "Input Posisi pegawai",
                        labelText: "Posisi Pegawai",
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)))),
                new Padding(padding: new EdgeInsets.only(top: 5.0)),
                new TextField(
                    controller: gajiController,
                    decoration: new InputDecoration(
                        hintText: "Input Gaji pegawai",
                        labelText: "Input Gaji",
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)))),
                new Padding(padding: new EdgeInsets.only(top: 5.0)),
                new RaisedButton(
                  child: new Text(
                    "Edit Data",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blueAccent,
                  onPressed: () {
                    editData();
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
