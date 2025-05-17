import 'package:flutter/material.dart';

import '../models/appointmentModel.dart';
import '../styles/colors.dart';
import '../styles/styles.dart';
import 'HomeTab.dart';


class ScheduleTab extends StatefulWidget {
   ScheduleTab({Key? key, required this.appointments}) : super(key: key);
  List<AppointmentModel> appointments;
  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

enum FilterStatus { Upcoming, Complete, Cancel }


class _ScheduleTabState extends State<ScheduleTab> {
  FilterStatus status = FilterStatus.Upcoming;
  Alignment _alignment = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Text(
                  'Appointments',
                  style: TextStyle(
                    color: Color(MyColors.header01),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                for (var doctor in widget.appointments)
                  TopDoctorCard(
                    appointmentModel: doctor,
                    img: 'https://img.freepik.com/premium-vector/avatar-male-doctor-with-black-hair-beard-doctor-with-stethoscope-vector-illustrationxa_276184-32.jpg',
                    doctorName: "${doctor.doctor_name}",
                    doctorTitle: "${doctor.clinic_name}",
                      time: '${doctor.appointment_time.length > 8 ? doctor.appointment_time.substring(0,8) : doctor.appointment_time}',
                      date: '${doctor.appointment_date.length > 10 ? doctor.appointment_date.substring(0,10) : doctor.appointment_date}'
                  )
          ],
        ),
      ),
    );
  }
}

class DateTimeCard extends StatelessWidget {
  const DateTimeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg03),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Color(MyColors.primary),
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Mon, July 29',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.access_alarm,
                color: Color(MyColors.primary),
                size: 17,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '11:00 ~ 12:10',
                style: TextStyle(
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
