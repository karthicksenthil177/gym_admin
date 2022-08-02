import 'package:flutter/material.dart';
import 'package:gym_admin/dashboard/meal_plan/shedule_days.dart';
import 'package:gym_admin/util.dart';
import 'package:gym_admin/widget/app_bar.dart';
import 'package:gym_admin/widget/button.dart';
import 'package:gym_admin/widget/custom_text_field.dart';
import 'package:gym_admin/widget/text_button.dart';

class MealPlanCreate extends StatefulWidget {
  final bool isMeal;
  const MealPlanCreate({Key? key,this.isMeal = true}) : super(key: key);

  @override
  _MealPlanCreateState createState() => _MealPlanCreateState();
}

class _MealPlanCreateState extends State<MealPlanCreate> {
  final _planNameController = TextEditingController();
  final _purposeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.isMeal ? "Create Meal Plan" : "Create Workout Plan",
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(defaultPaddingSize),
        child: Column(
          children: [
            CustomTextField(
              label: "Plan Name",
              controller: _planNameController,
            ),
            CustomTextField(
              textInputType: TextInputType.text,
              label: "Purpose",
              controller: _purposeController,
            ),
            const SizedBox(
              height: defaultPaddingSize,
            ),
            Row(children: [
              Expanded(
                child: CustomTextButton(
                    padding: 16,
                    color: Colors.white,
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    text: "Create", callback: (){
                  if(validation()) {
                    //callService();
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                      return  ScheduleDays(planName: _planNameController.text,purpose: _purposeController.text,isMeal : widget.isMeal);
                    }));
                  }
                }),
              ),
              SizedBox(width: 16,),
              Expanded(
                child: CustomTextButton(
                    padding: 16,
                    text: "Cancel", callback: (){
                      Navigator.of(context).pop();
                }),
              ),
            ],),
          ],
        ),
      ),
    );
  }


  validation() {
    if (_planNameController.text.isEmpty) {
      Util.snackBar("Please Enter Plan Name", context);
      return false;
    }
    if (_purposeController.text.isEmpty) {
      Util.snackBar("Please Enter Purpose", context);
      return false;
    }
    return true;
  }

  // callService() async {
  //   AddUserRequest request = AddUserRequest(name: _planNameController.text,
  //       mobile: _purposeController.text,
  //       email: _emailController.text,
  //       pass: "summa",
  //       trainerId: await SessionManager().getId());
  //
  //   UpdatedMessage response = await ApiCall().addUser(request, context);
  //
  //   if (response.status == ApiCall.responseSuccess) {
  //     Util.snackBar(response.message, context);
  //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) {
  //       return const Dashboard();
  //     }), (route) => false);
  //
  //   } else if (response.status == ApiCall.responseFail) {
  //     Util.snackBar(response.message, context);
  //   }
  // }
}
