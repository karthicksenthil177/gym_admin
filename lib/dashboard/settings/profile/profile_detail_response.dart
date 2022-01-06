class ProfileDetailsResponse {
  ProfileDetailsResponse({required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<UserDetails> data;

  factory ProfileDetailsResponse.fromJson(Map<String, dynamic> json) => ProfileDetailsResponse(
    status: json["status"],
    message: json["message"],
    data: List<UserDetails>.from(json["data"].map((x) => UserDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UserDetails {
  UserDetails({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
  });

  String id;
  String name;
  String mobile;
  String email;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    id: json["_id"],
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "mobile": mobile,
    "email": email,
  };
}
