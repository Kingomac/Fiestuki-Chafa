import 'package:fiestuki/adivina_influencer.dart';
import 'package:flutter/material.dart';

class AdivinaInfluencerTutorial extends StatelessWidget {
  const AdivinaInfluencerTutorial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adivina el influencer"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(7),
        child: Column(
          children: [
            const Text(
              "A continuación se mostrará un clip de un influencer y tienes que imitarlo, no tiene que ser necesariamente el clip proporcionado, pero debes hacerlo de forma que se reconozca",
              style: TextStyle(fontSize: 16),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdivinaInfluencerRoute()));
                  /*Navigator.removeRoute(
                      context, MaterialPageRoute(builder: (context) => this));*/
                },
                child: const Text("que si abby que si"))
          ],
        ),
      ),
    );
  }
}
