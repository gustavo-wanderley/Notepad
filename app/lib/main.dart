import 'package:app/service/data_base.dart';
import 'package:app/service/local_shared.dart';
import 'package:app/view/form_note_view.dart';
import 'package:app/view/home_view.dart';
import 'package:app/view/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => DataBase().noteDao),
        ChangeNotifierProvider(create: (_)=> LocalShared(),)
      ],
      child: MaterialApp(
        title: 'Bloco de notas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          "/": (context) => HomeView(),
          "/create-note": (context) => FormNoteView(),
          "/settings": (context) => SettingsView(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == "/create-note") {
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => FormNoteView(),
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c),
            );
          }
          return MaterialPageRoute(builder: (_) => HomeView());
        },
      ),
    );
  }
}
