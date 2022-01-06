class UserUploadImage {
  int status;
  String message;
  String data;

  UserUploadImage(
      {required this.data, required this.status, required this.message});

  factory UserUploadImage.fromJson(Map<String, dynamic> json) {
    return UserUploadImage(
        data: json["data"], status: json["status"], message: json["message"]);
  }
}
