import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gym_admin/api/api_call.dart';
import 'package:gym_admin/dashboard/dashboard.dart';
import 'package:gym_admin/dashboard/user_upload/model/user_upload_meal_list.dart';
import 'package:gym_admin/util.dart';
import 'package:gym_admin/widget/app_bar.dart';

import 'model/user_upload_image.dart';

class VerifyImage extends StatefulWidget {
  final Meals meals;

  const VerifyImage({required this.meals, Key? key}) : super(key: key);

  @override
  _VerifyImageState createState() => _VerifyImageState();
}

class _VerifyImageState extends State<VerifyImage> {

  Future<UserUploadImage>? image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    image = ApiCall().userUploadedImage(widget.meals.mealId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "Verify Image",
        ),
        body: FutureBuilder<UserUploadImage>(
            future: image,
            builder: (BuildContext context,
                AsyncSnapshot<UserUploadImage> snapshot) {
              if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(defaultPaddingSize),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.0),
                                  child:  Text("Meal Name",style: TextStyle(color: Colors.black45),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(widget.meals.name),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.0),
                                  child:  Text("Purpose",style: TextStyle(color: Colors.black45),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(widget.meals.purpose),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.0),
                                  child:  Text("Description",style: TextStyle(color: Colors.black45),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(widget.meals.description),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.0),
                                  child:  Text("Uploaded Image",style: TextStyle(color: Colors.black45),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.memory(
                                    base64.decode(snapshot.data!.data),
                                    height: 150,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(onPressed: () {
                                callService(context,true);
                              }, child: const SizedBox(
                                  width: 75,
                                  child:  Text("Approve",textAlign: TextAlign.center,))),
                              ElevatedButton(onPressed: () {
                                callService(context,false);
                              }, child: const SizedBox(
                                  width: 75,
                                  child:  Text("Reject",textAlign: TextAlign.center,))),
                            ],)
                        ],
                      ),
                    );
              }
              return const Center(
                  child: CircularProgressIndicator(),
              );
            })

        );
  }

  callService(BuildContext context,bool isApprove) async {
    UpdatedMessage response = await ApiCall().imageApproveOrReject(context, widget.meals.userId!, widget.meals.mealId!, isApprove);
    if(response.status == ApiCall.responseSuccess) {
      Util.snackBar(response.message, context);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) {
        return const Dashboard();
      }), (route) => false);
    } else {
      Util.snackBar(response.message, context);
    }
  }
}
