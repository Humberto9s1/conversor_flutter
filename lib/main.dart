import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request =
    "https://api.hgbrasil.com/finance?format=json-cors&key=c2ebd8b6";

void main() async {
  runApp(MaterialApp(
    home: Home(),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dollar;
  double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("\$ Conversor \$"),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: FutureBuilder<Map>(
            future: getData(),
            // ignore: missing_return
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                      child: Text(
                    "Carregando Dados...",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0,
                    ),
                    textAlign: TextAlign.center,
                  ));
                default:
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "Erro ao carregar os dados",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 25.0,
                      ),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    dollar =
                        snapshot.data["results"]["currencies"]["USD"]["buy"];
                    euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Icon(
                            Icons.monetization_on,
                            size: 150.0,
                            color: Colors.amber,
                          ),
                          TextField(
                              style: TextStyle(color: Colors.amber),
                              decoration: InputDecoration(
                                  labelText: "REAIS",
                                  labelStyle: TextStyle(
                                      color: Colors.amber, fontSize: 25.0),
                                  border: OutlineInputBorder(),
                                  prefixText: "R\$ ",
                                  prefixStyle: TextStyle(color: Colors.amber),
                                  //colocar essa pra prefixtext
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.amber),
                                  ),
                                  //colocar essa pra borda mudar cor na seleção
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.amber,
                                  )) //colocar essa pra borda ficar OURO antes da seleção
                                  )),
                          Divider(),
                          TextField(
                              style: TextStyle(color: Colors.amber),
                              decoration: InputDecoration(
                                  labelText: "DOLLAR",
                                  labelStyle: TextStyle(
                                      color: Colors.amber, fontSize: 25.0),
                                  border: OutlineInputBorder(),
                                  prefixText: "US\$ ",
                                  prefixStyle: TextStyle(color: Colors.amber),
                                  //colocar essa pra prefixtext
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.amber),
                                  ),
                                  //colocar essa pra borda mudar cor na seleção
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.amber,
                                  )) //colocar essa pra borda ficar OURO antes da seleção
                                  )),
                          Divider(),
                          TextField(
                              style: TextStyle(color: Colors.amber),
                              decoration: InputDecoration(
                                  labelText: "EURO",
                                  labelStyle: TextStyle(
                                      color: Colors.amber, fontSize: 25.0),
                                  border: OutlineInputBorder(),
                                  prefixText: "\€ ",
                                  prefixStyle: TextStyle(color: Colors.amber),
                                  //colocar essa pra prefixtext
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.amber),
                                  ),
                                  //colocar essa pra borda mudar cor na seleção
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.amber,
                                  )) //colocar essa pra borda ficar OURO antes da seleção
                                  )),
                        ],
                      ),
                    );
                  }
              }
            }));
  }
}
