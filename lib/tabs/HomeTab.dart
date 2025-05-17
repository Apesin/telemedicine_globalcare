import 'package:doctor_app/persistence/persistence.dart';
import 'package:doctor_app/persistence/strings.dart';
import 'package:doctor_app/screens/appointments/viewAppointments.dart';
import 'package:doctor_app/screens/home/doctor_detail.dart';
import 'package:doctor_app/screens/labResult/labResult.dart';
import 'package:doctor_app/screens/labResult/radiologyResult.dart';
import 'package:doctor_app/utils/helpers.dart';
import 'package:doctor_app/utils/navigation.dart';
import 'package:doctor_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';
import '../models/appointmentModel.dart';
import '../styles/colors.dart';
import '../styles/styles.dart';

class HomeTab extends StatefulWidget {
  final void Function() onPressedScheduleCard;
  final void Function() wallet;
  final String personId;

  const HomeTab({
    Key? key,
    required this.onPressedScheduleCard,
    required this.wallet,
    required this.personId
  }) : super(key: key);

  _HomeTab createState()=> _HomeTab();
}

class _HomeTab extends State<HomeTab>{

  bool isLoading = false;

  toggleLoader(){
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            child: Column(
              children: [
                // SearchInput(),
                // const SizedBox(
                //   height: 20,
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height-146,
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: <Widget>[
                      InkWell(
                        onTap: widget.wallet,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black.withOpacity(0.2))
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.2,
                                height: MediaQuery.of(context).size.width*0.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular((MediaQuery.of(context).size.width*0.2)/2),
                                    border: Border.all(color: Colors.grey.withOpacity(0.3))
                                ),
                                child: const Center(
                                  child: FaIcon(FontAwesomeIcons.creditCard, size: 20, color: Colors.blueAccent,),
                                ),
                              ),
                              const SizedBox(height: 5,),
                              const Text("Check Wallet Balance", style: TextStyle(
                                  fontFamily: 'Avenir', fontSize: 14
                              ), textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: widget.wallet,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black.withOpacity(0.2))
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.2,
                                height: MediaQuery.of(context).size.width*0.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular((MediaQuery.of(context).size.width*0.2)/2),
                                    border: Border.all(color: Colors.grey.withOpacity(0.3))
                                ),
                                child: const Center(
                                  child: FaIcon(FontAwesomeIcons.moneyBill, size: 20, color: Colors.blueAccent,),
                                ),
                              ),
                              const SizedBox(height: 5,),
                              const Text("Credit Wallet", style: TextStyle(
                                  fontFamily: 'Avenir', fontSize: 14
                              ), textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: widget.onPressedScheduleCard,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black.withOpacity(0.2))
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.2,
                                height: MediaQuery.of(context).size.width*0.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular((MediaQuery.of(context).size.width*0.2)/2),
                                  border: Border.all(color: Colors.grey.withOpacity(0.3))
                                ),
                                child: const Center(
                                  child: FaIcon(FontAwesomeIcons.arrowsDownToPeople, size: 20, color: Colors.blueAccent,),
                                ),
                              ),
                              const SizedBox(height: 5,),
                              const Text("View Appointments", style: TextStyle(
                                  fontSize: 14
                              ), textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, '/bookAppointment');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black.withOpacity(0.2))
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.2,
                                height: MediaQuery.of(context).size.width*0.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular((MediaQuery.of(context).size.width*0.2)/2),
                                    border: Border.all(color: Colors.grey.withOpacity(0.3))
                                ),
                                child: const Center(
                                  child: FaIcon(FontAwesomeIcons.bookOpen, size: 20, color: Colors.blueAccent,),
                                ),
                              ),
                              const SizedBox(height: 5,),
                              const Text("Book Appointments", style: TextStyle(
                                  fontFamily: 'Avenir', fontSize: 14
                              ), textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          pushPage(context, LabResult(personId: widget.personId));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black.withOpacity(0.2))
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.2,
                                height: MediaQuery.of(context).size.width*0.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular((MediaQuery.of(context).size.width*0.2)/2),
                                    border: Border.all(color: Colors.grey.withOpacity(0.3))
                                ),
                                child: const Center(
                                  child: FaIcon(FontAwesomeIcons.flask, size: 20, color: Colors.blueAccent,),
                                ),
                              ),
                              const SizedBox(height: 5,),
                              const Text("Lab Result", style: TextStyle(
                                  fontFamily: 'Avenir', fontSize: 14
                              ), textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          pushPage(context, RadiologyResult(personId: widget.personId));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black.withOpacity(0.2))
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.2,
                                height: MediaQuery.of(context).size.width*0.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular((MediaQuery.of(context).size.width*0.2)/2),
                                    border: Border.all(color: Colors.grey.withOpacity(0.3))
                                ),
                                child: const Center(
                                  child: FaIcon(FontAwesomeIcons.image, size: 20, color: Colors.blueAccent,),
                                ),
                              ),
                              const SizedBox(height: 5,),
                              const Text("Radiology Result", style: TextStyle(
                                  fontFamily: 'Avenir', fontSize: 14
                              ), textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black.withOpacity(0.2))
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.2,
                              height: MediaQuery.of(context).size.width*0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular((MediaQuery.of(context).size.width*0.2)/2),
                                  border: Border.all(color: Colors.grey.withOpacity(0.3))
                              ),
                              child: const Center(
                                child: FaIcon(FontAwesomeIcons.lock, size: 20, color: Colors.blueAccent,),
                              ),
                            ),
                            const SizedBox(height: 5,),
                            const Text("Send OTP", style: TextStyle(
                                fontFamily: 'Avenir', fontSize: 14
                            ), textAlign: TextAlign.center,)
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black.withOpacity(0.2))
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.2,
                              height: MediaQuery.of(context).size.width*0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular((MediaQuery.of(context).size.width*0.2)/2),
                                  border: Border.all(color: Colors.grey.withOpacity(0.3))
                              ),
                              child: const Center(
                                child: FaIcon(FontAwesomeIcons.solidFileLines, size: 20, color: Colors.blueAccent,),
                              ),
                            ),
                            const SizedBox(height: 5,),
                            const Text("Transaction Logs", style: TextStyle(
                                fontFamily: 'Avenir', fontSize: 14
                            ), textAlign: TextAlign.center,)
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Visibility(
            visible: isLoading,
            child: Loader())
      ],
    );
  }
}

