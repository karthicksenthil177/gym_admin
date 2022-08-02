import 'package:flutter/material.dart';
import 'package:gym_admin/api/api_call.dart';
import 'package:gym_admin/util.dart';
import 'package:gym_admin/widget/app_bar.dart';
import 'package:gym_admin/widget/button.dart';
import 'package:gym_admin/widget/gradient_text.dart';
import 'package:gym_admin/widget/text_button.dart';
import 'attendance_list.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  Future<AttendanceList>? attendanceList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    attendanceList = ApiCall().getAttendanceList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(title: "Attendance"),
          FutureBuilder<AttendanceList>(
              future: attendanceList,
              builder: (BuildContext context,
                  AsyncSnapshot<AttendanceList> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.status == ApiCall.responseSuccess) {
                    if (snapshot.data!.data.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Text(snapshot.data!.message),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        padding: const EdgeInsets.all(defaultPaddingSize / 2),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return attendanceDetails(snapshot.data!.data.elementAt(index));
                        },
                      );
                    }
                  }
                }
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              })
        ],
      ),
    );
  }

  Widget attendanceDetails(Datum elementAt) {

    return InkWell(
      onTap: (){
        showDialogue(elementAt);
      },
      child: Container(
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
                      Text(elementAt.userName,style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),),
                      SizedBox(height: 4,),
                      Text(elementAt.status,
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
  }

  void showDialogue(Datum userId) {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)), //this right here
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left : 12.0,right: 12.0,top: 12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16,),
                    Center(child: Text(userId.userName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
                    SizedBox(height: 16,),
                    Center(child: Text(userId.date.toString(),style: TextStyle(fontWeight: FontWeight.w500),)),
                    SizedBox(height: 32,),
                    Row(children: [
                      Expanded(
                        child: CustomTextButton(
                            padding: 16,
                            color: Colors.white,
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            text: "Present", callback: (){
                          callService(context,true, userId.userId);
                          Navigator.of(context).pop();
                        }),
                      ),
                      SizedBox(width: 8,),
                      Expanded(
                        child: CustomTextButton(
                            padding: 16,
                            text: "Absent", callback: (){
                          callService(context,false,userId.userId);
                          Navigator.of(context).pop();
                        }),
                      ),
                    ],),
                    Container(
                      width: double.infinity,
                      child: TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child: Text("Cancel",textAlign: TextAlign.center,)),
                    )
                  ],
                ),
              ),
            ),
          );
        });
    // showModalBottomSheet(
    //     shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.only(
    //         topLeft: Radius.circular(defaultPaddingSize),
    //         topRight: Radius.circular(defaultPaddingSize),
    //       ),
    //     ),
    //     context: context,
    //     builder: (builder) {
    //       return Container(
    //           padding: const EdgeInsets.all(defaultPaddingSize),
    //           decoration: const BoxDecoration(
    //               color: Colors.white,
    //               borderRadius: BorderRadius.only(
    //                   topLeft: Radius.circular(defaultPaddingSize),
    //                   topRight: Radius.circular(defaultPaddingSize))),
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               CustomButton(callback: () {
    //                 callService(context,true, userId);
    //               }, buttonText: "Present"),
    //               const SizedBox(
    //                 height: defaultPaddingSize,
    //               ),
    //               const Text(
    //                 "OR",
    //                 style: TextStyle(
    //                     color: Colors.grey, fontWeight: FontWeight.bold),
    //               ),
    //               const SizedBox(
    //                 height: defaultPaddingSize,
    //               ),
    //               CustomButton(callback: () {callService(context,false,userId); }, buttonText: "Absent")
    //             ],
    //           ));
    //     });
  }


  callService(BuildContext context,bool isApprove,String userId) async {
    UpdatedMessage response = await ApiCall().addAttendance(context,userId , isApprove);
    if(response.status == ApiCall.responseSuccess) {
      Util.snackBar(response.message, context);
      Navigator.of(context).pop();
      setState(() {
        attendanceList = ApiCall().getAttendanceList();
      });
    } else {
      Util.snackBar(response.message, context);
    }
  }

}
