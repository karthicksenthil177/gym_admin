import 'package:flutter/material.dart';
import 'package:gym_admin/api/api_call.dart';
import 'package:gym_admin/dashboard/user_upload/model/user_upload_meal_list.dart';
import 'package:gym_admin/dashboard/user_upload/verify_image.dart';
import 'package:gym_admin/util.dart';
import 'package:gym_admin/widget/gradient_text.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  Future<UserUploadMealResponse>? response;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    response = ApiCall().userUploadedMealList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          title : Text("Hello!",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          elevation: 0,
          backgroundColor: backgroundColor,
          leading: Image.asset("assets/images/logo.png"),
          actions: [IconButton(onPressed: () {
          setState(() {
            response = ApiCall().userUploadedMealList();
          });
        }, icon: const Icon(Icons.refresh,color: Colors.black,))],),
        Container(
            height: MediaQuery.of(context).size.height*0.1,
            width: double.infinity,
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
          image: DecorationImage(
            fit: BoxFit.cover,
              image: AssetImage("assets/images/meal.png")))
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8,),
          child: Text("Today's List",style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        userUploadList(),
      ],
    ));
  }

  Widget userUploadList() {
    return FutureBuilder<UserUploadMealResponse>(
      future: response,
      builder: (BuildContext context,
          AsyncSnapshot<UserUploadMealResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.status == ApiCall.responseSuccess) {
            if (snapshot.data!.data.isEmpty) {
              return Expanded(child: Center(child: Text(snapshot.data!.message),));
            } else {
              return Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(defaultPaddingSize / 2),
                  itemCount: snapshot.data!.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        if(snapshot.data!.data.elementAt(index).imageStatus != ApiCall.responseFail) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {

                            return VerifyImage(meals : snapshot.data!.data.elementAt(index));
                          }));
                        } else {
                          Util.snackBar("Photo not uploaded", context);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(defaultPaddingSize),
                        margin:
                        const EdgeInsets.all(defaultPaddingSize/4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: greyColor,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(snapshot.data!.data.elementAt(index).userName!),
                                Text(
                                  snapshot.data!.data.elementAt(index).status,
                                  style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: defaultPaddingSize / 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    snapshot.data!.data.elementAt(index).name,
                                    style: TextStyle(color: lightBlackColor),
                                    maxLines: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
        }
        return const Expanded(child: Center(child: CircularProgressIndicator(),));
      },);
  }
}
