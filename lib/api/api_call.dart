import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gym_admin/dashboard/attendance/attendance_list.dart';
import 'package:gym_admin/dashboard/meal_plan/model/meal_plan.dart';
import 'package:gym_admin/dashboard/meal_plan/model/timing_response.dart';
import 'package:gym_admin/dashboard/meal_plan/model/upload_meal_plan.dart';
import 'package:gym_admin/dashboard/settings/profile/profile_detail_response.dart';
import 'package:gym_admin/dashboard/settings/user_crud/model/add_user_response.dart';
import 'package:gym_admin/dashboard/settings/workout_crud/model/workout_create_model.dart';
import 'package:gym_admin/dashboard/user_upload/model/user_upload_image.dart';
import 'package:gym_admin/dashboard/user_upload/model/user_upload_meal_list.dart';
import 'package:gym_admin/dashboard/workout_plan/model/workout_plan_response.dart';
import 'package:gym_admin/data/session_manager.dart';
import 'package:gym_admin/pre_dashboard/model/login_response.dart';
import 'package:gym_admin/widget/custom_loading.dart';
import 'package:http/http.dart' as http;

import 'api_path.dart';



class ApiCall {
  static const String _token = "token";
  static const String _tokenStart = "AMBION ";
  static final ApiCall _apiCall = ApiCall._internal();
  static const  int  responseSuccess=1;
  static const  int  responseFail=0;
  factory ApiCall() {
    return _apiCall;
  }

  ApiCall._internal();

