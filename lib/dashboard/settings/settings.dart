import 'package:flutter/material.dart';
import 'package:gym_admin/dashboard/settings/meal_crud/meal_list.dart';
import 'package:gym_admin/dashboard/settings/profile/profile.dart';
import 'package:gym_admin/dashboard/settings/user_crud/user_list.dart';
import 'package:gym_admin/dashboard/settings/workout_crud/workout_list.dart';
import 'package:gym_admin/data/session_manager.dart';
import 'package:gym_admin/pre_dashboard/login.dart';
import 'package:gym_admin/util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_admin/widget/app_bar.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppBar(title: "Accounts"),
        ListTile(
          title: const Text(
            "Profile",style: TextStyle(fontWeight: FontWeight.bold),),
          leading: CircleAvatar(backgroundColor: greyColor,child: SvgPicture.asset("assets/icons/profile.svg",height: 20,),radius: 24,),
          subtitle: const Text(
            "View your Profile",),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
              return const Profile();
            }));
          },
        ),
        ListTile(
            title: const Text("Users",style: TextStyle(fontWeight: FontWeight.bold),),
          leading: CircleAvatar(backgroundColor: greyColor,child: SvgPicture.asset("assets/icons/user.svg",height: 20,),radius: 24,),
          subtitle: const Text("Add/Update User to your list"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const UserList();
              }));
            },),
        ListTile(
          title: const Text("Meals",style: TextStyle(fontWeight: FontWeight.bold),),
          leading: CircleAvatar(backgroundColor: greyColor,child: SvgPicture.asset("assets/icons/meal.svg",color:Colors.black,height: 20,),radius: 24,),
          subtitle: const Text("Add/Update Meal to your list"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const MealList();
            }));
          },),
        ListTile(
          title: const Text("Workouts",style: TextStyle(fontWeight: FontWeight.bold),),
          leading: CircleAvatar(backgroundColor: greyColor,child: SvgPicture.asset("assets/icons/workout.svg",height: 15,width: 20,color: Colors.black,),radius: 24,),
          subtitle: const Text("Add/Update Workout to your list"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const WorkoutList();
            }));
          },),
        ListTile(
          title:const  Text("Logout",style: TextStyle(fontWeight: FontWeight.bold),),
          subtitle: const Text("Logout from Gym Gem"),
          leading: CircleAvatar(backgroundColor: greyColor,child: SvgPicture.asset("assets/icons/logout.svg",height: 20,),radius: 24,),

          onTap: () {

            showDialog(
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Logout',
                      textAlign: TextAlign.center,
                    ),
                    content: const Text(
                      'want to Logout!',
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          SessionManager().clearAll();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const LoginScreen();
                                  }), (route) => false);
                        },
                        child: const  Text(
                          'Okay',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  );
                },
                context: context);


          },),
      ],
    ));
  }
}
