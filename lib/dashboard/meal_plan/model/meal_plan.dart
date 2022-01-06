// To parse this JSON data, do
//
//     final mealPlanResponse = mealPlanResponseFromJson(jsonString);

import 'dart:convert';

PlanResponse mealPlanResponseFromJson(String str) => PlanResponse.fromJson(json.decode(str));

String mealPlanResponseToJson(PlanResponse data) => json.encode(data.toJson());

class PlanResponse {
  PlanResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory PlanResponse.fromJson(Map<String, dynamic> json) => PlanResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.mealPlan,
  });

  String id;
  MealPlan mealPlan;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    mealPlan: MealPlan.fromJson(json["meal_plan"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "meal_plan": mealPlan.toJson(),
  };
}

class MealPlan {
  MealPlan({
    required this.planName,
    required this.planPurpose,
    required this.planDays,
    required this.id,
  });

  String planName;
  String planPurpose;
  List<PlanDay> planDays;
  String id;

  factory MealPlan.fromJson(Map<String, dynamic> json) => MealPlan(
    planName: json["plan_name"],
    planPurpose: json["plan_purpose"],
    planDays: json["plan_days"] == null ? [] : List<PlanDay>.from(json["plan_days"].map((x) => PlanDay.fromJson(x))),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "plan_name": planName,
    "plan_purpose": planPurpose,
    "plan_days": List<dynamic>.from(planDays.map((x) => x.toJson())),
    "_id": id,
  };
}

class PlanDay {
  PlanDay({
    required this.mealDay,
    required this.mealTime,
    required this.id,
  });

  String mealDay;
  List<MealTime> mealTime;
  String id;

  factory PlanDay.fromJson(Map<String, dynamic> json) => PlanDay(
    mealDay: json["meal_day"] ?? "",
    mealTime: json["meal_time"] == null ? [] : List<MealTime>.from(json["meal_time"].map((x) => MealTime.fromJson(x))),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "meal_day": mealDay,
    "meal_time": List<dynamic>.from(mealTime.map((x) => x.toJson())),
    "_id": id,
  };
}

class MealTime {
  MealTime({
    required this.mealName,
    required this.mealPeriod,
    required this.mealDescription,
    required this.mealPurpose,
    required this.id,
  });

  String mealName;
  String mealPeriod;
  String mealDescription;
  String mealPurpose;
  String id;

  factory MealTime.fromJson(Map<String, dynamic> json) => MealTime(
    mealName: json["meal_name"] ?? "",
    mealPeriod: json["meal_period"] ?? "",
    mealDescription: json["meal_description"] ?? '',
    mealPurpose: json["meal_purpose"] ?? '',
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "meal_name": mealName,
    "meal_period": mealPeriod,
    "meal_description": mealDescription,
    "meal_purpose": mealPurpose,
    "_id": id,
  };
}
