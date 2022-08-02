import 'package:flutter/material.dart';
import 'package:gym_admin/api/api_call.dart';
import 'package:gym_admin/dashboard/dashboard.dart';
import 'package:gym_admin/dashboard/meal_plan/model/timing_response.dart';
import 'package:gym_admin/dashboard/meal_plan/model/upload_meal_plan.dart';
import 'package:gym_admin/dashboard/settings/workout_crud/model/workout_create_model.dart';
import 'package:gym_admin/data/session_manager.dart';
import 'package:gym_admin/util.dart';
import 'package:gym_admin/widget/app_bar.dart';
import 'package:gym_admin/widget/gradient_text.dart';
import 'package:gym_admin/widget/text_button.dart';

class ScheduleDays extends StatefulWidget {
  final String planName;
  final String purpose;
  final bool isMeal;

  const ScheduleDays({required this.planName, required this.purpose, Key? key,this.isMeal = true})
      : super(key: key);

  @override
  _ScheduleDaysState createState() => _ScheduleDaysState();
}

class _ScheduleDaysState extends State<ScheduleDays> {
  int selectedIndex = 0;
  Future<TimingResponse>? response;
  List<PlanDay>? uploadEachDay = [];
  List<UploadTime> uploadEachTime = [];
  bool isFirstTime = true;
  bool isPrevious = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    response = ApiCall().scheduleList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: const CustomAppBar(
            title: "Schedule",
          ),
          backgroundColor: backgroundColor,
          body: Container(
              padding: const EdgeInsets.all(defaultPaddingSize / 4),
              child: FutureBuilder<TimingResponse>(
                future: response,
                builder: (BuildContext context,
                    AsyncSnapshot<TimingResponse> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.status == ApiCall.responseSuccess) {
                      if (snapshot.data!.data.isEmpty) {
                        return const Center(
                          child: Text("Empty"),
                        );
                      } else {
                        if (isFirstTime) {
                          isFirstTime = false;
                          if (isPrevious) {
                            uploadEachTime = [];
                            for (var data in uploadEachDay!
                                .elementAt(selectedIndex)
                                .dayTime) {
                              uploadEachTime.add(UploadTime(
                                  id: data.id,
                                  period: data.period,
                                  isActive: data.isActive));
                            }
                          } else {
                            uploadEachTime = [];
                            for (var data in snapshot.data!.data
                                .elementAt(selectedIndex)
                                .mealTime) {
                              uploadEachTime.add(UploadTime(
                                  id: '',
                                  period: data.mealPeriod,
                                  isActive: false));
                            }
                          }
                        }
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            /*SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 90,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                    padding: const EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color:
                                      selectedIndex == index ? primaryColor : backgroundColor,),
                                    child: Text(
                                      snapshot.data!.data.elementAt(index).mealDay,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color:
                                        selectedIndex ==  index ? backgroundColor : primaryColor,
                                      ),
                                    ),
                                  ),
                                );
                              },),
                          ),
                        ),*/
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.all(defaultPaddingSize),
                              child: Text(
                                snapshot.data!.data
                                    .elementAt(selectedIndex)
                                    .mealDay,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: uploadEachTime.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(

                                     alignment: Alignment.center,
                                     decoration: BoxDecoration(
                                         color: greyColor,
                                       borderRadius: BorderRadius.circular(10)
                                     ),
                                     margin: const EdgeInsets.symmetric(
                                       vertical: defaultPaddingSize/4,
                                         horizontal : defaultPaddingSize),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(uploadEachTime
                                              .elementAt(index)
                                              .period),
                                          InkWell(
                                            onTap: () {
                                              _modalBottomSheetMenu(index);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: widget.isMeal ? uploadEachTime
                                                          .elementAt(index)
                                                          .isActive!
                                                      ? Icon(Icons.check,color: Colors.green,)
                                                      : Icon(Icons.add) : uploadEachTime
                                                      .elementAt(index)
                                                      .isActive!
                                                      ? Icon(Icons.check,color: Colors.green,)
                                                      : Icon(Icons.add),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            previousOrNextButton(
                                snapshot.data!.data.length,
                                snapshot.data!.data
                                    .elementAt(selectedIndex)
                                    .mealDay)
                          ],
                        );
                      }
                    }
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ))),
    );
  }

  // validation() {
  //   if (_planNameController.text.isEmpty) {
  //     Util.snackBar("Please Enter Plan Name", context);
  //     return false;
  //   }
  //   if (_purposeController.text.isEmpty) {
  //     Util.snackBar("Please Enter Purpose", context);
  //     return false;
  //   }
  //   return true;
  // }

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

  Widget previousOrNextButton(int length, String mealDay) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          selectedIndex > 0
              ? Expanded(
                  child: CustomTextButton(
                      padding: 16,
                      callback: () {
                        setState(() {
                          selectedIndex = selectedIndex - 1;
                          isFirstTime = true;
                          isPrevious = true;
                        });
                      },
                      text : "Previous"),
                )
              : Expanded(child: const SizedBox()),
          SizedBox(width: 16,),
          Expanded(
            child: CustomTextButton(
                padding: 16,
                callback: () {
                  setState(() {
                    if (selectedIndex < length - 1) {
                      isFirstTime = true;
                      if (isPrevious) {
                        isPrevious = false;
                        editUploadDay();
                      } else {
                        uploadDay(mealDay);
                      }
                      selectedIndex = selectedIndex + 1;
                    } else {
                      uploadDay(mealDay);
                      callServices();
                    }
                  });
                },
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                text: selectedIndex < length - 1 ? "Next" : "Submit"),
          )
        ],
      ),
    );
  }

  void _modalBottomSheetMenu(int index) {
    showModalBottomSheet(
      backgroundColor: greyColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(defaultPaddingSize),
            topRight: Radius.circular(defaultPaddingSize),
          ),
        ),
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(defaultPaddingSize),
                      topRight: Radius.circular(defaultPaddingSize))),
              child: FutureBuilder<WorkoutListResponse>(
                future: widget.isMeal ? ApiCall().mealList() : ApiCall().workoutList(),
                builder: (BuildContext context,
                    AsyncSnapshot<WorkoutListResponse> snapshot) {
                  if (snapshot.hasData) {
                    return SearchMeal(
                        list: snapshot.data!.data,
                        callback: (id, name) {
                          setState(() {
                            if (!uploadEachTime.elementAt(index).isActive!) {
                              uploadEachTime.elementAt(index).isActive = true;
                              uploadEachTime.elementAt(index).id = id!;
                              Navigator.of(context).pop();
                            } else {
                              uploadEachTime.elementAt(index).isActive = true;
                              uploadEachTime.elementAt(index).id = id!;
                              Navigator.of(context).pop();
                            }
                          });
                        });
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ));
        });
  }

  bool validateIsAvailable(String mealPeriod) {
    for (final data in uploadEachTime) {
      if (mealPeriod == data.period) {
        return true;
      }
    }
    return false;
  }

  void uploadDay(String mealDay) {
    uploadEachDay!.add(PlanDay(dayName: mealDay, dayTime: uploadEachTime));
  }

  void editUploadDay() {
    uploadEachDay!.elementAt(selectedIndex).dayTime.clear();
    uploadEachDay!.elementAt(selectedIndex).dayTime.addAll(uploadEachTime);
  }

  void callServices() async {
    UploadPlanRequest request = UploadPlanRequest(
        trainerId: await SessionManager().getId(),
        plan: UploadPlan(
            planDays: uploadEachDay!,
            planName: widget.planName,
            planPurpose: widget.purpose));
    if(widget.isMeal) {
      UpdatedMessage response = await ApiCall().uploadMealPlan(context, request);
      if (response.status == ApiCall.responseSuccess) {
        Util.snackBar(response.message, context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) {
              return const Dashboard();
            }), (route) => false);
      } else {
        Util.snackBar(response.message, context);
        Navigator.of(context).pop();
      }
    } else {
      UpdatedMessage response = await ApiCall().uploadWorkoutPlan(context, request);
      if (response.status == ApiCall.responseSuccess) {
        Util.snackBar(response.message, context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) {
              return const Dashboard();
            }), (route) => false);
      } else {
        Util.snackBar(response.message, context);
        Navigator.of(context).pop();
      }
    }

  }
}

