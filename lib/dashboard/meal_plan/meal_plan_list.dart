import 'package:flutter/material.dart';
import 'package:gym_admin/api/api_call.dart';
import 'package:gym_admin/dashboard/meal_plan/meal_plan_ui.dart';
import 'package:gym_admin/dashboard/meal_plan/model/meal_plan.dart';
import 'package:gym_admin/data/session_manager.dart';
import 'package:gym_admin/util.dart';
import 'package:gym_admin/dashboard/settings/profile/profile_detail_response.dart';
import 'package:gym_admin/widget/gradient_text.dart';

class MealPlanListUI extends StatefulWidget {
  final bool isMeal;
  const MealPlanListUI({Key? key,required this.isMeal}) : super(key: key);

  @override
  _MealPlanListUIState createState() => _MealPlanListUIState();
}

class _MealPlanListUIState extends State<MealPlanListUI> {

  Future<PlanResponse>? response;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

     response = ApiCall().mealPlanList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(defaultPaddingSize),
        child: FutureBuilder<PlanResponse>(
          future: response,
          builder: (BuildContext context,
              AsyncSnapshot<PlanResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.status == ApiCall.responseSuccess) {
                if (snapshot.data!.data.isEmpty) {
                  return Center(child: Text(snapshot.data!.message),);
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          _modalBottomSheetMenu(snapshot.data!.data.elementAt(index).mealPlan.id);
                        },
                        child: Card(
                          margin:
                          const EdgeInsets.symmetric(
                              vertical: defaultPaddingSize / 4),
                          child: Container(
                            padding: const EdgeInsets.all(defaultPaddingSize),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(snapshot.data!
                                        .data
                                        .elementAt(index)
                                        .mealPlan
                                        .planName),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (
                                                BuildContext context) {
                                              return MealPlanUI(
                                                  mealPlan: snapshot.data!
                                                      .data
                                                      .elementAt(index)
                                                      .mealPlan);
                                            }));
                                      },
                                      child: SizedBox(
                                        width: 50,
                                        child: GradientText(
                                          child: const Text(
                                            'view',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                          gradient: LinearGradient(
                                            colors: <Color>[
                                              Colors.lightBlue,
                                              Colors.lightBlue.withOpacity(0.5),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: defaultPaddingSize / 2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      snapshot.data!
                                          .data
                                          .elementAt(index)
                                          .mealPlan
                                          .planPurpose,
                                      style: TextStyle(
                                          color: lightBlackColor, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },);
                }
              }
            }
            return const Center(child: CircularProgressIndicator(),);
          },));
  }

  void _modalBottomSheetMenu(String planId) {
    showModalBottomSheet(
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
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.8,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(defaultPaddingSize),
                      topRight: Radius.circular(defaultPaddingSize))),
              child: FutureBuilder<ProfileDetailsResponse>(
                future: ApiCall().userList(),
                builder: (BuildContext context,
                    AsyncSnapshot<ProfileDetailsResponse> snapshot) {
                  if (snapshot.hasData) {
                    return SearchUser(
                        list: snapshot.data!.data,
                        callback: (id, name) async {
                          UpdatedMessage response = await ApiCall().mealAssign(planId,id,await SessionManager().getId(), context);
                            if(response.status == ApiCall.responseSuccess) {
                              Util.snackBar(response.message, context);
                              Navigator.of(context).pop();
                            } else {
                              Util.snackBar(response.message, context);
                            Navigator.of(context).pop();
                            }
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
}

class SearchUser extends StatefulWidget {
  final List<UserDetails> list;
  final Function(String id, String name)? callback;

  const SearchUser({Key? key,required this.list, this.callback}) : super(key: key);

  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  List<UserDetails> searchList = [];

  @override
  void initState() {
    searchList.clear();
    searchList.addAll(widget.list);
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
          child: const Text("Choose"),
        ),
        Container(
          height: 35,
          margin: const EdgeInsets.all(defaultPaddingSize),
          child: TextField(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(
                  left: defaultPaddingSize,
                  right: defaultPaddingSize,
                  bottom: defaultPaddingSize / 2,
                  top: defaultPaddingSize / 2),
              hintText: "Search",
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                searchList.clear();
                if (value.isEmpty) {
                  searchList.addAll(widget.list);
                } else {
                  for (final data in widget.list) {
                    if (data.name.contains(value)) {
                      searchList.add(data);
                    }
                  }
                }
              });
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: searchList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    onTap: () {
                      widget.callback!(searchList
                          .elementAt(index)
                          .id,
                          searchList
                              .elementAt(index)
                              .name);
                    },
                    leading: const Icon(Icons.account_balance_outlined),
                    title: Text(searchList.elementAt(index).name),
                    trailing:
                    const Icon(Icons.keyboard_arrow_right)

                );
              }),
        ),
      ],
    );
  }
}
