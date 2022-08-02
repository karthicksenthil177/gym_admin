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
      floatingActionButton: FloatingActionButton(onPressed: () async {
       final result = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
          return const UserCreation();
        }));
       if(result){
         setState(() {
           response = ApiCall().userList();
         });
       }
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
                          children: [
                            Text(snapshot.data!.data.elementAt(index).name,style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),),
                            Text(
                              snapshot.data!.data.elementAt(index).mobile,
                              style: const TextStyle(color: Colors.black45, fontSize: 14),
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
                              style: const TextStyle(color: Colors.black45, fontSize: 14),
                            ),
                          ],
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
