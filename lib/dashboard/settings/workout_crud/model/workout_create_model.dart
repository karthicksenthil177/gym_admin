class WorkoutListResponse {
  WorkoutListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Workout> data;

  factory WorkoutListResponse.fromJson(Map<String, dynamic> json) => WorkoutListResponse(
    status: json["status"],
    message: json["message"],
    data: List<Workout>.from(json["data"].map((x) => Workout.fromJson(x))),
  );

}

class Workout {
  Workout({
    required this.name,
    required this.description,
    required this.purpose,
    required this.status,
    this.id = "",
    this.trainerId,
  });

  String name;
  String description;
  String purpose;
  String status;
  String id;
  String? trainerId;


  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
    name: json["name"],
    description: json["description"],
    purpose: json["purpose"],
    status: json["status"],
    id: json["_id"],
    trainerId: json["trainer_id"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "purpose": purpose,
    "trainer_id": trainerId,
  };
}
