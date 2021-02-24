import 'package:app/service/local_shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    //Provider.of<LocalShared>(context).getStatus();
    LocalShared localShared = Provider.of<LocalShared>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Notas em ordem Alfabética"),
                IconButton(
                  icon: Icon(localShared.ordem
                      ? Icons.check_box
                      : Icons.check_box_outline_blank),
                  onPressed: () {
                    localShared.setOrdemAlfabetica("ordem", !localShared.ordem);
                  },
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Exibir prévia das notas"),
                IconButton(
                  icon: Icon(localShared.previa
                      ? Icons.check_box
                      : Icons.check_box_outline_blank),
                  onPressed: () {
                    localShared.setOrdemAlfabetica(
                        "previa", !localShared.previa);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
