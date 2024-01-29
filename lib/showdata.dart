import 'package:flutter/material.dart';
import 'package:db_try1mobapp1/sqldb.dart';
import 'package:db_try1mobapp1/main.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage1(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage1> createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {
  final SqlDb sqlDb = SqlDb();
  List<Map> response = [];
  @override
  void initState() {
  maz();
}
void maz() async{
  List<Map> response = await sqlDb.readData("SELECT * FROM 'notes'");
  setState(() {
    this.response = response;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes"),
      ),
      body: ListView.builder(
        itemCount: response.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ListTile(
              title: RichText(
                text: TextSpan(
                  text: 'id: ',
                  style: DefaultTextStyle.of(context).style.copyWith(fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(text: response[index]['id'].toString()),
                  ],
                ),
              ),
              subtitle: RichText(
                text: TextSpan(
                  text: 'note: ',
                  style: DefaultTextStyle.of(context).style.copyWith(fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(text: response[index]['note']),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pop(context);

        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}