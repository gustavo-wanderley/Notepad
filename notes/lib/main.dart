import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:notes/service/data_base.dart';
import 'package:notes/service/local_shared.dart';
import 'package:notes/shared/adsense_app.dart';
import 'package:notes/view/form_note_view.dart';
import 'package:notes/view/home_view.dart';
import 'package:notes/view/settings_view.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final _adsApp = AdsApp(initFuture);
  runApp(
    Provider.value(
      value: _adsApp,
      builder: (context, child) {
        return MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => DataBase().noteDao),
        ChangeNotifierProvider(
          create: (_) => LocalShared(),
        )
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
