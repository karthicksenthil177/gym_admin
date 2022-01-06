// To parse this JSON data, do
//
//     final addUserRequest = addUserRequestFromJson(jsonString);

import 'dart:convert';

AddUserRequest addUserRequestFromJson(String str) => AddUserRequest.fromJson(json.decode(str));

String addUserRequestToJson(AddUserRequest data) => json.encode(data.toJson());

class AddUserRequest {
  AddUserRequest({
    required this.name,
    required this.mobile,
    required this.email,
    required this.pass,
    required this.trainerId,
    this.address = "",
  });

  String name;
  String mobile;
  String email;
  String pass;
  String trainerId;
  String? address;

  factory AddUserRequest.fromJson(Map<String, dynamic> json) => AddUserRequest(
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    pass: json["pass"],
    trainerId: json["trainer_id"],
    address: json["address"] ?? ""
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile": mobile,
    "email": email,
    "pass": pass,
    "trainer_id": trainerId,
    "address" : address
  };
}
