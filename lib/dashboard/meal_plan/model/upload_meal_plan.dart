// To parse this JSON data, do
//
//     final uploadMealRequest = uploadMealRequestFromJson(jsonString);

import 'dart:convert';

UploadPlanRequest uploadMealRequestFromJson(String str) => UploadPlanRequest.fromJson(json.decode(str));

String uploadMealRequestToJson(UploadPlanRequest data) => json.encode(data.toJson());

class UploadPlanRequest {
  UploadPlanRequest({
    required this.trainerId,
    required this.plan,
  });

  String trainerId;
  UploadPlan plan;

  factory UploadPlanRequest.fromJson(Map<String, dynamic> json) => UploadPlanRequest(
    trainerId: json["trainer_id"],
    plan: UploadPlan.fromJson(json["plan"]),
  );

  Map<String, dynamic> toJson() => {
    "trainer_id": trainerId,
    "plan": plan.toJson(),
  };
}

class UploadPlan {
  UploadPlan({
    required this.planName,
    required this.planPurpose,
    required this.planDays,
  });

  String planName;
  String planPurpose;
  List<PlanDay> planDays;

  factory UploadPlan.fromJson(Map<String, dynamic> json) => UploadPlan(
    planName: json["plan_name"],
    planPurpose: json["plan_purpose"],
    planDays: List<PlanDay>.from(json["plan_days"].map((x) => PlanDay.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "plan_name": planName,
    "plan_purpose": planPurpose,
    "plan_days": List<dynamic>.from(planDays.map((x) => x.toJson())),
  };
}

class PlanDay {
  PlanDay({
    required this.dayName,
    required this.dayTime,
  });

  String dayName;
  List<UploadTime> dayTime;

  factory PlanDay.fromJson(Map<String, dynamic> json) => PlanDay(
    dayName: json["day_name"],
    dayTime: List<UploadTime>.from(json["day_time"].map((x) => UploadTime.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "day_name": dayName,
    "day_time": List<dynamic>.from(dayTime.map((x) => x.toJson())),
  };
}

class UploadTime {
  UploadTime({
    required this.id,
    required this.period,
    this.isActive
  });

  String id;
  String period;
  bool? isActive;

  factory UploadTime.fromJson(Map<String, dynamic> json) => UploadTime(
    id: json["id"],
    period: json["period"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "period": period,
  };
}
