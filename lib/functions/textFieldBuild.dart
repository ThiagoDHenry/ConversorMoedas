import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildTextField(String label, String prefix,
    TextEditingController controlador, Function(String) funcao) {
  return TextField(
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    inputFormatters: [
      FilteringTextInputFormatter.allow(
          RegExp(r'^[0-9,\.]*$')), // Permite números, vírgula e ponto
    ],
    controller: controlador,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.amber),
      border: const OutlineInputBorder(),
      prefixText: prefix,
    ),
    style: const TextStyle(color: Colors.amber, fontSize: 25.0),
    onChanged: (text) {
      String updatedText = text.replaceAll(',', '.');

      controlador.value = TextEditingValue(
        text: updatedText,
        selection: TextSelection.collapsed(offset: updatedText.length),
      );
      funcao(updatedText);
    },
  );
}