  Future<UpdatedMessage> addUser(AddUserRequest  request, context) async {
    CustomLoading _loading = CustomLoading(context);
    try {
      _loading.show(content: 'loading');
      final response = await http.post(ApiPath.addUser,
          headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          _token : "$_tokenStart${await SessionManager().getToken()}"
          },
          body: jsonEncode(request.toJson()));
      debugPrint(response.body);
      _loading.hide();
      return UpdatedMessage.fromJson(jsonDecode(response.body));
    } on SocketException {
      if (_loading.isShowing()) _loading.hide();
      return throw "NoInternet Connection";
    }
  }

  Future<UpdatedMessage> updateProfile(AddUserRequest  request, context) async {
    CustomLoading _loading = CustomLoading(context);
    try {
      _loading.show(content: 'loading');
      final response = await http.post(ApiPath.updateUser,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            _token : "$_tokenStart${await SessionManager().getToken()}"
          },
          body: jsonEncode(request.toJson()));
      debugPrint(response.request.toString());
      debugPrint(request.toJson().toString());
      debugPrint(response.body);
      _loading.hide();
      return UpdatedMessage.fromJson(jsonDecode(response.body));
    } on SocketException {
      if (_loading.isShowing()) _loading.hide();
      return throw "NoInternet Connection";
    }
  }

  Future<UpdatedMessage> addWorkout(Workout  request, context) async {
    CustomLoading _loading = CustomLoading(context);
    try {
      _loading.show(content: 'loading');
      final response = await http.post(ApiPath.workoutCreate,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            _token : "$_tokenStart${await SessionManager().getToken()}"
          },
          body: jsonEncode(request.toJson()));
      debugPrint(response.body);
      _loading.hide();
      return UpdatedMessage.fromJson(jsonDecode(response.body));
    } on SocketException {
      if (_loading.isShowing()) _loading.hide();
      return throw "NoInternet Connection";
    }
  }

  Future<UpdatedMessage> addMeal(Workout  request, context) async {
    CustomLoading _loading = CustomLoading(context);
    try {
      _loading.show(content: 'loading');
      final response = await http.post(ApiPath.mealCreate,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            _token : "$_tokenStart${await SessionManager().getToken()}"
          },
          body: jsonEncode(request.toJson()));
      debugPrint(request.toJson().toString());
      debugPrint(response.request.toString());
      debugPrint(response.body);
      _loading.hide();
      return UpdatedMessage.fromJson(jsonDecode(response.body));
    } on SocketException {
      if (_loading.isShowing()) _loading.hide();
      return throw "NoInternet Connection";
    }
  }

  Future<ProfileDetailsResponse> profile() async {
    try {
      final response = await http.get(Uri.parse("${ApiPath.profile}${await SessionManager().getId()}"),
          headers: {
            _token : "$_tokenStart${await SessionManager().getToken()}"
          },);

      debugPrint(response.request.toString());
      debugPrint(response.body);
      return ProfileDetailsResponse.fromJson(jsonDecode(response.body));
    } on SocketException {
      return throw "NoInternet Connection";
    }
  }

  Future<LoginResponse> getLogin(String  request, context) async {
    CustomLoading _loading = CustomLoading(context);
    try {
      _loading.show(content: 'loading');
      final response = await http.post(ApiPath.login  ,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "mobile": request
          }));
      debugPrint(response.body);
      _loading.hide();
      return LoginResponse.fromJson(jsonDecode(response.body));
    } on SocketException {
      if (_loading.isShowing()) _loading.hide();
      return throw "NoInternet Connection";
    }
  }


  Future<UpdatedMessage> mealAssign(String  planId,String userId,String trainerId, context) async {
    CustomLoading _loading = CustomLoading(context);
    try {
      _loading.show(content: 'loading');
      final response = await http.post(ApiPath.mealPlanAssign  ,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "plan_id": planId,
            "user_id": userId,
            "trainer_id": trainerId
          }));
      debugPrint(response.body);
      _loading.hide();
      return UpdatedMessage.fromJson(jsonDecode(response.body));
    } on SocketException {
      if (_loading.isShowing()) _loading.hide();
      return throw "NoInternet Connection";
    }
  }

  Future<UpdatedMessage> workAssign(String  planId,String userId,String trainerId, context) async {
    CustomLoading _loading = CustomLoading(context);
    try {
      _loading.show(content: 'loading');
      final response = await http.post(ApiPath.workPlanAssign  ,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "plan_id": planId,
            "user_id": userId,
            "trainer_id": trainerId
          }));
      debugPrint(response.body);
      _loading.hide();
      return UpdatedMessage.fromJson(jsonDecode(response.body));
    } on SocketException {
      if (_loading.isShowing()) _loading.hide();
      return throw "NoInternet Connection";
    }
  }

  Future<ProfileDetailsResponse> userList() async {
    try {
      final response = await http.get(Uri.parse("${ApiPath.userList}${await SessionManager().getId()}"),
    headers: {
    _token : "$_tokenStart${await SessionManager().getToken()}"
    },);

    debugPrint(response.request.toString());
    debugPrint(response.body);
    return ProfileDetailsResponse.fromJson(jsonDecode(response.body));
    } on SocketException {
    return throw "NoInternet Connection";
    }
  }


  Future<TimingResponse> scheduleList() async {
    try {
      final response = await http.get(Uri.parse("${ApiPath.scheduleList}"),
        headers: {
          _token : "$_tokenStart${await SessionManager().getToken()}"
        },);

      debugPrint(response.request.toString());
      debugPrint(response.body);
      return TimingResponse.fromJson(jsonDecode(response.body));
    } on SocketException {
      return throw "NoInternet Connection";
    }
  }

  Future<UpdatedMessage> uploadWorkoutPlan(context,UploadPlanRequest request) async {
  CustomLoading _loading = CustomLoading(context);
  try {
  _loading.show(content: 'loading');
  final response = await http.post(ApiPath.uploadWorkoutPlan  ,
  headers: {
  'Content-Type': 'application/json; charset=UTF-8',
  },
  body: json.encode(request.toJson()));
  debugPrint(request.toJson().toString());
  debugPrint(response.body);
  _loading.hide();
  return UpdatedMessage.fromJson(jsonDecode(response.body));
  } on SocketException {
  if (_loading.isShowing()) _loading.hide();
  return throw "NoInternet Connection";}
}

  Future<UpdatedMessage> uploadMealPlan(context,UploadPlanRequest request) async {
    CustomLoading _loading = CustomLoading(context);
    try {
      _loading.show(content: 'loading');
      final response = await http.post(ApiPath.uploadMealPlan  ,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(request.toJson()));
      debugPrint(response.request.toString());
      debugPrint(request.toJson().toString());
      debugPrint(response.body);
      _loading.hide();
      return UpdatedMessage.fromJson(jsonDecode(response.body));
    } on SocketException {
      if (_loading.isShowing()) _loading.hide();
      return throw "NoInternet Connection";}
  }

  Future<UpdatedMessage> addAttendance(context,String userId,bool isApprove,) async {
    CustomLoading _loading = CustomLoading(context);
    try {
      _loading.show(content: 'loading');
      final response = await http.post(ApiPath.addAttendance  ,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "user_id":userId,
            "trainer_id": await SessionManager().getId(),
            "status":isApprove ? "Present" : "Absent"
          }));
      debugPrint(response.body);
      _loading.hide();
      return UpdatedMessage.fromJson(jsonDecode(response.body));
    } on SocketException {
      if (_loading.isShowing()) _loading.hide();
      return throw "NoInternet Connection";}
  }

  Future<UpdatedMessage> imageApproveOrReject(context,String userId, String mailId,bool isApprove) async {
    CustomLoading _loading = CustomLoading(context);
    try {
      _loading.show(content: 'loading');
      final response = await http.post(ApiPath.approveOrReject  ,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "user_id":userId,
            "meal_id":mailId,
            "image_status":isApprove ? 1 : 0,
            "status" : isApprove ? "Approved" : "Rejected"
          }));
      debugPrint(response.body);
      _loading.hide();
      return UpdatedMessage.fromJson(jsonDecode(response.body));
    } on SocketException {
      if (_loading.isShowing()) _loading.hide();
      return throw "NoInternet Connection";}
  }

  Future<AttendanceList> getAttendanceList() async {
    try {
      final response = await http.get(Uri.parse("${ApiPath.attendanceList}${await SessionManager().getId()}"),
    headers: {
    _token : "$_tokenStart${await SessionManager().getToken()}"
    },);

    debugPrint(response.request.toString());
    debugPrint(response.body);
    return AttendanceList.fromJson(jsonDecode(response.body));
    } on SocketException {
    return throw "NoInternet Connection";
    }
  }

  Future<WorkoutPlanResponse> workoutPlansList() async {
    try {
      final response = await http.get(Uri.parse("${ApiPath.workPlanList}${await SessionManager().getId()}"),
        headers: {
          _token : "$_tokenStart${await SessionManager().getToken()}"
        },);

      debugPrint(response.request.toString());
      debugPrint(response.body);
      return WorkoutPlanResponse.fromJson(jsonDecode(response.body));
    } on SocketException {
      return throw "NoInternet Connection";
    }
  }

  Future<PlanResponse> mealPlanList() async {
    try {
      final response = await http.get(Uri.parse("${ApiPath.mealPlanList}${await SessionManager().getId()}"),
        headers: {
          _token : "$_tokenStart${await SessionManager().getToken()}"
        },);

      debugPrint(response.request.toString());
      debugPrint(response.body);
      return PlanResponse.fromJson(jsonDecode(response.body));
    } on SocketException {
      return throw "NoInternet Connection";
    }
  }


  Future<LoginResponse> otpVerification(context,String otp) async {
    CustomLoading _loading = CustomLoading(context);
    try {
      _loading.show(content: 'loading');
      final response = await http.post(ApiPath.otpVerification  ,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "trainer" : await SessionManager().getId(),
            "otp" : otp
          }));
      debugPrint(await SessionManager().getId() + otp);
      debugPrint(response.body);
      _loading.hide();
      return LoginResponse.fromJson(jsonDecode(response.body));
    } on SocketException {
      if (_loading.isShowing()) _loading.hide();
      return throw "NoInternet Connection";}
  }
  
  Future<WorkoutListResponse> workoutList() async {
    try {
      final response = await http.get(Uri.parse("${ApiPath.workoutList}${await SessionManager().getId()}"),
        headers: {
          _token : "$_tokenStart${await SessionManager().getToken()}"
        },);

      debugPrint(response.request.toString());
      debugPrint(response.body);
      return WorkoutListResponse.fromJson(jsonDecode(response.body));
    } on SocketException {
      return throw "NoInternet Connection";
    }
  }

  Future<WorkoutListResponse> mealList() async {
    try {
      final response = await http.get(Uri.parse("${ApiPath.mealList}${await SessionManager().getId()}"),
        headers: {
          _token : "$_tokenStart${await SessionManager().getToken()}"
        },);

      debugPrint(response.request.toString());
      debugPrint(response.body);
      return WorkoutListResponse.fromJson(jsonDecode(response.body));
    } on SocketException {
      return throw "NoInternet Connection";
    }
  }

  Future<UserUploadMealResponse> userUploadedMealList() async {
    try {
      final response = await http.get(Uri.parse("${ApiPath.todayList}${await SessionManager().getId()}"),
        headers: {
          _token : "$_tokenStart${await SessionManager().getToken()}"
        },);

      debugPrint(response.request.toString());
      debugPrint(response.body);
      return UserUploadMealResponse.fromJson(jsonDecode(response.body));
    } on SocketException {
      return throw "NoInternet Connection";
    }
  }

  Future<UserUploadImage> userUploadedImage(String? mealId) async {
    try {
      final response = await http.get(Uri.parse("${ApiPath.uploadedImage}$mealId"),
        headers: {
          _token : "$_tokenStart${await SessionManager().getToken()}"
        },);

      debugPrint(response.request.toString());
      debugPrint(response.body);
      return UserUploadImage.fromJson(jsonDecode(response.body));
    } on SocketException {
      return throw "NoInternet Connection";
    }
  }

  // Future<UserUpdated> userUpdated(String  name,String email,String address,  context) async {
  //   CustomLoading _loading = CustomLoading(context);
  //   try {
  //     _loading.show(content: 'loading');
  //     final response = await http.post(ApiPath.UserUpdate,
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'token': 'ambion eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjE3MjUzZTFlZmJmYWFmMTZjZjdlNWEyIiwiaWF0IjoxNjM2Nzg4MjcxfQ.LeP0pAuzpp_Sl20VXlZwXvIXfRTZTNIa-935xWSIiuI',
  //         },
  //         body: json.encode({
  //           "user_id":"618dc50c1ade82207c950b8c",
  //           "mail_id":email,
  //           "name":name,
  //           "address":address
  //         }));
  //
  //
  //
  //     _loading.hide();
  //     return UserUpdated.fromJson(jsonDecode(response.body));
  //   } on SocketException {
  //     if (_loading.isShowing()) _loading.hide();
  //     return throw "NoInternet Connection";
  //   }
  // }

  // Future <List<Paymentpage>> fetchData() async {
  //
  //
  //   final response = await http
  //       .get(ApiPath.payment );
  //
  //   if (response.statusCode == 200) {
  //     List jsonResponse = json.decode(response.body);
  //     return jsonResponse.map((data) => new Paymentpage.fromJson(data)).toList();
  //   } else {
  //     throw Exception('Unexpected error occured!');
  //   }
  // }



  // Future<Userprofile> userdataprofile() async {
  //   final response = await http
  //       .get(ApiPath.Userprofile,
  //
  //       headers: {
  //
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'token': 'ambion eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjE3MjUzZTFlZmJmYWFmMTZjZjdlNWEyIiwiaWF0IjoxNjM2Nzg4MjcxfQ.LeP0pAuzpp_Sl20VXlZwXvIXfRTZTNIa-935xWSIiuI',
  //       }
  //
  //   );
  //
  //   if (response.statusCode == 200) {
  //     return Userprofile.fromJson(jsonDecode(response.body));
  //   }
  //   else {
  //
  //     throw Exception('Failed to load Userprofile');
  //   }
  // }

