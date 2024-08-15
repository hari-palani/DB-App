import 'package:flutter/material.dart';
import 'package:mydbapp/insertrecord.dart';
import 'package:mydbapp/viewrecord.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InsertRecord(),
      routes: {
        "/view" : (context)=>const ViewRecord(),
      },
    ),
  );
}
