import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_admin/api/api_call.dart';
import 'package:gym_admin/data/session_manager.dart';
import 'package:gym_admin/pre_dashboard/otp_screen.dart';
import 'package:gym_admin/util.dart';
import 'package:gym_admin/widget/button.dart';

import 'model/login_response.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future userLogin() async {

      LoginResponse response = await ApiCall().getLogin(nameController.text, context);

      if (response.status == ApiCall.responseSuccess) {
         String value = nameController.text;

         SessionManager().setName(response.name);
         SessionManager().setId(response.id);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OtpScreen(phoneNumber : value)),
        );
      } else if (response.status == ApiCall.responseFail) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response.message)));
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPaddingSize),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                    height: 250,
                    child: Image(
                      image: AssetImage(
                        ImagePath.logo,
                      ),
                      fit: BoxFit.cover,
                    )),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                    hintText: 'Enter the Phone Number',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(
                  height: defaultPaddingSize,
                ),
                CustomButton(
                  callback: () {
                    if (_formKey.currentState!.validate()) {
                      if (validate()) {
                        userLogin();
                      }
                    }
                  },
                  buttonText: 'Next',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validate() {
    if ((nameController.text.length <10)) {
      Util.snackBar('Please enter valid Number!', context);
      return false;
    } else if (nameController.text.isEmpty) {
      Util.snackBar('Please enter the number', context);
      return false;
    }
    return true;
  }
}