//
//   Future<UpdatedMessage> addCustomer(AddCustomer request, context) async {
//     CustomLoading _loading = CustomLoading(context);
//     try {
//       _loading.show();
//       final response = await http.post(ApiPath.addCustomer, body: request.toMap());
//       if (response.statusCode == 200) {
//         _loading.hide();
//         return UpdatedMessage.fromJson(jsonDecode(response.body));
//       }
//       _loading.hide();
//       return validateError(response);
//     } on SocketException {
//       if (_loading.isShowing()) _loading.hide();
//       return throw "NoInternet Connection";
//     }
//   }
//
//   Future<UpdatedMessage> editCustomer(AddCustomer request, context) async {
//     CustomLoading _loading = CustomLoading(context);
//     try {
//       _loading.show();
//       final response = await http.post(ApiPath.editCustomer , body: request.toEditMap());
//       if (response.statusCode == 200) {
//         _loading.hide();
//         return UpdatedMessage.fromJson(jsonDecode(response.body));
//       }
//       _loading.hide();
//       return validateError(response);
//     } on SocketException {
//       if (_loading.isShowing()) _loading.hide();
//       return throw "NoInternet Connection";
//     }
//   }
//
//   Future<InvoiceList> getReportList(String type) async {
//     try {
//       final response = await http.post(ApiPath.reports, body: {
//         _token: await SessionManager().getToken(),
//         //  _token : "1542f43f889faa862e8b15bb0f71b41f",
//         "type"  : type
//       });
//       if (response.statusCode == 200) {
//         debugPrint(jsonDecode(response.body).toString());
//         return InvoiceList.fromJson(jsonDecode(response.body));
//       }
//       return validateError(response);
//     } on SocketException {
//       return throw "No Internet Connection";
//     }
//   }
//
//   Future<InvoiceList> getReportDateList(String type,String fromDate,String endDate) async {
//
//     print(await SessionManager().getToken());
//
//     try {
//       final response = await http.post(ApiPath.reports, body: {
//         _token: await SessionManager().getToken(),
//         "startDate" : fromDate,
//         "endDate": endDate,
//         //  _token : "1542f43f889faa862e8b15bb0f71b41f",
//         "type"  : type
//       });
//       if (response.statusCode == 200) {
//         debugPrint(jsonDecode(response.body).toString());
//         return InvoiceList.fromJson(jsonDecode(response.body));
//       }
//       return validateError(response);
//     } on SocketException {
//       return throw "No Internet Connection";
//     }
//   }
//
//   Future<CustomerList> getCustomerList() async {
//     try {
//       final response = await http.post(ApiPath.customerLst, body: {
//         _token: await SessionManager().getToken(),
//       });
//       if (response.statusCode == 200) {
//         debugPrint(jsonDecode(response.body).toString());
//         return CustomerList.fromJson(jsonDecode(response.body));
//       }
//       return validateError(response);
//     } on SocketException {
//       return throw "No Internet Connection";
//     }
//   }
//
//   Future<CustomerList> getSearchCustomerList(String search) async {
//     try {
//       final response = await http.post(ApiPath.searchCustomer, body: {
//         _token: await SessionManager().getToken(),
//         "search" : search
//       });
//       if (response.statusCode == 200) {
//         debugPrint(jsonDecode(response.body).toString());
//         return CustomerList.fromJson(jsonDecode(response.body));
//       }
//       return validateError(response);
//     } on SocketException {
//       return throw "No Internet Connection";
//     }
//   }
//
//   Future<LoginResponse> registerRequest(
//       RegisterRequest request, context) async {
//     CustomLoading _loading = CustomLoading(context);
//     final response = await http.post(
//       ApiPath.signUp,
//       body: request.toMap(),
//     );
//     if (response.statusCode == 200) {
//       _loading.hide();
//       return LoginResponse.fromJson(jsonDecode(response.body));
//     }
//     _loading.hide();
//     return validateError(response);
//   }
//
//   Future<UpdatedMessage> setLanguage(String languageId, context) async {
//     CustomLoading _loading = CustomLoading(context);
//     try {
//       _loading.show();
//       final response = await http.post(ApiPath.languageChange, body: {
//         _token: await SessionManager().getToken(),
//         "preferredLanguage": languageId,
//       });
//       if (response.statusCode == 200) {
//         _loading.hide();
//         return UpdatedMessage.fromJson(jsonDecode(response.body));
//       }
//       _loading.hide();
//       return validateError(response);
//     } on SocketException {
//       if (_loading.isShowing()) _loading.hide();
//       return throw "NoInternet Connection";
//     }
//   }
//
//   Future<UpdatedMessage> changePassword(
//       Map<String, dynamic> map, context) async {
//     CustomLoading _loading = CustomLoading(context);
//     try {
//       _loading.show();
//       final response = await http.post(ApiPath.changePassword, body: map);
//       if (response.statusCode == 200) {
//         _loading.hide();
//         return UpdatedMessage.fromJson(jsonDecode(response.body));
//       }
//       _loading.hide();
//       return validateError(response);
//     } on SocketException {
//       if (_loading.isShowing()) _loading.hide();
//       return throw "NoInternet Connection";
//     }
//   }
//
//   Future<UpdatedMessage> forgotPassword(String email, context) async {
//     CustomLoading _loading = CustomLoading(context);
//     try {
//       _loading.show();
//       final response = await http.post(ApiPath.forgotPassword, body: {
//         "email": email,
//         "preferredLanguage": await getLanguageIndex(),
//       });
//       if (response.statusCode == 200) {
//         _loading.hide();
//         return UpdatedMessage.fromJson(jsonDecode(response.body));
//       }
//       _loading.hide();
//       return validateError(response);
//     } on SocketException {
//       if (_loading.isShowing()) _loading.hide();
//       return throw "NoInternet Connection";
//     }
//   }
//
//   // Future<CardRequest> prefillProfile() async {
//   //   final response = await http.post(
//   //     ApiPath.profilePrefill,
//   //     body: {
//   //       _token: await SessionManager().getToken(),
//   //     },
//   //   );
//   //
//   //   if (response.statusCode == 200) {
//   //     return CardRequest.fromJson(jsonDecode(response.body));
//   //   }
//   //   return validateError(response);
//   // }
//
//   // Future<UpdatedMessage> updateProfile(
//   //     ProfileUpdateRequest request, context) async {
//   //   CustomLoading _loading = CustomLoading(context);
//   //   try {
//   //     _loading.show();
//   //     final response =
//   //         await http.post(ApiPath.profileUpdate, body: request.toMap());
//   //     if (response.statusCode == 200) {
//   //       _loading.hide();
//   //       return UpdatedMessage.fromJson(jsonDecode(response.body));
//   //     }
//   //     _loading.hide();
//   //     return validateError(response);
//   //   } on SocketException {
//   //     if (_loading.isShowing()) _loading.hide();
//   //     return throw "NoInternet Connection";
//   //   }
//   // }
//
//
//   Future addImage(List<File> imageFiles) async {
//     var uri = Uri.parse("http://rd.mjal.sa/api/v2/Order/test");
//
//     var request = http.MultipartRequest("POST", uri);
//
//     for (File imageFile in imageFiles) {
//       var stream =
//       http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
//       var length = await imageFile.length();
//
//       var multipartFile =  http.MultipartFile("image", stream, length,
//           filename: basename(imageFile.path));
//
//       request.files.add(multipartFile);
//     }
//
//     var respond = await request.send();
//     if (respond.statusCode == 200) {
//       print("Image Uploaded");
//     } else {
//       print("Upload Failed");
//     }
//   }
//
//
//   // Future<TermsAndConditionResponse> termsAndCond() async {
//   //   final response = await http.post(
//   //     ApiPath.termsAndCondition,
//   //     body: {
//   //       _token: await SessionManager().getToken(),
//   //     },
//   //   );
//   //
//   //   if (response.statusCode == 200) {
//   //     print(jsonDecode(response.body));
//   //     return TermsAndConditionResponse.fromJson(jsonDecode(response.body));
//   //   }
//   //   return validateError(response);
//   // }
//
//
//   // Future<String> apiImage(File file) async {
//   //   List<int> imageBytes = file.readAsBytesSync();
//   //   String base64Image = base64Encode(imageBytes);
//   //   print(base64Image);
//   //
//   //   Dio dio = Dio();
//   //
//   //   dio.interceptors.add(LogInterceptor(responseBody: false, requestBody: true,));
//   //
//   //   final response = await dio.post(
//   //     ApiPath.baseImage.toString(),
//   //     data: {
//   //       "image" : base64Image,
//   //       "name" : basename(file.path)
//   //     },
//   //   );
//   //
//   //   if (response.statusCode == 200) {
//   //     print(jsonDecode(response.data));
//   //     return response.data;
//   //   }
//   //   throw response.data;
//   // }
//
  // Future<UpdatedMessage> contactUs(
  //     ContactUsRequest request, BuildContext context) async {
  //   CustomLoading _loading = CustomLoading(context);
  //   try {
  //     _loading.show();
  //
  //     final response = await http.post(
  //       ApiPath.contactIUs,
  //       body: request.toMap(),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       _loading.hide();
  //       return UpdatedMessage.fromJson(jsonDecode(response.body));
  //     }
  //     _loading.hide();
  //     return validateError(response);
  //   } on SocketException {
  //     if (_loading.isShowing()) _loading.hide();
  //     return throw "NoInternet Connection";
  //   }
  // }

  // Future<ContactDetailsModel> getContactDetails() async {
  //   try {
  //     final response = await http.post(ApiPath.getContactDetails, body: {
  //       _token: await SessionManager().getToken(),
  //     });
  //     if (response.statusCode == 200) {
  //       print(response.body);
  //       return ContactDetailsModel.fromJson(jsonDecode(response.body));
  //     }
  //     return validateError(response);
  //   } on SocketException {
  //     return throw "NoInternet Connection";
  //   }
  // }

  validateError(http.Response response) {
    if (response.statusCode == 500) {
      return throw "Internal Server Error";
    }
    return throw response.body.toString();
  }

}

