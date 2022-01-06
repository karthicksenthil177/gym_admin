// To parse this JSON data, do
//
//     final workoutPlan = workoutPlanFromJson(jsonString);

import 'dart:convert';

WorkoutPlanResponse workoutPlanFromJson(String str) => WorkoutPlanResponse.fromJson(json.decode(str));

String workoutPlanToJson(WorkoutPlanResponse data) => json.encode(data.toJson());

class WorkoutPlanResponse {
  WorkoutPlanResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory WorkoutPlanResponse.fromJson(Map<String, dynamic> json) => WorkoutPlanResponse(
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
    required this.id,
    required this.workoutPlan,
  });

  String id;
  WorkoutPlan workoutPlan;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    workoutPlan: WorkoutPlan.fromJson(json["workout_plan"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "workout_plan": workoutPlan.toJson(),
  };
}

class WorkoutPlan {
  WorkoutPlan({
    required  this.planName,
    required this.planPurpose,
    required this.id,
  });

  String planName;
  String planPurpose;
  String id;

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) => WorkoutPlan(
    planName: json["plan_name"],
    planPurpose: json["plan_purpose"],
    id: json["_id"]
  );

  Map<String, dynamic> toJson() => {
    "plan_name": planName,
    "plan_purpose": planPurpose,
    "_id" : id
  };
}
