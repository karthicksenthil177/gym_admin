import 'package:flutter/material.dart';
import 'package:gym_admin/api/api_call.dart';
import 'package:gym_admin/dashboard/dashboard.dart';
import 'package:gym_admin/dashboard/settings/user_crud/model/add_user_response.dart';
import 'package:gym_admin/data/session_manager.dart';
import 'package:gym_admin/util.dart';
import 'package:gym_admin/widget/app_bar.dart';
import 'package:gym_admin/widget/button.dart';
import 'package:gym_admin/widget/custom_text_field.dart';

class UserCreation extends StatefulWidget {
  const UserCreation({Key? key}) : super(key: key);

  @override
  _UserCreationState createState() => _UserCreationState();
}

class _UserCreationState extends State<UserCreation> {
  final _userController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Create User",
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(defaultPaddingSize),
        child: Column(
          children: [
            CustomTextField(
              label: "Name",
              controller: _userController,
            ),
            CustomTextField(
              textInputType: TextInputType.phone,
              label: "Phone Number",
              controller: _phoneController,
            ),
            CustomTextField(
              textInputType: TextInputType.emailAddress,
              label: "Email",
              controller: _emailController,
            ),
            const SizedBox(
              height: defaultPaddingSize,
            ),
            CustomButton(callback: () {
              if(validation()) {
                callService();
              }
            }, buttonText: "Submit")
          ],
        ),
      ),
    );
  }


  validation() {
    if (_userController.text.isEmpty) {
      Util.snackBar("Please Enter User Name", context);
      return false;
    }
    if (_emailController.text.isEmpty) {
      Util.snackBar("Please Enter Email Id", context);
      return false;
    }
    if (_phoneController.text.isEmpty) {
      Util.snackBar("Please Enter Phone Number", context);
      return false;
    }
    return true;
  }


  callService() async {
    AddUserRequest request = AddUserRequest(name: _userController.text,
        mobile: _phoneController.text,
        email: _emailController.text,
        pass: "summa",
        trainerId: await SessionManager().getId());

    UpdatedMessage response = await ApiCall().addUser(request, context);

    if (response.status == ApiCall.responseSuccess) {
      Util.snackBar(response.message, context);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) {
        return const Dashboard();
      }), (route) => false);

    } else if (response.status == ApiCall.responseFail) {
      Util.snackBar(response.message, context);
    }
  }


}