class SearchMeal extends StatefulWidget {
  final List<Workout> list;
  final Function(String? id, String? name)? callback;

  const SearchMeal({Key? key, required this.list, this.callback})
      : super(key: key);

  @override
  _SearchMealState createState() => _SearchMealState();
}

class _SearchMealState extends State<SearchMeal> {
  final List<Workout> _searchList = [];

  @override
  void initState() {
    _searchList.clear();
    _searchList.addAll(widget.list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(
              top: defaultPaddingSize,
              left: defaultPaddingSize,
              right: defaultPaddingSize),
          child: const Text("Choose",style: TextStyle(fontWeight: FontWeight.w500),),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.all(defaultPaddingSize),
          child: TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 12),
                focusedBorder:  OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide:  BorderSide(color: greyColor, width: 0.0),
                ),
                errorBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  // width: 0.0 produces a thin "hairline" border
                  borderSide:  BorderSide(color: greyColor, width: 0.0),
                ),
                disabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  // width: 0.0 produces a thin "hairline" border
                  borderSide:  BorderSide(color: greyColor, width: 0.0),
                ),
                enabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  // width: 0.0 produces a thin "hairline" border
                  borderSide:  BorderSide(color: greyColor, width: 0.0),

                ),
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: greyColor,
              hintText: "Search",
              suffixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              setState(() {
                _searchList.clear();
                if (value.isEmpty) {
                  _searchList.addAll(widget.list);
                } else {
                  for (final data in widget.list) {
                    if (data.name.contains(value)) {
                      _searchList.add(data);
                    }
                  }
                }
              });
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: _searchList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    onTap: () {
                      widget.callback!(_searchList.elementAt(index).id,
                          _searchList.elementAt(index).name);
                    },
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 4,),
                        Icon(Icons.circle,size: 12,color: greyColor,),
                        SizedBox(width: 8,),
                        Expanded(child: Text(_searchList.elementAt(index).name,maxLines: 5,)),
                      ],
                    ),);
              }),
        ),
      ],
    );
  }
}
