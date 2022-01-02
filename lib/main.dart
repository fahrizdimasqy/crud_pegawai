import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'Detail.dart';
import 'AddData.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<List> getData() async {
    final response = await http.get("http://10.0.2.2/pegawai/getPegawai.php");
    return json.decode(response.body); //data dari server kemudian di decode
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: new AppBar(
              title: Text("Data Pegawai"),
              backgroundColor: Colors.blue,
            ),
            floatingActionButton: new FloatingActionButton(
              child: new Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) =>
                    new AddData(), //ketika memnambahkan data maka akan memanggil class AddData
              )),
            ),
            body: new FutureBuilder<List>(
                future: getData(), //memanggil method getData
                builder: (context, snaphot) {
                  if (snaphot.hasError) print(snaphot.error);
                  return snaphot.hasData
                      ? new ItemList(
                          list: snaphot
                              .data, // ketika snapshot memiliki data, maka akan dimasukan ke dalam list
                        )
                      : new Center(
                          child:
                              new CircularProgressIndicator(), //widget loading
                        );
                })));
  }
}

class ItemList extends StatelessWidget {
  final List list;

  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return new Container(
            child: new GestureDetector(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Detail(
                        list: list,
                        index: i,
                      ))),
              child: new Card(
                color: Colors.white,
                child: new ListTile(
                  title: new Text(list[i]['nama']), //menampilkan data nama
                  leading: new Icon(Icons.list), //menampilkan icon lists
                  subtitle: new Text(
                      "Posisi : ${list[i]['posisi']}"), //menampilkan posisi listnya
                ),
              ),
            ),
          );
        });
  }
}
