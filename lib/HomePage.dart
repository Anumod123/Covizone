import 'package:covid/Hospital.dart';
import 'package:covid/Tindia.dart';
import 'package:covid/model/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Tcases.dart';
import 'India.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Hstate.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://corona.lmao.ninja/all";

  navigateToWHO(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Text('Link is not Working $url');
    }
  }

  navigateToIndia() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Tindia()));
  }

  navigateToIndiaMap() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => India()));
  }

  navigateToHospital() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Hospital()));
  }

  navigateToHstate() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Hstate()));
  }

  @override
  void initState() {
    super.initState();

    this.getJsonData();
  }

  Future<Tcases> getJsonData() async {
    var response = await http.get(
      Uri.encodeFull(url),
    );

    if (response.statusCode == 200) {
      final convertDataJson = jsonDecode(response.body);

      return Tcases.fromJson(convertDataJson);
    } else {
      throw Exception('Try to  Reload Page');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('CoviZONE'),
          ),
          backgroundColor: Color(0xFF152238),
          // backgroundColor: Color(0xFF00A86B),
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
            child: Container(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 20)),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Know your Safety Zone!!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                    ),
                    // Card(
                    //   child: Text('Home',
                    //       style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 25.0,
                    //           fontWeight: FontWeight.bold)),
                    //   color: Color(0xFFfe9900),
                    // )
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    OutlineButton(
                      color: Colors.blueAccent,
                      borderSide: BorderSide(color: Color(themegreen)),
                      onPressed: () => navigateToIndia(),
                      child: Text('India Statistics',
                          style: TextStyle(
                              color: Color(0xFFfe9900),
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    )
                  ]),
              FutureBuilder<Tcases>(
                  future: getJsonData(),
                  builder: (BuildContext context, SnapShot) {
                    if (SnapShot.hasData) {
                      final covid = SnapShot.data;
                      return Column(children: <Widget>[
                        Card(
                          color: Color(0xFF292929),
                          child: ListTile(
                            title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    "Total Cases ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${covid.cases} ",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                          ),
                        ),
                        Card(
                          color: Color(0xFF292929),
                          child: ListTile(
                            title: Row(children: <Widget>[
                              Text(
                                "Deaths",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${covid.deaths}",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                          ),
                        ),
                        Card(
                            color: Color(0xFF292929),
                            child: ListTile(
                                title: Row(children: <Widget>[
                              Text("Recoveries",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text("${covid.recovered}",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold)),
                            ]))),
                      ]);
                    } else if (SnapShot.hasError) {
                      return Text(SnapShot.error.toString());
                    }

                    return Center(child: CircularProgressIndicator());
                  }),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                    Card(
                      child: Container(
                          color: Color(0xFF292929),
                          child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                Padding(padding: EdgeInsets.only(top: 20.0)),
                                Image(
                                  image: AssetImage("images/india.png"),
                                  height: 90,
                                  width: 90,
                                ),
                                Padding(padding: EdgeInsets.all(10)),
                                OutlineButton(
                                  borderSide:
                                      BorderSide(color: Color(themegreen)),
                                  onPressed: () => navigateToIndiaMap(),
                                  child: Text(
                                    "Statewise Statistics",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFFfe9900),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ]))),
                    ),
                  ])),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                    Card(
                        child: Container(
                            color: Color(0xFF292929),
                            child: Center(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                  Padding(padding: EdgeInsets.only(top: 20.0)),
                                  Image(
                                    image: AssetImage("images/hospital.png"),
                                    height: 100,
                                    width: 100,
                                  ),
                                  Padding(padding: EdgeInsets.all(10)),
                                  OutlineButton(
                                    borderSide:
                                        BorderSide(color: Color(themegreen)),
                                    onPressed: () => navigateToHospital(),
                                    child: Text(
                                      "Hospital Statistics",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFFfe9900),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ])))),
                    Card(
                        child: Container(
                            color: Color(0xFF292929),
                            child: Center(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                  Padding(padding: EdgeInsets.only(top: 20.0)),
                                  Image(
                                    image: AssetImage("images/hs.png"),
                                    height: 100,
                                    width: 100,
                                  ),
                                  Padding(padding: EdgeInsets.all(10)),
                                  OutlineButton(
                                    borderSide:
                                        BorderSide(color: Color(themegreen)),
                                    onPressed: () => navigateToHstate(),
                                    child: Text(
                                      "         Hospitals\nStatewise Statistics",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFFfe9900),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ])))),
                  ])),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Card(
                  child: Container(
                      color: Color(0xFF292929),
                      child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                            Padding(padding: EdgeInsets.only(top: 20.0)),
                            Image(
                              image: AssetImage("images/myth.png"),
                              height: 100,
                              width: 100,
                            ),
                            Padding(padding: EdgeInsets.all(10)),
                            OutlineButton(
                              borderSide: BorderSide(color: Color(themegreen)),
                              onPressed: () => navigateToWHO(
                                  "https://www.who.int/news-room/q-a-detail/q-a-coronaviruses"),
                              child: Text(
                                "Myth Busters by WHO",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFFfe9900),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ])))),
            ],
          )),
        )));
  }
}
