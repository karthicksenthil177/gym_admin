import 'package:flutter/material.dart';
import 'package:gym_admin/api/api_call.dart';
import 'package:gym_admin/dashboard/settings/profile/profile_detail_response.dart';
import 'package:gym_admin/dashboard/settings/user_crud/user_creation.dart';
import 'package:gym_admin/util.dart';
import 'package:gym_admin/widget/app_bar.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  Future<ProfileDetailsResponse>? response;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    response = ApiCall().userList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Users",
      ),
      backgroundColor: backgroundColor,
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
          return const UserCreation();
        }));
      },
      child: const Icon(Icons.add),),
      body: Padding(padding: const EdgeInsets.all(defaultPaddingSize),
      child:FutureBuilder<ProfileDetailsResponse>(
        future: response,
        builder: (BuildContext context, AsyncSnapshot<ProfileDetailsResponse> snapshot) {
          if(snapshot.hasData) {
            if(snapshot.data!.status == ApiCall.responseSuccess) {
              if(snapshot.data!.data.isEmpty) {
                return Center(child: Text(snapshot.data!.message),);
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.data.length,
                  itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin:
                    const EdgeInsets.symmetric(vertical: defaultPaddingSize / 4),
                    child: Container(
                      padding: const EdgeInsets.all(defaultPaddingSize),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(snapshot.data!.data.elementAt(index).name),
                              Text(
                                snapshot.data!.data.elementAt(index).mobile,
                                style: const TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: defaultPaddingSize / 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                               snapshot.data!.data.elementAt(index).email,
                                style: TextStyle(color: lightBlackColor, fontSize: 12),
                              ),
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
        },))
    );
  }
}
