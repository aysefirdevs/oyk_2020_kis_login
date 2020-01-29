import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class home_page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomePage();
  }
}

class HomePage extends State<home_page>
{

  final Firestore _firestore= Firestore.instance;



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Anasayfa"),
          backgroundColor: Colors.pink[200],
        ),

        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                RaisedButton(
                  color: Colors.orangeAccent,
                  child: Text("veri ekleme"),
                  onPressed: (){
                    Map<String,dynamic> veriEkle=Map();
                    veriEkle["isim"]="ayse";
                    veriEkle["yas"]=21;

                    _firestore.collection("kullanıcılar")
                        .document("ogrenci").setData(veriEkle);
                    _firestore.collection("kullanıcılar")
                    .document("ogretmen").setData(veriEkle);
                  },
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text("veri silme"),
                  onPressed:(){
                    _firestore.document("kullanıcılar/ogrenci").delete();
                    _firestore.document("kullanıcılar/ogretmen").updateData({"isim": FieldValue.delete()});

                  }
                ),
                RaisedButton(
                  color: Colors.greenAccent,
                  child: Text("veri güncelleme"),
                  onPressed: (){
                    _firestore.document("kullanıcılar/ogrenci").updateData({"isim":"onur"});
                  },
                ),
                RaisedButton(
                  color: Colors.deepPurpleAccent,
                  child: Text("veri okuma"),
                  onPressed: veriokuma
               ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future veriokuma() async{
    DocumentSnapshot documentSnapshot=
        await _firestore.document("kullanıcılar/ogrenci").get();
    debugPrint("öğrencinin ismi:"+ documentSnapshot.data["isim"].toString());

    debugPrint("öğrencinin özellikleri"+
     documentSnapshot.data.toString()
    );

    debugPrint("öğrencinin yaşı:"+
    documentSnapshot.data["yas"].toString()
    );
  }
}