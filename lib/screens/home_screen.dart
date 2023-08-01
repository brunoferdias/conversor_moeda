import 'package:conversor_bruno/components/anytoany.dart';
import 'package:conversor_bruno/components/usdtoany.dart';
import 'package:conversor_bruno/functions/functions.dart';
import 'package:conversor_bruno/models/all_rates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Map> allcurrencies;
  late Future<AllRatesModel> results;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      allcurrencies = getallcurrencies();
      results = getallrates();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        } //Esconde o teclado ao clicar em outro lugar!!!!!!!!!!!!!!!!
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Color.fromARGB(150, 7, 30, 107),
          title: Text(
            'Vamos Começar',
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/dinheiro.jpg'),
            ),
          ),
          child: SingleChildScrollView(
            child: FutureBuilder<AllRatesModel>(
              future: results,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: [
                      SizedBox(height: 300,),
                      CircularProgressIndicator(),
                    ],
                  );
                } else {
                  return Center(
                    child: FutureBuilder<Map>(
                      future: allcurrencies,
                      builder: (context, currSnapshot) {
                        if (currSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Column(
                            children: [
                              SizedBox(height: 300,),
                              CircularProgressIndicator(),
                            ],
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                USDtoany(
                                  currencies: currSnapshot.data!,
                                  rates: snapshot.data!.rates,
                                ).animate().fade(delay: 200.ms,duration: 700.ms).slide().then().shake(delay: 100.ms,duration: 200.ms),
                                SizedBox(height: 15),
                                AnytoAny(
                                  currencies: currSnapshot.data!,
                                  rates: snapshot.data!.rates,
                                ).animate().fade(delay: 600.ms,duration: 700.ms).slide().then().shake(delay: 100.ms,duration: 200.ms),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}