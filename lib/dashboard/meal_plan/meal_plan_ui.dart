import 'package:flutter/material.dart';
import 'package:gym_admin/dashboard/meal_plan/model/meal_plan.dart';
import 'package:gym_admin/util.dart';

class MealPlanUI extends StatefulWidget {
  final MealPlan mealPlan;

  const MealPlanUI({Key? key, required this.mealPlan}) : super(key: key);

  @override
  _MealPlanUIState createState() => _MealPlanUIState();
}

class _MealPlanUIState extends State<MealPlanUI> {
  int selectedIndex = -1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.mealPlan.planName,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: backgroundColor,
      body: widget.mealPlan.planDays.isEmpty
          ? const Center(
              child: Text("Empty"),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: widget.mealPlan.planDays.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      setState((){
                        selectedIndex = index;
                      });

                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(defaultPaddingSize),
                          margin:
                          const EdgeInsets.only(left: defaultPaddingSize / 4,right: defaultPaddingSize/4,top: defaultPaddingSize/4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: greyColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.mealPlan.planDays
                                  .elementAt(index)
                                  .mealDay),
                              Icon(selectedIndex == index ? Icons.circle : null,size: 10,)
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        if(selectedIndex == index)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.mealPlan.planDays
                                .elementAt(index)
                                .mealTime
                                .length,
                            itemBuilder:
                                (BuildContext context, int mealIndex) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Meal",
                                            style: TextStyle(
                                                color: lightBlackColor,
                                                fontSize: 12),),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width*0.60,
                                            child :
                                            Text(
                                            widget.mealPlan.planDays
                                                .elementAt(index)
                                                .mealTime
                                                .elementAt(mealIndex)
                                                .mealName,
                                          ),),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Purpose",
                                            style: TextStyle(
                                                color: lightBlackColor,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            widget.mealPlan.planDays
                                                .elementAt(index)
                                                .mealTime
                                                .elementAt(mealIndex)
                                                .mealPurpose,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8,),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Description",
                                        style: TextStyle(
                                            color: lightBlackColor,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        widget.mealPlan.planDays
                                            .elementAt(index)
                                            .mealTime
                                            .elementAt(mealIndex)
                                            .mealDescription,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 8,),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Time",
                                        style: TextStyle(
                                            color: lightBlackColor,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        widget.mealPlan.planDays
                                            .elementAt(index)
                                            .mealTime
                                            .elementAt(mealIndex).mealPeriod,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 8,),
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
