import 'package:flutter/material.dart';
import 'package:gym_admin/api/api_call.dart';
import 'package:gym_admin/dashboard/dashboard.dart';
import 'package:gym_admin/dashboard/settings/workout_crud/model/workout_create_model.dart';
import 'package:gym_admin/data/session_manager.dart';
import 'package:gym_admin/util.dart';
import 'package:gym_admin/widget/app_bar.dart';
import 'package:gym_admin/widget/button.dart';
import 'package:gym_admin/widget/custom_text_field.dart';

import '../../../widget/text_button.dart';

class MealCreate extends StatefulWidget {
  const MealCreate({Key? key}) : super(key: key);

  @override
  _MealCreateState createState() => _MealCreateState();
}

class _MealCreateState extends State<MealCreate> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _purposeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Create Meal",
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPaddingSize),
        child: Column(
          children: [
            CustomTextField(controller: _nameController, label: "Meal Name"),

            CustomTextField(
                controller: _descriptionController, label: "Description"),

            CustomTextField(controller: _purposeController, label: "Purpose"),
            const SizedBox(
              height: defaultPaddingSize / 2,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.3,
              child: CustomTextButton(
                padding: 16,
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                callback: () {
                  if (validation()) {
                    callService();
                  }
                }, text: 'Save',),
            )
          ],
        ),
      ),
    );
  }

  validation() {
    if (_nameController.text.isEmpty) {
      Util.snackBar("Please Enter Name", context);
      return false;
    }
    if (_descriptionController.text.isEmpty) {
      Util.snackBar("Please Enter Description", context);
      return false;
    }
    if (_purposeController.text.isEmpty) {
      Util.snackBar("Please Enter Purpose", context);
      return false;
    }
    return true;
  }

  callService() async {
    Workout request = Workout(
        name: _nameController.text,
        trainerId: await SessionManager().getId(),
        status: 'active',
        purpose: _purposeController.text,
        description: _descriptionController.text);

    UpdatedMessage response = await ApiCall().addMeal(request, context);

    if (response.status == ApiCall.responseSuccess) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.message)));

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) {
            return const Dashboard();
          }), (route) => false);
    } else if (response.status == ApiCall.responseFail) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.message)));
    }
  }
}
