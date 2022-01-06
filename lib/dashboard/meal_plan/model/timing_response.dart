// To parse this JSON data, do
//
//     final timingResponse = timingResponseFromJson(jsonString);

import 'dart:convert';

TimingResponse timingResponseFromJson(String str) => TimingResponse.fromJson(json.decode(str));

String timingResponseToJson(TimingResponse data) => json.encode(data.toJson());

class TimingResponse {
  TimingResponse({
    required this.status,
    required this.data,
  });

  int status;
  List<Datum> data;

  factory TimingResponse.fromJson(Map<String, dynamic> json) => TimingResponse(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.mealDay,
    required this.mealTime,
  });

  String mealDay;
  List<MealTime> mealTime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    mealDay: json["meal_day"],
    mealTime: List<MealTime>.from(json["meal_time"].map((x) => MealTime.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meal_day": mealDay,
    "meal_time": List<dynamic>.from(mealTime.map((x) => x.toJson())),
  };
}

class MealTime {
  MealTime({
    required this.mealName,
    required this.mealPeriod,
  });

  String mealName;
  String mealPeriod;

  factory MealTime.fromJson(Map<String, dynamic> json) => MealTime(
    mealName: json["meal_name"],
    mealPeriod: json["meal_period"],
  );

  Map<String, dynamic> toJson() => {
    "meal_name": mealName,
    "meal_period": mealPeriod,
  };
}
