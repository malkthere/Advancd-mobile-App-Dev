import 'package:db_try1mobapp1/sqldb.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  SqlDb sqlDb = SqlDb();

  bool isLoading = false;

  List<Map> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    setState(() {
      data = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show all Data'),
      ),
      body: Center(
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : DataTable(
            columns: [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Note')),
            ],
            rows: data
                .map((item) => DataRow(
              cells: [
                DataCell(Text(item['id'].toString())),
                DataCell(Text(item['note'])),
              ],
            ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
