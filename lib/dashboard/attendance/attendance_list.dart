class AttendanceList {
  AttendanceList({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory AttendanceList.fromJson(Map<String, dynamic> json) => AttendanceList(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.userName,
    required this.userId,
    required this.date,
    required this.status,
  });

  String userName;
  String userId;
  DateTime date;
  String status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    userName: json["user_name"],
    userId: json["user_id"],
    date: DateTime.parse(json["date"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "user_id": userId,
    "date": date.toIso8601String(),
    "status": status,
  };
}
