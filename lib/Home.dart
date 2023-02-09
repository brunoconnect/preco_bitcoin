import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _preco = "0";

  void _recuperarPreco() async {
    var url = Uri.parse('https://blockchain.info/ticker');
    http.Response response;
    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    // print("Resultado: " + retorno["BRL"]["buy"].toString());

    setState(() {
      _preco = retorno["BRL"]["buy"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(24),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset("assets/imagens/bitcoin.png"),
            Padding(
              padding: EdgeInsets.only(top: 24, bottom: 24),
              child: Text(
                "R\$ $_preco",
                style: TextStyle(fontSize: 35),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.fromLTRB(30, 15, 30, 15)),
              onPressed: _recuperarPreco,
              child: Text(
                "Atualizar",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
