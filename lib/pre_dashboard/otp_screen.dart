import 'package:flutter/material.dart';
import 'package:gym_admin/api/api_call.dart';
import 'package:gym_admin/dashboard/dashboard.dart';
import 'package:gym_admin/data/session_manager.dart';
import 'package:gym_admin/pre_dashboard/model/login_response.dart';
import 'package:gym_admin/util.dart';
import 'package:gym_admin/widget/button.dart';

TextEditingController controller = TextEditingController();
List<TextEditingController> controllers = [];

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
    const OtpScreen({ required this.phoneNumber,Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // final int _fields = 5;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //controllers.forEach((c) => c.dispose());
    super.dispose();
  }


  Future resendOtp() async {

    LoginResponse response = await ApiCall().getLogin(widget.phoneNumber, context);
    if (response.status == ApiCall.responseSuccess) {
      Util.snackBar(response.message, context);
    } else if (response.status == ApiCall.responseFail) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.message)));
    }
  }

  /* void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPaddingSize),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                //width: 20,
              ),
              const Text(
                "OTP Verification",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: defaultPaddingSize * 2,
                //width: 20,
              ),
              /* Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [


                  for (int i = 0; i < _fields; i++)
                  Container(
                    width: 35,
                    height: 35,
                    child: TextField(
                      maxLines: 1,

                        keyboardType: TextInputType.number,
                        //autofocus: false,
                        //obscureText: true,
                      controller: controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColors.darkbule, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColors.darkbule, width: 2.0),
                        ),

                      ),
                      onChanged: (value) {


                      },

                    ),
                  ),


                  ],
              ),*/
              TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter OTP',
                  //hintText: '+91............',
                  prefixIcon: Icon(
                    Icons.password,
                    color: Colors.blue,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    Util.snackBar("Please enter valid Number!", context);
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  resendOtp();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 250),
                  child: RichText(
                    text: TextSpan(
                        text: ' Resend OTP',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                buttonText: 'Continue',
                callback: () {
                  otpVerification();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  otpVerification() async {
    if (controller.text.length == 6) {
      LoginResponse response =
          await ApiCall().otpVerification(context, controller.text);
      if (response.status == ApiCall.responseSuccess) {

        SessionManager().setLoggedInStatus(true);
        SessionManager().setInitialLoginOver(true);

        SessionManager().setToken(response.token.trim());

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => const Dashboard()),
            (Route<dynamic> route) => false);
      } else {
        Util.snackBar(response.message, context);
      }
    }
  }

/* Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Center(child: Text(text[position], style: TextStyle(color: Colors.black),)),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
      );
    }
  }*/
}
