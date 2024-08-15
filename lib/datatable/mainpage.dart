import "package:flutter/material.dart";
import 'courier.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Courier> data = List.from(couriers);
  bool isSortedAsc = true;
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox.expand(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: DataTable(
              sortColumnIndex: 2,
              sortAscending: false,
              columns: columns(),
              rows: rows(),
            ),
          ),
        ),
      ),
    );
  }

  List<DataColumn> columns() {
    return [
      const DataColumn(
        label: Text("Tracking ID"),
      ),
      const DataColumn(
        label: Text("Consignment Number"),
      ),
      DataColumn(
        label: const Text("Name of the Courier"),
        onSort: (columnIndex, _) {
          setState(() {
            if (isSortedAsc) {
              data.sort(
                (a, b) => a.cname.compareTo(b.cname),
              );
            } else {
              data.sort(
                (a, b) => b.cname.compareTo(a.cname),
              );
            }
            isSortedAsc = !isSortedAsc;
          });
        },
      ),
      DataColumn(
        label: const Text("Date"),
        onSort: (columnIndex, _) {
          setState(() {
            if (isSortedAsc) {
              data.sort(
                (a, b) => a.date.compareTo(b.date),
              );
            }else {
              data.sort(
                (a, b) => b.date.compareTo(a.date),
              );
            }
            isSortedAsc = !isSortedAsc;
          });
        },
      ),
    ];
  }

  List<DataRow> rows() {
    return data.map((e) {
      return DataRow(cells: [
        DataCell(
          Text(e.tid.toString()),
        ),
        DataCell(
          Text(e.cnum.toString()),
        ),
        DataCell(
          Text(e.cname.toString()),
        ),
        DataCell(
          //Text(e.date.toString()),
          cell(e.date.toString(), dateController, "Date"),
        ),
      ]);
    }).toList();
  }

  Widget cell(String e, TextEditingController controller, String hintText) {
    if (e != "") {
      return Text(e);
    } else {
      return TextFormField(
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
            hintText: hintText,),
      );
    }
  }
}
