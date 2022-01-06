import 'package:flutter/material.dart';
import 'package:gym_admin/dashboard/meal_plan/meal_plan_create.dart';
import 'package:gym_admin/dashboard/meal_plan/meal_plan_list.dart';
import 'package:gym_admin/dashboard/workout_plan/workout_plan_list.dart';
import 'package:gym_admin/util.dart';

class Assign extends StatefulWidget {
  const Assign({Key? key}) : super(key: key);

  @override
  _AssignState createState() => _AssignState();
}

class _AssignState extends State<Assign> with TickerProviderStateMixin{

  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: backgroundColor,
          floatingActionButton: ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(8)
            ),
            onPressed: () {
              debugPrint(_tabController?.index.toString());
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return _tabController?.index == 0 ? const MealPlanCreate(isMeal : true) : const MealPlanCreate(isMeal : false);
              }));
            },
            child: const Text("Create"),
          ),
          appBar: AppBar(
            centerTitle: false,
            titleSpacing: 0,
            title: Container(
                width: 100,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.all(defaultPaddingSize / 1.5),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(defaultPaddingSize * 1.5),
                    bottomRight: Radius.circular(defaultPaddingSize * 1.5),
                  ),
                ),
                child: const Text(
                  "Assign",
                  style: TextStyle(color: Colors.white,fontSize: 14),
                ),
              ),
            backgroundColor: backgroundColor,
            elevation: 0,
            bottom: TabBar(
              controller: _tabController,
                labelColor: primaryColor,
                indicatorColor: primaryColor,
                tabs: const [
                Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text("Meals"),
              ),
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text("Workout"),
              ),
            ]),
          ),
          body: TabBarView(
              controller: _tabController,
              children: const [
            Center(child:  MealPlanListUI(isMeal: true,)),
            Center(child: WorkoutPlanListUI()),
          ]),
        ),
      ),
    );

  }
}