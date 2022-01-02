import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'editdata.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class Detail extends StatefulWidget {
  List list;
  int index;

  Detail({this.list, this.index});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  void deletedata() {
    var url = "http://10.0.2.2/pegawai/deleteData.php";
    http.post(url, body: {"id": widget.list[widget.index]['id']});
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Are you sure want to delete '${widget.list[widget.index]['nama']}'"),
      actions: <Widget>[
        new RaisedButton(
            child: new Text(
              "OK DELETE!",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.red,
            onPressed: () {
              deletedata();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new MyApp()));
            }),
        new RaisedButton(
          child: new Text(
            'CANCEL',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.green,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(
        builder: (context) => alertDialog,
        context: context,
        useRootNavigator: false);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("${widget.list[widget.index]['posisi']}")),
        backgroundColor: Colors.grey,
        body: new ListView(
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.all(10.0),
              height: 500.0,
              child: Row(
                children: <Widget>[
                  new Expanded(
                      child: Card(
                    child: new Column(
                      children: <Widget>[
                        new Padding(padding: const EdgeInsets.only(top: 30.0)),
                        new Text(
                          widget.list[widget.index]['nama'],
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        new Text(
                          "Posisi: ${widget.list[widget.index]['posisi']}",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        new Text(
                          "Gaji: ${widget.list[widget.index]['gaji']}",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        new Padding(padding: const EdgeInsets.only(top: 30.0)),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new RaisedButton(
                              child: new Text(
                                'Edit',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.green,
                              onPressed: () => Navigator.of(context)
                                  .push(new MaterialPageRoute(
                                builder: (BuildContext context) => new EditData(
                                  list: widget.list,
                                  index: widget.index,
                                ),
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                            ),
                            new RaisedButton(
                              child: new Text(
                                'Delete',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.blue,
                              onPressed: () => confirm(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
                ],
              ),
            )
          ],
        ));
  }
}
