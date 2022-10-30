// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:flag/flag.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class coronapi extends StatefulWidget {
  const coronapi({Key? key}) : super(key: key);

  @override
  State<coronapi> createState() => _coronapiState();
}

class _coronapiState extends State<coronapi> {
//for loading icon
  bool loading = true;
  List countrydata = [];

  //feteching data

  Future<String> _getapiData() async {
    String url = "https://corona.askbhunte.com/api/v1/data/nepal";
    var response = await http.get(Uri.parse(url));
    var getData = json.decode(response.body);

    if (this.mounted) {
      setState(() {
        loading = false;
        countrydata = [getData];
      });
    }
    print("before exception");
    print(countrydata[0]);
    print("after excpetion");
    throw Exception();

  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      loading = true;
      _getapiData();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("नेपालमा कोरोना संक्रमित")),
          
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  _getapiData();
                },
                icon: Icon(Icons.refresh)),
                
                 
                
                
          ],
          
        ),
        body: Center(
          child: Container(
            height:500,
            width: 400,
            color: Colors.lightBlueAccent,
            padding: EdgeInsets.only(top:50.0),
           
            child: ListView(padding: EdgeInsets.all(8.0), children: [
              loading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: countrydata == null ? 0 : countrydata.length,
                      itemBuilder: (context, i) {
                        return listItem(i);
                      })
            ]),
          ),
        ));
  }

  Widget listItem(int i) {
    return Center(
      child: Container(
          child: Column(
          children: [
            Card(
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.coronavirus, size: 50),
                    title: Text('Tested Positive'),
                    subtitle: Text(jsonEncode(countrydata[0]['tested_positive'])),
                  ),
                ],
              ),
            ),
            SizedBox(height:11.0),
            Card(
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.bed, size: 50),
                    title: Text('Tested Negative'),
                    subtitle: Text(jsonEncode(countrydata[i]['tested_negative'])),
                  ),
                ],
              ),
            ),
            SizedBox(height:11.0),
            Card(
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.face, size: 50),
                    title: Text('Recovered '),
                    subtitle: Text(jsonEncode(countrydata[i]['recovered'])),
                  ),
                ],
              ),
            ),
            SizedBox(height:11.0),
            Card(
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.coronavirus_sharp, size: 50),
                    title: Text('Deaths'),
                    subtitle: Text(jsonEncode(countrydata[i]['deaths'])),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    // return Center(

    // //  child:Text(jsonEncode(countrydata[i])),
    // );
  }
}
