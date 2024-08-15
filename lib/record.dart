class Record {
  final String tid;
  final String? cnum;
  final String? cname;
  final DateTime? date;

  Record({
    required this.tid,
    required this.cnum,
    required this.cname,
    required this.date,
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      tid: json['tid'] as String,
      cnum: json['cnum'] as String?,
      cname: json['cname'] as String?,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
  }
}
