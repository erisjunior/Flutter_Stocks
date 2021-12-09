import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request =
    "https://api.hgbrasil.com/finance?format=json-cors&key=0212333f";

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String titleText = "Consulta de Ações";
  double padding = 10.0;
  double iconSize = 70.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text(titleText),
            centerTitle: true,
            backgroundColor: Colors.pink.shade600),
        body: FutureBuilder<Map>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return buildLoading();
                default:
                  if (snapshot.hasError) {
                    return buildError();
                  } else {
                    final stocks = snapshot.data!["results"]["stocks"];
                    final stocksKeys = [];
                    stocks.forEach((key, value) => stocksKeys.add(
                        value['name'] + " - " + value['points'].toString()));

                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            height: 200.0,
                            child: ListView.builder(
                                itemCount: stocksKeys.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(stocksKeys[index]);
                                }),
                          ),
                        )
                      ],
                    );
                  }
              }
            }));
  }

  Widget buildLoading() {
    String text = "Carregando dados...";
    double fontSize = 25.0;
    return Center(
        child: Text(
      text,
      style: TextStyle(color: Colors.pink.shade600, fontSize: fontSize),
      textAlign: TextAlign.center,
    ));
  }

  Widget buildError() {
    String text = "Erro ao carregar dados!";
    double fontSize = 25.0;
    return Center(
        child: Text(
      text,
      style: TextStyle(color: Colors.pink.shade600, fontSize: fontSize),
      textAlign: TextAlign.center,
    ));
  }
}
