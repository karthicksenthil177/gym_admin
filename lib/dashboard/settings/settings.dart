import 'package:flutter/material.dart';
import 'package:gym_admin/dashboard/settings/meal_crud/meal_list.dart';
import 'package:gym_admin/dashboard/settings/profile/profile.dart';
import 'package:gym_admin/dashboard/settings/user_crud/user_list.dart';
import 'package:gym_admin/dashboard/settings/workout_crud/workout_list.dart';
import 'package:gym_admin/data/session_manager.dart';
import 'package:gym_admin/pre_dashboard/login.dart';
import 'package:gym_admin/util.dart';

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
        const SizedBox(
          height: defaultPaddingSize,
        ),
        Container(
          width: 100,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(defaultPaddingSize / 1.5),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(defaultPaddingSize * 1.5),
              bottomRight: Radius.circular(defaultPaddingSize * 1.5),
            ),
          ),
          child: const Text(
            "Accounts",
            style: TextStyle(color: Colors.white),
          ),
        ),
        ListTile(
          title: const Text(
            "Profile",),
          trailing: const Icon(Icons.chevron_right),
          subtitle: const Text(
            "View your Profile",),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
              return const Profile();
            }));
          },
        ),
        ListTile(
            title: const Text("Users"),
            subtitle: const Text("Add/Update User to your list"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const UserList();
              }));
            },),
        ListTile(
          title: const Text("Meals"),
          subtitle: const Text("Add/Update Meal to your list"),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const MealList();
            }));
          },),
        ListTile(
          title: const Text("Workouts"),
          subtitle: const Text("Add/Update Workout to your list"),
          trailing:const  Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const WorkoutList();
            }));
          },),
        ListTile(
          title:const  Text("Logout"),
          subtitle: const Text("Logout from Gym Gem"),
          trailing:const  Icon(Icons.chevron_right),
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
