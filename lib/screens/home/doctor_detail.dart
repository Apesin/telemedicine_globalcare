import 'dart:convert';

import 'package:doctor_app/constants.dart';
import 'package:doctor_app/screens/appointments/startMeetingScreen.dart';
import 'package:doctor_app/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:doctor_app/models/appointmentModel.dart';
import 'package:doctor_app/styles/colors.dart';
import 'package:doctor_app/styles/styles.dart';

import '../appointments/testMeeting.dart';

class SliverDoctorDetail extends StatelessWidget {
  final AppointmentModel appointmentModel;

  const SliverDoctorDetail({Key? key, required this.appointmentModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            title: Text('Appointment details'),
            backgroundColor: primaryColor,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                image: AssetImage('assets/images/hospital.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DetailBody(appointmentModel: appointmentModel),
          ),
        ],
      ),
    );
  }
}

class DetailBody extends StatefulWidget {
  final AppointmentModel appointmentModel;

  DetailBody({Key? key, required this.appointmentModel}) : super(key: key);

  @override
  _DetailBodyState createState() => _DetailBodyState();
}

class _DetailBodyState extends State<DetailBody> {


  @override
  void initState() {
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DetailDoctorCard(appointmentModel: widget.appointmentModel),
          SizedBox(height: 15),
          DoctorInfo(appointmentModel: widget.appointmentModel),
          SizedBox(height: 30),
          Text(
            'Description',
            style: kTitleStyle,
          ),
          SizedBox(height: 15),
          Text(
            '${widget.appointmentModel.desciption}',
            style: TextStyle(
              color: Color(MyColors.purple01),
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Appointment Type',
            style: kTitleStyle,
          ),
          SizedBox(height: 15),
          Text(
            '${widget.appointmentModel.appointment_type}',
            style: TextStyle(
              color: Color(MyColors.purple01),
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          SizedBox(height: 25),
          // Button to Start Zoom Meeting
          Visibility(
            visible: widget.appointmentModel.appointment_type.toLowerCase() == "telemedicine",
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color(MyColors.primary),
                ),
              ),
              child: Text('Start appointment'),
              onPressed: () async {
                print("🔍 Joining Zoom session... ${widget.appointmentModel.zoom_meeting_url}");

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("🔍 Joining Zoom session...")),
                );

                RegExp meetingIdRegex = RegExp(r"/j/(\d+)");
                RegExp passwordRegex = RegExp(r"pwd=([a-zA-Z0-9]+)");

                String zoomUrl = widget.appointmentModel.zoom_meeting_url;
                String? meetingId = meetingIdRegex.firstMatch(zoomUrl)?.group(1);
                String? password = passwordRegex.firstMatch(zoomUrl)?.group(1);


                print("Meeting ID: ${meetingId ?? 'Not found'}");
                print("Password: ${password ?? 'Not found'}");

                pushPage(context, StartMeeting(meetingId!, password!));


              },
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorInfo extends StatelessWidget {
  final AppointmentModel appointmentModel;

  DoctorInfo({
    Key? key, required this.appointmentModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NumberCard(
          label: 'Time',
          value: '${appointmentModel.appointment_time.length > 8 ? appointmentModel.appointment_time.substring(0, 8) : appointmentModel.appointment_time}',
        ),
        SizedBox(width: 15),
        NumberCard(
          label: 'Date',
          value: '${appointmentModel.appointment_date.length > 10 ? appointmentModel.appointment_date.substring(0, 10) : appointmentModel.appointment_date}',
        ),
      ],
    );
  }
}

class NumberCard extends StatelessWidget {
  final String label;
  final String value;

  const NumberCard({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(MyColors.bg03),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 15,
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: Color(MyColors.grey02),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              value,
              style: TextStyle(
                color: Color(MyColors.header01),
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailDoctorCard extends StatelessWidget {
  final AppointmentModel appointmentModel;

  DetailDoctorCard({
    Key? key, required this.appointmentModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${appointmentModel.doctor_name}',
                      style: TextStyle(
                          color: Color(MyColors.header01),
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${appointmentModel.clinic_name}',
                      style: TextStyle(
                        color: Color(MyColors.grey02),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Image(
                image: AssetImage('assets/images/doctor01.jpeg'),
                width: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