/*Future<UpdatedMessage> submitInvoice(
      {
        String customerId,
        String invoiceNumber,
        String invoiceAmount,
        String invoiceDate,
        String tax,
        String type,
        String total,
        List<File> images }) async {
    var uri = ApiPath.invoiceUpload;

    var request = http.MultipartRequest('POST', uri);
    for (int i = 0; i < images.length; i++) {
      request.files.add(
        http.MultipartFile(
          'invoiceImage[]',
          http.ByteStream(DelegatingStream.typed(images[i].openRead())),
          await images[i].length(),
          filename: basename(images[i].path),
        ),
      );
    }
    request.fields["token"] = (await SessionManager().getToken())!;
    request.fields["invoiceNumber"] = invoiceNumber;
    request.fields["invoiceAmount"] = invoiceAmount;
    request.fields["invoiceDate"] = invoiceDate;
    request.fields["customerId"] = customerId;
    request.fields["tax"] = tax;
    request.fields["type"] = type;
    request.fields["total"] = total;

    var response = await request.send();
    print(response.statusCode);
    Stream<String> value = response.stream.transform(utf8.decoder);

    return UpdatedMessage.fromJson(jsonDecode(await value.first));

  }


*/

class UpdatedMessage {
  String message;
  int status;

  UpdatedMessage({required this.message,required this.status});

  factory UpdatedMessage.fromJson(Map<String, dynamic> json) => UpdatedMessage(
    message : json["message"],
    status : json["status"],
  );


}



