class UserUploadMealResponse {
  UserUploadMealResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Meals> data;

  factory UserUploadMealResponse.fromJson(Map<String, dynamic> json) =>
      UserUploadMealResponse(
        status: json["status"],
        message: json["message"],
        data: List<Meals>.from(json["data"].map((x) => Meals.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}


class Meals {
  Meals({
    required this.date,
    required this.name,
    required this.period,
    required this.description,
    required this.purpose,
    required this.image,
    this.trainer,
    required this.status,
    this.id,
    this.userName,
    required this.imageStatus,
    this.mealId,
    this.userId
  });

  DateTime date;
  String name;
  String period;
  String description;
  String purpose;
  String image;
  String? trainer;
  String status;
  String? id;
  String? userName;
  int imageStatus;
  String? userId;
  String? mealId;

  factory Meals.fromJson(Map<String, dynamic> json) =>
      Meals(
        date: DateTime.parse(json["date"]),
        name: json["name"],
        period: json["period"],
        description: json["description"],
        purpose: json["purpose"],
        image: json["image"],
        trainer: json["trainer"] ?? "",
        status: json["status"],
        id: json["_id"] ?? "",
        userName: json["user_name"],
        imageStatus: json["image_status"],
        userId:json["user_id"],
        mealId:json["meal_id"]
      );

  Map<String, dynamic> toJson() =>
      {
        "date": date.toIso8601String(),
        "name": name,
        "period": period,
        "description": description,
        "purpose": purpose,
        "image": image,
        "trainer": trainer,
        "status": status,
        "_id": id,
      };
}
