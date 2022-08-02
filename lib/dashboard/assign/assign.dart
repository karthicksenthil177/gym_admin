import 'package:flutter/material.dart';
import 'package:gym_admin/dashboard/meal_plan/meal_plan_create.dart';
import 'package:gym_admin/dashboard/meal_plan/meal_plan_list.dart';
import 'package:gym_admin/dashboard/workout_plan/workout_plan_list.dart';
import 'package:gym_admin/util.dart';
import 'package:gym_admin/widget/app_bar.dart';

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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              debugPrint(_tabController?.index.toString());
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return _tabController?.index == 0 ? const MealPlanCreate(isMeal : true) : const MealPlanCreate(isMeal : false);
              }));
            },
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            centerTitle: true,
            titleSpacing: 0,
            title:Text("Assign",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            backgroundColor: backgroundColor,
            elevation: 0,
            bottom: TabBar(
              controller: _tabController,
                labelColor: primaryColor,
                unselectedLabelColor: Colors.black,
                labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                indicatorColor: Colors.transparent,
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