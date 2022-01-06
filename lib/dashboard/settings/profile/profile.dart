import 'package:flutter/material.dart';
import 'package:gym_admin/api/api_call.dart';
import 'package:gym_admin/dashboard/dashboard.dart';
import 'package:gym_admin/dashboard/settings/profile/profile_detail_response.dart';
import 'package:gym_admin/dashboard/settings/user_crud/model/add_user_response.dart';
import 'package:gym_admin/data/session_manager.dart';
import 'package:gym_admin/util.dart';
import 'package:gym_admin/widget/button.dart';
import 'package:gym_admin/widget/custom_text_field.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();

  bool isSwitched = false;

  Future<ProfileDetailsResponse>?  response;

  void toggleSwitch(bool value) {
    setState(() {
      isSwitched = !isSwitched;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    response = ApiCall().profile();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(color: Colors.black),),
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: backgroundColor,
      body: FutureBuilder<ProfileDetailsResponse>(
        future: response,
        builder: (BuildContext context, AsyncSnapshot<ProfileDetailsResponse> snapshot) {
        if(snapshot.hasData) {
          if(snapshot.data!.status == ApiCall.responseSuccess) {
            if(snapshot.data!.data.isEmpty) {
              return Center(child: Text(snapshot.data!.message),);
            } else {
              _nameCtrl.text = snapshot.data!.data.elementAt(0).name;
              _emailCtrl.text = snapshot.data!.data.elementAt(0).email;
              _phoneNumber.text = snapshot.data!.data.elementAt(0).mobile;
              return Padding(
                padding: const EdgeInsets.all(defaultPaddingSize),
                child: Column(
                  children: [
                  //  toggleButton(),
                    CustomTextField(controller: _nameCtrl, label: "Name"),
                    CustomTextField(controller: _emailCtrl, label: "Email"),
                    CustomTextField(controller: _phoneNumber, label: "Phone Number"),
                    const SizedBox(height: defaultPaddingSize / 2,),
                    CustomButton(callback: () {
                      if (validation()) {
                        callService();
                      }
                    }, buttonText: "Update")
                  ],
                ),
              );
            }
          }

        }
        return const Center(child: CircularProgressIndicator(),);
      },)

    );
  }

  callService() async {
    AddUserRequest request = AddUserRequest(name: _nameCtrl.text,
    mobile: _phoneNumber.text,
    email: _emailCtrl.text,
    pass: "",
    trainerId: await SessionManager().getId());

    UpdatedMessage response = await ApiCall().updateProfile(request, context);

    if (response.status == ApiCall.responseSuccess) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.message)));

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) {
        return const Dashboard();
      }), (route) => false);

    } else if (response.status == ApiCall.responseFail) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(response.message)));
    }
  }

  Widget toggleButton() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(width: defaultPaddingSize,),
              Transform.scale(
                  scale: 1.3,
                  child: SizedBox(
                    height: 20,
                    child: Switch(
                      onChanged: toggleSwitch,
                      value: isSwitched,
                    ),
                  )
              ),
              const Text("Edit", style: TextStyle(color: Colors.grey),),
              const SizedBox(
                height: defaultPaddingSize,
              ),

            ],
          ),
          const SizedBox(height: defaultPaddingSize / 2),
        ]);
  }


  validation() {
    if (_nameCtrl.text.isEmpty) {
      Util.snackBar("Please Enter User Name", context);
      return false;
    }
    if (_emailCtrl.text.isEmpty) {
      Util.snackBar("Please Enter Email Id", context);
      return false;
    }
    if (_phoneNumber.text.isEmpty) {
      Util.snackBar("Please Enter Phone Number", context);
      return false;
    }
    return true;
  }

}
