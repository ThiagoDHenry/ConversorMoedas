import 'package:conversor/api/conversor.dart';
import 'package:conversor/functions/textFieldBuild.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  late double dolar;
  late double euro;

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text); // Converte a string para double
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }

    double euro = double.parse(text); // Converte a string para double
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("\$ Conversos \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: Text("Carregando Dados...",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Erro ao carregar Dados...",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center),
                );
              } else {
                var data = snapshot.data;

                if (data != null &&
                    data.containsKey("USDBRL") &&
                    data.containsKey("EURBRL")) {
                  // Convertendo os valores de bid de String para double
                  dolar = double.parse(data["USDBRL"]["bid"]);
                  euro = double.parse(data["EURBRL"]["bid"]);
                }
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Icon(
                          Icons.monetization_on,
                          size: 150.0,
                          color: Colors.amber,
                        ),
                        //REAIS
                        buildTextField(
                            "Reais", "R\$", realController, _realChanged),
                        const Divider(
                          color: Colors.black,
                        ),
                        //DOLAR
                        buildTextField(
                            "Dólares", "US\$", dolarController, _dolarChanged),
                        const Divider(
                          color: Colors.black,
                        ),
                        //EURO
                        buildTextField(
                            "Euros", "€", euroController, _euroChanged),
                      ]),
                );
              }
          }
        },
      ),
    );
  }
}
