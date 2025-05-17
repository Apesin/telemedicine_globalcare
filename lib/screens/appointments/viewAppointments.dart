import 'package:doctor_app/bloc/states/appointment.dart';
import 'package:doctor_app/models/appointmentModel.dart';
import 'package:doctor_app/persistence/persistence.dart';
import 'package:doctor_app/persistence/strings.dart';
import 'package:doctor_app/screens/appointments/startMeetingScreen.dart';
import 'package:doctor_app/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../utils/navigation.dart';

enum AppointmentStatus {Pending, Fulfilled, Booked, All, Declined}
AppointmentStatus? _appointmentStatus = AppointmentStatus.All;
class ViewAppointments extends StatefulWidget{
  const ViewAppointments({super.key});

  @override
  _ViewAppointments createState() => _ViewAppointments();
}

class _ViewAppointments extends State<ViewAppointments>{
  final AppointmentState _appointmentState = AppointmentState();
  List<AppointmentModel> appointments = [];
  List<AppointmentModel> sortAppointments = [];
  bool isLoading = true;
  bool isFiltered = false;

  get()async{
    var pId = await getStringValuesSP(PrefStrings.PERSON_ID);
    var hId = await getStringValuesSP(PrefStrings.HOSPITAL_ID);
    var bId = await getStringValuesSP(PrefStrings.BRANCH_ID);
    _appointmentState.getFixedAppointments("$hId/$bId/$pId");
  }

  sort(String sortingList){
    sortAppointments.clear();
    if(sortingList != "All"){
      setState(() {
        isFiltered = true;
      });
      appointments.forEach((appointment) {
        if(appointment.status.toLowerCase() == sortingList.toLowerCase()){
          setState(() {
            sortAppointments.add(appointment);
          });
        }
      });
    }else{
      setState(() {
        isFiltered = false;
      });
    }
  }

