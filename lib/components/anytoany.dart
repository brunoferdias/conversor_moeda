import 'package:conversor_bruno/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnytoAny extends StatefulWidget {
  final Map currencies;
  final rates;
  const AnytoAny({required this.currencies, required this.rates});

  @override
  State<AnytoAny> createState() => _AnytoAnyState();
}

final anyToAnyController = TextEditingController();
String initialval1 = 'AUD';
String initialval2 = 'AUD';
String answer = 'Sua conversão aparecerá aqui';

class _AnytoAnyState extends State<AnytoAny> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              "Converta qualquer moeda",
              style: GoogleFonts.poppins(
                  fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: anyToAnyController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    hintText: 'Digite aqui',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1))),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton(
                    value: initialval1,
                    items: widget.currencies.keys
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      initialval1 = newVal as String;
                      setState(() {});
                    }),
                Text(
                  'para',
                  style: TextStyle(color: Colors.black),
                ),
                DropdownButton(
                    value: initialval2,
                    items: widget.currencies.keys
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      initialval2 = newVal as String;
                      setState(() {});
                    }),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  answer = anyToAnyController.text +
                      initialval1 +
                      ' = ' +
                      anyToAny(widget.rates, anyToAnyController.text,
                          initialval1, initialval2) +
                      initialval2;
                });
              },
              child: Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    'CONVERTER',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              answer,
              style: GoogleFonts.poppins(fontSize: 18),
            ),
          ],
        ));
  }
}
