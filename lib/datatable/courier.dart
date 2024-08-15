class Courier {
  final String tid;
  final String cnum;
  final String cname;
  final String date;

  Courier({
    required this.tid,
    required this.cnum,
    required this.cname,
    required this.date,
  });
}

List<Courier> couriers = [
  Courier(tid: "atid1", cnum: "acnum1", cname: "acname1", date: "adate1"),
  Courier(tid: "btid2", cnum: "bcnum2", cname: "bcname2", date: "bdate2"),
  Courier(tid: "ctid3", cnum: "ccnum3", cname: "ccname3", date: ""),
];
