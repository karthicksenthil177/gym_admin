import 'package:flutter/material.dart';
import 'package:gym_admin/api/api_call.dart';
import 'package:gym_admin/dashboard/settings/meal_crud/meal_create.dart';
import 'package:gym_admin/dashboard/settings/workout_crud/model/workout_create_model.dart';
import 'package:gym_admin/util.dart';
import 'package:gym_admin/widget/app_bar.dart';

class MealList extends StatefulWidget {
  const MealList({Key? key}) : super(key: key);

  @override
  _MealListState createState() => _MealListState();
}

class _MealListState extends State<MealList> {

  Future<WorkoutListResponse>? response;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    response = ApiCall().mealList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "Meals",
        ),
        backgroundColor: backgroundColor,
        floatingActionButton: FloatingActionButton(onPressed: () async {
          final result = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
            return const MealCreate();
          }));
          if(result){
            setState(() {
              response = ApiCall().mealList();
            });
          }
        },
          child: const Icon(Icons.add),),
        body: Padding(padding: const EdgeInsets.all(defaultPaddingSize),
            child:FutureBuilder<WorkoutListResponse>(
              future: response,
              builder: (BuildContext context, AsyncSnapshot<WorkoutListResponse> snapshot) {
                if(snapshot.hasData) {
                  if(snapshot.data!.status == ApiCall.responseSuccess) {
                    if(snapshot.data!.data.isEmpty) {
                      return Center(child: Text(snapshot.data!.message),);
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.all(defaultPaddingSize),
                            margin:
                            const EdgeInsets.symmetric(vertical: defaultPaddingSize / 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: greyColor,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.60,
                                      child: Text(snapshot.data!.data.elementAt(index).name,style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold),),
                                    ),
                                    Text(
                                      snapshot.data!.data.elementAt(index).purpose,
                                      style: const TextStyle(color: Colors.black45, fontSize: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: defaultPaddingSize / 2,
                                ),
                                Text(
                                  snapshot.data!.data.elementAt(index).description,
                                  maxLines: 50,
                                  style: const TextStyle(color: Colors.black45, fontSize: 14),
                                ),
                              ],
                            ),
                          );
                        },);
                    }
                  }

                }
                return const Center(child: CircularProgressIndicator(),);
              },))
    );
  }
}
