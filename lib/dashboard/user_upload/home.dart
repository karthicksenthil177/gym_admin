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
        const SizedBox(
          height: defaultPaddingSize,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 120,
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
                "Today's List",
                style: TextStyle(color: Colors.white),
              ),
            ),
            IconButton(onPressed: () {
              setState(() {
                response = ApiCall().userUploadedMealList();
              });
            }, icon: const Icon(Icons.refresh))
          ],
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
                        }
                      },
                      child: Card(
                        margin:
                        const EdgeInsets.symmetric(vertical: defaultPaddingSize / 4),
                        child: Container(
                           padding: const EdgeInsets.all(defaultPaddingSize),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(snapshot.data!.data.elementAt(index).userName!),
                                  GradientText(
                                    child:  Text(
                                      snapshot.data!.data.elementAt(index).status,
                                      style: const TextStyle(color: Colors.white, fontSize: 10),
                                    ),
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        Colors.lightBlue,
                                        Colors.lightBlue.withOpacity(0.5),
                                      ],
                                    ),
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
                                    snapshot.data!.data.elementAt(index).name,
                                    style: TextStyle(color: lightBlackColor, fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
