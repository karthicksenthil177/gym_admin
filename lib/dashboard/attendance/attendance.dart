import 'package:flutter/material.dart';
import 'package:gym_admin/api/api_call.dart';
import 'package:gym_admin/util.dart';
import 'package:gym_admin/widget/button.dart';
import 'package:gym_admin/widget/gradient_text.dart';
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
              "Attendance",
              style: TextStyle(color: Colors.white),
            ),
          ),
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
      onTap: () {
        _modalBottomSheetMenu(elementAt.userId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: defaultPaddingSize / 4),
        child: Container(
          padding: const EdgeInsets.all(defaultPaddingSize),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(elementAt.userName),
                  GradientText(
                    child: Text(
                      elementAt.status,
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
                    "Endurance Training",
                    style: TextStyle(color: lightBlackColor, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _modalBottomSheetMenu(String userId) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(defaultPaddingSize),
            topRight: Radius.circular(defaultPaddingSize),
          ),
        ),
        context: context,
        builder: (builder) {
          return Container(
              padding: const EdgeInsets.all(defaultPaddingSize),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(defaultPaddingSize),
                      topRight: Radius.circular(defaultPaddingSize))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomButton(callback: () {
                    callService(context,true, userId);
                  }, buttonText: "Present"),
                  const SizedBox(
                    height: defaultPaddingSize,
                  ),
                  const Text(
                    "OR",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: defaultPaddingSize,
                  ),
                  CustomButton(callback: () {callService(context,false,userId); }, buttonText: "Absent")
                ],
              ));
        });
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
