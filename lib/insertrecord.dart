// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mydbapp/viewrecord.dart';

class InsertRecord extends StatelessWidget {
  InsertRecord({super.key});

  final TextEditingController tid = TextEditingController();
  final TextEditingController cnum = TextEditingController();
  final TextEditingController cname = TextEditingController();

  Future<void> insertrecord() async {
    if (tid.text != "" && cnum.text != "" && cname.text != "") {
      String uri = "http://10.0.2.2/practice_api/insert_record.php";
      try {
        var res = await http.post(Uri.parse(uri), body: {
          "tid": tid.text,
          "cnum": cnum.text,
          "cname": cname.text,
        });
        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          print("Record Inserted");
          tid.text = "";
          cnum.text = "";
          cname.text = "";
        } else {
          print("Some issues");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Please fill all the fields!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextFormField(text: "Tracking ID", controller: tid),
              MyTextFormField(text: "Consignment Number", controller: cnum),
              MyTextFormField(text: "Name of the Courier", controller: cname),
              Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    insertrecord();
                  },
                  child: const Text("Insert Record"),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const ViewRecord(),
                      ),
                    );
                  },
                  child: const Text("View Records"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    required this.text,
    required this.controller,
  });
  final String text;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueAccent,
            ),
          ),
          label: Text(text),
        ),
      ),
    );
  }
}