class TopDoctorCard extends StatelessWidget {
  String img;
  String doctorName;
  String doctorTitle;
  String time;
  String date;
  AppointmentModel appointmentModel;

  TopDoctorCard({
    required this.img,
    required this.doctorName,
    required this.doctorTitle,
    required this.time,
    required this.date,
    required this.appointmentModel
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: () {
          pushPage(context, SliverDoctorDetail(appointmentModel: appointmentModel,));
        },
        child: Row(
          children: [
            Container(
              color: Color(MyColors.grey01),
              child: Image(
                width: 100,
                image: NetworkImage(img),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName,
                  style: TextStyle(
                    color: Color(MyColors.header01),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  doctorTitle,
                  style: TextStyle(
                    color: Color(MyColors.grey02),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   Text('$date'),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '$time',
                      style: TextStyle(color: Color(MyColors.grey02)),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


class ScheduleCard extends StatelessWidget {
  String time;
  String date;
   ScheduleCard({
    Key? key, required this.date, required this.time
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          Icon(
            Icons.calendar_today,
            color: Colors.black,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            '$date',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.access_alarm,
            color: Colors.black,
            size: 17,
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
            child: Text(
              '$time',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}


class SearchInput extends StatelessWidget {
  const SearchInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(MyColors.bg),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Avenir',
                    color: Color(MyColors.purple01),
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Icon(
              Icons.search,
              color: Color(MyColors.purple02),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}

class UserIntro extends StatefulWidget {
  const UserIntro({
    Key? key,
  }) : super(key: key);

  _UserIntro createState()=> _UserIntro();
}

class _UserIntro extends State<UserIntro>{
  String myName = "";


  @override
  void initState() {
    getName();
    super.initState();
  }

  getName() async{
    var name = await getStringValuesSP(PrefStrings.FIRSTNAME);
    setState(() {
      myName = name;
    });
  }

  logout() async{
    await removeValues(PrefStrings.FIRSTNAME);
    await removeValues(PrefStrings.LASTNAME);
    await removeValues(PrefStrings.HOSPITAL_NAME);
    await removeValues(PrefStrings.HOSPITAL_ID);
    await removeValues(PrefStrings.BRANCH_NAME);
    await removeValues(PrefStrings.BRANCH_ID);
    await removeValues(PrefStrings.LOGGED_IN);
    await removeValues(PrefStrings.OTP);
    await removeValues(PrefStrings.USERNAME);

    Navigator.pushNamed(context, '/');

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${Helpers().getGreetings()}',
              style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Cabin', fontSize: 20),
            ),
            Text(
              '$myName 👋',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, fontFamily: 'Avenir'),
            ),
          ],
        ),
         InkWell(
           onTap: (){
             showModalBottomSheet(
                 isScrollControlled:true,
                 context: context,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.vertical(
                     top: Radius.circular(20),
                   ),
                 ),
                 clipBehavior: Clip.antiAliasWithSaveLayer,
                 builder: (builder){
                   return new Container(
                     height: MediaQuery.of(context).size.height-30,
                     color: Colors.transparent, //could change this to Color(0xFF737373),
                     //so you don't have to change MaterialApp canvasColor
                     child: new Container(
                         decoration: new BoxDecoration(
                             color: Colors.white,
                             borderRadius: new BorderRadius.only(
                                 topLeft: const Radius.circular(20.0),
                                 topRight: const Radius.circular(20.0))),
                         child: new Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             InkWell(
                               onTap: (){
                                 Navigator.pop(context);

                               },
                               child: Container(
                                 width: MediaQuery.of(context).size.width*0.6,
                                 height: 50,
                                 decoration: BoxDecoration(
                                     color: primaryColor,
                                     borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topRight: Radius.circular(10), topLeft: Radius.circular(10))
                                 ),
                                 child: Center(
                                   child: Text("Change Pin", style: TextStyle(
                                       fontFamily: 'Avenir', fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold
                                   ),),
                                 ),
                               ),
                             ),
                             SizedBox(height: 10,),
                             InkWell(
                               onTap: (){
                                 Navigator.pop(context);
                                 logout();
                               },
                               child: Container(
                                 width: MediaQuery.of(context).size.width*0.6,
                                 height: 50,
                                 decoration: BoxDecoration(
                                     color: Colors.red,
                                     borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topRight: Radius.circular(10), topLeft: Radius.circular(10))
                                 ),
                                 child: Center(
                                   child: Text("Logout", style: TextStyle(
                                       fontFamily: 'Avenir', fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold
                                   ),),
                                 ),
                               ),
                             ),

                           ],
                         ),),
                   );
                 }
             );
           },
           child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/person.jpeg'),
        ),
         )
      ],
    );
  }
}
