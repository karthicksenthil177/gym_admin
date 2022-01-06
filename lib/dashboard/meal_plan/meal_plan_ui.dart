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
                    onTap: () {},
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: defaultPaddingSize / 4),
                      child: Container(
                        padding: const EdgeInsets.all(defaultPaddingSize),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.mealPlan.planDays
                                    .elementAt(index)
                                    .mealDay),
                              ],
                            ),
                            const SizedBox(
                              height: defaultPaddingSize / 2,
                            ),
                            ListView.builder(
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
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              widget.mealPlan.planDays
                                                  .elementAt(index)
                                                  .mealTime
                                                  .elementAt(mealIndex)
                                                  .mealName,
                                            ),
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
                                    widget.mealPlan.planDays
                                            .elementAt(index)
                                            .mealTime
                                            .length !=
                                        mealIndex ?
                                      const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Divider(
                                          height: 4,
                                        ),
                                      ) : Container()
                                  ],
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
