// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'record.dart';
import 'package:intl/intl.dart';

class ViewRecord extends StatefulWidget {
  const ViewRecord({super.key});

  @override
  State<ViewRecord> createState() => _ViewRecordState();
}

class _ViewRecordState extends State<ViewRecord> {
  List data = [];
  int? selectedIndex;
  TextEditingController tid = TextEditingController();
  TextEditingController cnum = TextEditingController();
  TextEditingController cname = TextEditingController();
  // Without using a class to store the collect records from the table
  // Future<void> getrecord() async {
  //   String uri = "http://10.0.2.2/practice_api/view_record.php";
  //   try {
  //     var response = await http.get(Uri.parse(uri));
  //     setState(() {
  //       data = jsonDecode(response.body);
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  //To get the records from the table
  Future<void> getrecord() async {
    String uri = "http://10.0.2.2/practice_api/view_record.php";
    try {
      var response = await http.get(Uri.parse(uri));
      List<dynamic> jsonList = jsonDecode(response.body);
      //To print date field's records for verification
      // jsonList.forEach((item) {
      // print(item['date']);
      // });
      setState(() {
        data = jsonList.map((json) => Record.fromJson(json)).toList();
      });
    } catch (e) {
      print(e);
    }
  }

  //To delete a Record in the table
  Future<void> deleterecord(String tid) async {
    String uri = "http://10.0.2.2/practice_api/delete_record.php";
    try {
      var res = await http.post(Uri.parse(uri), body: {
        "tid": tid,
      });
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("Record Deleted");
        getrecord(); //This function call is to reflect the deletion of a record on live
      } else {
        print("Some issues");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updaterecord() async {
    String uri = "http://10.0.2.2/practice_api/update_record.php";
    try {
      var res = await http.post(Uri.parse(uri), body: {
        "tid": tid.text,
        "cnum": cnum.text,
        "cname": cname.text,
      });
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("Record Updated");
        getrecord(); //This function call is to reflect the updation of a record on live
      } else {
        print("Some issues");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getrecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back)),
      ),
      body:
          //Without using datatable to display the table values
          // ListView.builder(
          //   itemCount: data.length,
          //   itemBuilder: (context, index) {
          //     return Card(
          //       margin: const EdgeInsets.all(10),
          //       child: SingleChildScrollView(
          //         padding: EdgeInsets.all(10),
          //         scrollDirection: Axis.horizontal,
          //         child: Row(
          //           children: [
          //             Text(data[index]["tid"]),
          //             SizedBox(width: 10),
          //             Text(data[index]["cnum"]!=null?data[index]["cnum"]:""),
          //             SizedBox(width: 10),
          //             Text(data[index]["cname"]!=null?data[index]["cname"]:""),
          //             SizedBox(width: 10),
          //             Text(data[index]["date"]!=null?data[index]["date"]:""),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // ),
          SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Text('Tracking Id')),
              DataColumn(label: Text('Consignment No')),
              DataColumn(label: Text('Name of the Courier')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('')), //Actions
            ],
            rows: data.map((record) {
              return DataRow(
                mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
                color: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    if (selectedIndex == data.indexOf(record)) {
                      return Colors.grey
                          .shade300; // Highlight color for the selected row
                    }
                    return null; // Use default color
                  },
                ),
                cells: <DataCell>[
                  DataCell(Text(record.tid)),
                  DataCell(cell(record.cnum ?? "", cnum, "Consignment No",
                      data.indexOf(record))),
                  DataCell(cell(record.cname ?? "", cname, "Courier Name",
                      data.indexOf(record))),
                  DataCell(Text(
                    record.date != null
                        ? DateFormat('dd/MM/yyyy hh:mm:ss').format(record.date!)
                        : "N/A",
                  )),
                  DataCell(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (selectedIndex == data.indexOf(record) &&
                                ((cnum.text != record.cnum ||
                                    cname.text != record.cname))) {
                              updaterecord();
                            }
                            setState(() {
                              if (selectedIndex == data.indexOf(record)) {
                                selectedIndex = null;
                              } else {
                                selectedIndex = data.indexOf(record);
                                tid.text = record.tid;
                                cnum.text = record.cnum ?? "";
                                cname.text = record.cname ?? "";
                              }
                            });
                          },
                          icon: Icon(selectedIndex == data.indexOf(record)
                              ? Icons.check_circle
                              : Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            deleterecord(record.tid);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget cell(
      String e, TextEditingController controller, String hintText, int index) {
    if (selectedIndex == index) {
      controller.text = e;
      return TextFormField(
        controller: controller,
        decoration: InputDecoration(hintText: hintText),
      );
    } else {
      return Text(e);
    }
  }
}
