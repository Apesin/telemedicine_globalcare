import 'package:doctor_app/bloc/states/appointment.dart';
import 'package:doctor_app/bloc/states/wallet.dart';
import 'package:doctor_app/constants.dart';
import 'package:doctor_app/models/appointmentModel.dart';
import 'package:doctor_app/persistence/persistence.dart';
import 'package:doctor_app/persistence/strings.dart';
import 'package:doctor_app/screens/appointments/viewAppointments.dart';
import 'package:doctor_app/screens/help/help.dart';
import 'package:doctor_app/screens/wallet/wallet.dart';
import 'package:doctor_app/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../tabs/HomeTab.dart';
import '../../tabs/ScheduleTab.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

List<Map> navigationBarItems = [
  {'icon': Icons.local_hospital, 'index': 0},
  {'icon': Icons.menu_book_outlined, 'index': 1},
  {'icon': Icons.credit_card, 'index': 2},
  {'icon': Icons.watch_later_outlined, 'index': 3},
];

class _HomeState extends State<Home> with TickerProviderStateMixin{
  late TabController tabController;
  String personId = "";
  int _selectedIndex = 0;
  String walletBalance = "0";
  List<AppointmentModel> appointments = [];
  WalletState _walletState = WalletState();
  AppointmentState _appointmentState = AppointmentState();

  void goToSchedule() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  getDetails() async{
    var pId = await getStringValuesSP(PrefStrings.PERSON_ID);
    var hId = await getStringValuesSP(PrefStrings.HOSPITAL_ID);
    var bId = await getStringValuesSP(PrefStrings.BRANCH_ID);
    _appointmentState.getFixedAppointments("$hId/$bId/$pId");
    setState(() {
      personId = pId.toString();
    });
    _walletState.getWalletBalance(personId);

  }

  @override
  void initState() {
    getDetails();
    _walletState.addListener(() {
      if(_walletState.walletGotten == "yes"){
        setState(() {
          walletBalance = _walletState.balance;
        });
        print(_walletState.balance);
      }
    });

    _appointmentState.addListener(() {
      if(_appointmentState.appointmentsGotten == "yes"){
        setState(() {
          appointments = _appointmentState.appointments;
        });
      }else if(_appointmentState.appointmentsGotten == "no"){
        setState(() {
          appointments = _appointmentState.appointments;
        });
      }
    });

    tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<Widget> screens = [
    //   HomeTab(
    //     onPressedScheduleCard: (){
    //       setState(() {
    //         _selectedIndex = 1;
    //       });
    //     },
    //   ),
    //   ScheduleTab(),
    //   Appointments(),
    //   Help()
    // ];

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: primaryColor,
          automaticallyImplyLeading: false,
          title: const Text(
            "GlobalCareHMS",
            style: TextStyle(
              fontFamily: 'Avenir',
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              color: Colors.white,
              child: TabBar(
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Colors.blue,
                  ),
                  ),
                indicatorColor: primaryColor,
                labelColor: primaryColor,
                unselectedLabelColor: Colors.black,
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w300,
                ),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                controller: tabController,
                tabs: const [
                  Tab(icon: Icon(Icons.home), text: 'Home'),
                  Tab(icon: Icon(Icons.menu_book_outlined), text: 'Appt.'),
                  Tab(icon: Icon(Icons.credit_card), text: 'Wallet'),
                  Tab(icon: Icon(Icons.watch_later_outlined), text: 'Help'),
                ],
              ),
            ),
          ),
          actions: [
            PopupMenuButton(
              icon: const FaIcon(
                FontAwesomeIcons.user,
                size: 20,
                color: Colors.white,
              ),
              onSelected: (value) {
                Helpers().logout(context);
              },
              itemBuilder: (BuildContext bc) {
                return [
                  PopupMenuItem(
                    value: '/logout',
                    child: Container(
                      color: primaryColor,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.signOutAlt,
                              size: 20,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Sign Out',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
            )
          ],
        ),
        body: TabBarView(
          controller: tabController,

          children: [
            HomeTab(
              personId: personId,
              wallet: (){
                tabController.animateTo(2);
              },
              onPressedScheduleCard: (){
                tabController.animateTo(1);
              },
            ),
            // ScheduleTab(appointments: appointments,),
            const ViewAppointments(),
            Wallet(personId: personId,balance: walletBalance,),
            Help()
          ],
        ),
      ),
    );
  }
}
