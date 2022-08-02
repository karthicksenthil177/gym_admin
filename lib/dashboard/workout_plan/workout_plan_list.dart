import 'package:flutter/material.dart';
import 'package:gym_admin/api/api_call.dart';
import 'package:gym_admin/dashboard/settings/profile/profile_detail_response.dart';
import 'package:gym_admin/dashboard/workout_plan/model/workout_plan_response.dart';
import 'package:gym_admin/data/session_manager.dart';
import 'package:gym_admin/util.dart';

class WorkoutPlanListUI extends StatefulWidget {
  const WorkoutPlanListUI({Key? key}) : super(key: key);

  @override
  _WorkoutPlanListUIState createState() => _WorkoutPlanListUIState();
}

class _WorkoutPlanListUIState extends State<WorkoutPlanListUI> {
  Future<WorkoutPlanResponse>? response;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    response = ApiCall().workoutPlansList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(defaultPaddingSize),
        child:FutureBuilder<WorkoutPlanResponse>(
          future: response,
          builder: (BuildContext context, AsyncSnapshot<WorkoutPlanResponse> snapshot) {
            if(snapshot.hasData) {
              if(snapshot.data!.status == ApiCall.responseSuccess) {
                if(snapshot.data!.data.isEmpty) {
                  return Center(child: Text(snapshot.data!.message),);
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          _modalBottomSheetMenu(snapshot.data!.data.elementAt(index).workoutPlan.id);
                        },
                        child :  Container(
                          padding: const EdgeInsets.all(defaultPaddingSize),
                          margin:
                          const EdgeInsets.symmetric(vertical: defaultPaddingSize / 4,horizontal: defaultPaddingSize/4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: greyColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.60,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data!.data.elementAt(index).workoutPlan.planName,style: const TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),),
                                        SizedBox(height: 4,),
                                        Text(snapshot.data!.data.elementAt(index).workoutPlan.planPurpose,
                                          style: const TextStyle(color: Colors.black45,),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.chevron_right,color: Colors.black45,),
                                ],
                              ),

                            ],
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
                          UpdatedMessage response = await ApiCall().workAssign(planId,id,await SessionManager().getId(), context);
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
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 4,),
                      Icon(Icons.circle,size: 12,color: greyColor,),
                      SizedBox(width: 8,),
                      Expanded(child: Text(searchList.elementAt(index).name,maxLines: 5,)),
                    ],
                  ),);
              }),
        ),
      ],
    );
  }
}

