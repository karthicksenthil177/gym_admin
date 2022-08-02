import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:gym_admin/api/api_call.dart';
import 'package:gym_admin/data/session_manager.dart';
import 'package:gym_admin/pre_dashboard/otp_screen.dart';
import 'package:gym_admin/util.dart';
import 'package:gym_admin/widget/button.dart';

import '../widget/text_button.dart';
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
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(defaultPaddingSize),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height : MediaQuery.of(context).size.height*0.15),
                  Image(
                    height: 250,
                    image: AssetImage(
                      ImagePath.logo,
                    ),
                    fit: BoxFit.cover,
                  ),
                 SizedBox(height : MediaQuery.of(context).size.height*0.10),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 24),
                        focusedBorder:  OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.circular(24.0),
                          borderSide:  BorderSide(color: greyColor, width: 0.0),
                        ),
                        errorBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.0),
                          // width: 0.0 produces a thin "hairline" border
                          borderSide:  BorderSide(color: greyColor, width: 0.0),
                        ),
                        disabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.0),
                          // width: 0.0 produces a thin "hairline" border
                          borderSide:  BorderSide(color: greyColor, width: 0.0),
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.0),
                          // width: 0.0 produces a thin "hairline" border
                          borderSide:  BorderSide(color: greyColor, width: 0.0),

                        ),
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        filled: true,
                        fillColor: greyColor,
                        hintText: "Mobile Number",
                        hintStyle: TextStyle(color: Colors.black87)
                    ),
                  ),
                  const SizedBox(
                    height: defaultPaddingSize,
                  ),
                  Container(
                    width: 100,
                    child: CustomTextButton(
                      padding: 12,
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      callback: () {
                        if (_formKey.currentState!.validate()) {
                          if (validate()) {
                            userLogin();
                          }
                        }
                      },
                      text: 'Next',
                    ),
                  ),
                ],
              ),
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
