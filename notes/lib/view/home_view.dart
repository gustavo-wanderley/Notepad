import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:notes/service/data_base.dart';
import 'package:notes/service/local_shared.dart';
import 'package:notes/shared/adsense_app.dart';
import 'package:notes/widget/note_item_widget.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  BannerAd _bannerAd;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final adsApp = Provider.of<AdsApp>(context);
    adsApp.initialization.then((status) {
      setState(() {
        _bannerAd = BannerAd(
            size: AdSize.banner,
            adUnitId: adsApp.bannerAdUnitId,
            listener: AdListener(),
            request: AdRequest())..load();
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    NoteDao notesDao = Provider.of<NoteDao>(context);
    Provider.of<LocalShared>(context).getStatus();
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloco de Notas"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, "/settings");
              })
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: StreamBuilder(
                builder: (context, snapshot) {
                  final notes = snapshot.data ?? [];
                  if (notes.length == 0) {
                    return Center(
                      child: Text("Não possui Notas"),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) =>
                          NoteItemWidget(note: notes[index]),
                    );
                  }
                },
                stream: Provider.of<LocalShared>(context).ordem
                    ? notesDao.watchAllNotesOrder()
                    : notesDao.watchAllNotes(),
              ),
            ),
          ),
          SizedBox(height: 26,),
          if (_bannerAd == null)
            SizedBox(
              width: 320,
              height: 50,
              child: Container(
                color: Colors.white,
              ),
            )
          else
            SizedBox(
              height: 50,
              child: AdWidget(
                ad: _bannerAd,
              ),
            )
        ],
      ),
      floatingActionButton: Padding(
        padding:EdgeInsets.only(bottom: 36) ,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, "/create-note");
          },
        ),
      ),
    );
  }
}