  @override
  void initState() {
    get();
    _appointmentState.addListener(() {
      if(_appointmentState.appointmentsGotten == "yes"){
        setState(() {
          appointments = _appointmentState.appointments;
          isLoading = false;
        });
      }else if(_appointmentState.appointmentsGotten == "no"){
        setState(() {
          appointments = _appointmentState.appointments;
          isLoading = false;
        });
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading ?
      Loader()
      :SizedBox(
        height: MediaQuery.of(context).size.height-15,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.height,
                child: DropdownButton<AppointmentStatus>(
                  value: _appointmentStatus,
                  items: const [
                    DropdownMenuItem(value: AppointmentStatus.All, child: Text("All")),
                    DropdownMenuItem(value: AppointmentStatus.Pending, child: Text("Pending")),
                    DropdownMenuItem(value: AppointmentStatus.Booked, child: Text("Booked")),
                    DropdownMenuItem(value: AppointmentStatus.Fulfilled, child: Text("Fulfilled")),
                    DropdownMenuItem(value: AppointmentStatus.Declined, child: Text("Declined")),
                  ],
                  onChanged: (value) {
                    sort(value!.name);
                    setState(() {
                      _appointmentStatus = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height)-176,
              width: MediaQuery.of(context).size.width-50,
              child: isFiltered ?
              ListView.builder(
                  itemCount: sortAppointments.length,
                  itemBuilder: (BuildContext context, int index){
                    return AppointmentCard(onTap: (){
                      print("🔍 Joining Zoom session... ${sortAppointments[index].zoom_meeting_url}");

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("🔍 Joining Zoom session...")),
                      );

                      RegExp meetingIdRegex = RegExp(r"/j/(\d+)");
                      RegExp passwordRegex = RegExp(r"pwd=([a-zA-Z0-9]+)");

                      String zoomUrl = sortAppointments[index].zoom_meeting_url;
                      String? meetingId = meetingIdRegex.firstMatch(zoomUrl)?.group(1);
                      String? password = passwordRegex.firstMatch(zoomUrl)?.group(1);


                      print("Meeting ID: ${meetingId ?? 'Not found'}");
                      print("Password: ${password ?? 'Not found'}");

                      pushPage(context, StartMeeting(meetingId!, password!));
                    }, appointmentModel: sortAppointments[index], appointmentColor: sortAppointments[index].status.toLowerCase() == "all" ? Colors.green : sortAppointments[index].status.toLowerCase() == "pending" ? Colors.yellow : sortAppointments[index].status.toLowerCase() == "booked" ? Colors.blue : sortAppointments[index].status.toLowerCase() == "fultilled" ? Colors.purple : Colors.red,);
                  })
              : ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (BuildContext context, int index){
                    return AppointmentCard(onTap: (){

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("🔍 Joining Zoom session...")),
                      );

                      RegExp meetingIdRegex = RegExp(r"/j/(\d+)");
                      RegExp passwordRegex = RegExp(r"pwd=([a-zA-Z0-9]+)");

                      String zoomUrl = appointments[index].zoom_meeting_url;
                      String? meetingId = meetingIdRegex.firstMatch(zoomUrl)?.group(1);
                      String? password = passwordRegex.firstMatch(zoomUrl)?.group(1);


                      print("Meeting ID: ${meetingId ?? 'Not found'}");
                      print("Password: ${password ?? 'Not found'}");

                      pushPage(context, StartMeeting(meetingId!, password!));
                    }, appointmentModel: appointments[index],
                    appointmentColor: appointments[index].status.toLowerCase() == "all" ? Colors.green : appointments[index].status.toLowerCase() == "pending" ? Colors.yellow : appointments[index].status.toLowerCase() == "booked" ? Colors.blue : appointments[index].status.toLowerCase() == "fultilled" ? Colors.purple : Colors.red,);
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget{
  final void Function() onTap;
  AppointmentModel appointmentModel;
  Color appointmentColor;
  AppointmentCard({
    Key? key,
    required this.onTap,
    required this.appointmentModel,
    required this.appointmentColor
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage('https://img.freepik.com/premium-vector/avatar-male-doctor-with-black-hair-beard-doctor-with-stethoscope-vector-illustrationxa_276184-32.jpg'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appointmentModel.doctor_name,
                          style: const TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'Avenir', fontWeight: FontWeight.bold)),
                      Text('${appointmentModel.clinic_name} - ${appointmentModel.appointment_type}', style: const TextStyle(
                        fontSize: 10
                      ),),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 6,),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.access_time, size: 16,),
                    Text(formatDateTime(appointmentModel.booking_date))
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                appointmentModel.status,
                style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      copyToClipboard(appointmentModel.zoom_meeting_url, context: context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        border: Border.all(color: Colors.grey.withOpacity(0.2))
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.mark_email_read_outlined, color: Colors.orangeAccent, size: 16,),
                          Text('Invite', style: TextStyle(
                            color: Colors.orangeAccent
                          ),)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1),
                          border: Border.all(color: Colors.grey.withOpacity(0.2))
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.play_circle_outline_outlined, color: Colors.green, size: 16,),
                          Text('Start Video', style: TextStyle(
                              color: Colors.green
                          ),)
                        ],
                      ),
                    ),
                  )
                ],
              )
            ]
        ),
      ),
    );
  }

  Future<void> copyToClipboard(String text, {BuildContext? context}) async {
    await Clipboard.setData(ClipboardData(text: text));

    // Optional: Show a snackbar to confirm the copy
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invite link copied to clipboard')),
      );
    }
  }

  String formatDateTime(String isoString) {
    DateTime utcTime = DateTime.parse(isoString);

    DateTime gmtPlus1Time = utcTime.add(const Duration(hours: 1));

    String formattedDate = DateFormat('dd-MM-y').format(gmtPlus1Time);
    String formattedTime = DateFormat('h:mm a').format(gmtPlus1Time);

    return '$formattedDate $formattedTime';
  }

}
