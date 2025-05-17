// import 'package:doctor_app/persistence/persistence.dart';
// import 'package:doctor_app/persistence/strings.dart';
// import 'package:doctor_app/utils/helpers.dart';
// import 'package:doctor_app/widgets/loader.dart';
// import 'package:flutter/material.dart';
//
// import '../constants.dart';
// import '../styles/colors.dart';
// import '../styles/styles.dart';
//
// List<Map> doctors = [
//   {
//     'img': 'assets/images/doctor02.png',
//     'doctorName': 'Dr. Fatai Ahmed',
//     'doctorTitle': 'Heart Specialist'
//   },
//   {
//     'img': 'assets/images/doctor03.jpeg',
//     'doctorName': 'Dr. Bola Tinubu',
//     'doctorTitle': 'Skin Specialist'
//   },
//   {
//     'img': 'assets/images/doctor02.png',
//     'doctorName': 'Dr. Samuel Badmus',
//     'doctorTitle': 'Heart Specialist'
//   },
//   {
//     'img': 'assets/images/doctor03.jpeg',
//     'doctorName': 'Dr. Abdullahi Shehu',
//     'doctorTitle': 'Skin Specialist'
//   }
// ];
//
// class HomeTab extends StatefulWidget {
//   final void Function() onPressedScheduleCard;
//
//   const HomeTab({
//     Key? key,
//     required this.onPressedScheduleCard,
//   }) : super(key: key);
//
//   _HomeTab createState()=> _HomeTab();
// }
//
// class _HomeTab extends State<HomeTab>{
//
//   bool isLoading = false;
//
//   toggleLoader(){
//     setState(() {
//       isLoading = !isLoading;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         GestureDetector(
//           onTap: () => FocusScope.of(context).unfocus(),
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 30),
//             child: ListView(
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 UserIntro(),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 SearchInput(),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 CategoryIcons(
//                   toggle: ()=> toggleLoader(),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Appointment Today',
//                       style: kTitleStyle,
//                     ),
//                     TextButton(
//                       child: Text(
//                         'See All',
//                         style: TextStyle(
//                           color: Color(MyColors.yellow01),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       onPressed: () {},
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 AppointmentCard(
//                   onTap: widget.onPressedScheduleCard,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   'Recent Appointments',
//                   style: TextStyle(
//                     color: Color(MyColors.header01),
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 for (var doctor in doctors)
//                   TopDoctorCard(
//                     img: doctor['img'],
//                     doctorName: doctor['doctorName'],
//                     doctorTitle: doctor['doctorTitle'],
//                   )
//               ],
//             ),
//           ),
//         ),
//         Visibility(
//             visible: isLoading,
//             child: Loader())
//       ],
//     );
//   }
// }
//
// class TopDoctorCard extends StatelessWidget {
//   String img;
//   String doctorName;
//   String doctorTitle;
//
//   TopDoctorCard({
//     required this.img,
//     required this.doctorName,
//     required this.doctorTitle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.only(bottom: 20),
//       child: InkWell(
//         onTap: () {
//           Navigator.pushNamed(context, '/detail');
//         },
//         child: Row(
//           children: [
//             Container(
//               color: Color(MyColors.grey01),
//               child: Image(
//                 width: 100,
//                 image: AssetImage(img),
//               ),
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   doctorName,
//                   style: TextStyle(
//                     color: Color(MyColors.header01),
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   doctorTitle,
//                   style: TextStyle(
//                     color: Color(MyColors.grey02),
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.star,
//                       color: Color(MyColors.yellow02),
//                       size: 18,
//                     ),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Text(
//                       '4.0 - 50 Reviews',
//                       style: TextStyle(color: Color(MyColors.grey02)),
//                     )
//                   ],
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class AppointmentCard extends StatelessWidget {
//   final void Function() onTap;
//
//   const AppointmentCard({
//     Key? key,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: Color(MyColors.primary),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Material(
//             color: Colors.transparent,
//             child: InkWell(
//               onTap: onTap,
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         CircleAvatar(
//                           backgroundImage: AssetImage('assets/images/doctor01.jpeg'),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Dr. Abdullahi Shehu',
//                                 style: TextStyle(color: Colors.white)),
//                             SizedBox(
//                               height: 2,
//                             ),
//                             Text(
//                               'Dental Specialist',
//                               style: TextStyle(color: Color(MyColors.text01)),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     ScheduleCard(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 20),
//           width: double.infinity,
//           height: 10,
//           decoration: BoxDecoration(
//             color: Color(MyColors.bg02),
//             borderRadius: BorderRadius.only(
//               bottomRight: Radius.circular(10),
//               bottomLeft: Radius.circular(10),
//             ),
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 40),
//           width: double.infinity,
//           height: 10,
//           decoration: BoxDecoration(
//             color: Color(MyColors.bg03),
//             borderRadius: BorderRadius.only(
//               bottomRight: Radius.circular(10),
//               bottomLeft: Radius.circular(10),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// List<Map> categories = [
//   {'icon': Icons.wallet, 'text': 'Check Balance'},
//   {'icon': Icons.local_hospital, 'text': 'Generate token'},
//   {'icon': Icons.numbers, 'text': 'Fund wallet'},
//   {'icon': Icons.local_pharmacy, 'text': 'Book Appointment'},
// ];
//
// class CategoryIcons extends StatelessWidget {
//   Function toggle;
//   CategoryIcons({
//     Key? key, required this.toggle
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         for (var category in categories)
//           CategoryIcon(
//             function: toggle,
//             icon: category['icon'],
//             text: category['text'],
//           ),
//       ],
//     );
//   }
// }
//
// class ScheduleCard extends StatelessWidget {
//   const ScheduleCard({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Color(MyColors.bg01),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       width: double.infinity,
//       padding: EdgeInsets.all(20),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: const [
//           Icon(
//             Icons.calendar_today,
//             color: Colors.white,
//             size: 15,
//           ),
//           SizedBox(
//             width: 5,
//           ),
//           Text(
//             'Mon, July 29',
//             style: TextStyle(color: Colors.white),
//           ),
//           SizedBox(
//             width: 20,
//           ),
//           Icon(
//             Icons.access_alarm,
//             color: Colors.white,
//             size: 17,
//           ),
//           SizedBox(
//             width: 5,
//           ),
//           Flexible(
//             child: Text(
//               '11:00 ~ 12:10',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class CategoryIcon extends StatelessWidget {
//   IconData icon;
//   String text;
//   Function function;
//   CategoryIcon({
//     required this.icon,
//     required this.text,
//     required this.function
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       splashColor: Color(MyColors.bg01),
//       onTap: () {
//         if(text == "Fund wallet"){
//           showModalBottomSheet(
//               context: context,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.vertical(
//                   top: Radius.circular(20),
//                 ),
//               ),
//               clipBehavior: Clip.antiAliasWithSaveLayer,
//               builder: (builder){
//                 return new Container(
//                   height: 350.0,
//                   color: Colors.transparent, //could change this to Color(0xFF737373),
//                   //so you don't have to change MaterialApp canvasColor
//                   child: new Container(
//                       decoration: new BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: new BorderRadius.only(
//                               topLeft: const Radius.circular(20.0),
//                               topRight: const Radius.circular(20.0))),
//                       child: new Center(
//                         child: Container(
//                           height:150,
//                           width: MediaQuery.of(context).size.width*0.8,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.withOpacity(0.3)),
//                             borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10) ),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text('Fund Your Wallet', style: TextStyle(color: Colors.grey, fontFamily: 'Avenir', fontSize: 13),),
//                                 Text('Bank: WEMA BANK', style: TextStyle(fontFamily: 'Avenir')),
//                                 Container(
//                                   width: 150,
//                                   height: 30,
//                                   decoration: BoxDecoration(
//                                       color: Colors.blueGrey.withOpacity(0.4),
//                                       borderRadius: BorderRadius.circular(10)
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(Icons.copy, color: Colors.grey,),
//                                       Text('01234567890')
//                                     ],
//                                   ),
//                                 ),
//                                 Text('Account name: Habib Yunusa', style: TextStyle(fontFamily: 'Avenir')),
//                                 SizedBox(height: 3,),
//                                 Text('This works like a regular bank account number. Transfer from any source to 1234567890. Select WEMA BANK as the destination bank. Verify that the beneficiary account name is "Habib Yunusa". Funds transferred will reflect in your balance instantly.',
//                                   style: TextStyle(
//                                       fontSize: 12, fontFamily: 'Avenir'
//                                   ), textAlign: TextAlign.center,)
//                               ],
//                             ),
//                           ),
//                         ),
//                       )),
//                 );
//               }
//           );
//         }else if(text == "Generate token"){
//           Navigator.pushNamed(context, '/generateToken');
//         }else if(text == "Check Balance"){
//           function();
//           Future.delayed(Duration(seconds: 2)).then((value){
//             function();
//             showModalBottomSheet(
//                 context: context,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.vertical(
//                     top: Radius.circular(20),
//                   ),
//                 ),
//                 clipBehavior: Clip.antiAliasWithSaveLayer,
//                 builder: (builder){
//                   return new Container(
//                     height: 200.0,
//                     color: Colors.transparent, //could change this to Color(0xFF737373),
//                     //so you don't have to change MaterialApp canvasColor
//                     child: new Container(
//                         decoration: new BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: new BorderRadius.only(
//                                 topLeft: const Radius.circular(20.0),
//                                 topRight: const Radius.circular(20.0))),
//                         child: new Center(
//                           child: Container(
//                             height:100,
//                             width: MediaQuery.of(context).size.width*0.8,
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey.withOpacity(0.3)),
//                               borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10) ),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text("Wallet Balance", style: TextStyle(
//                                       fontSize: 16, fontFamily: 'Avenir'
//                                   ),),
//                                   Text("NGN 10000000000000000", style: TextStyle(
//                                       fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'Avenir'
//                                   ),)
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )),
//                   );
//                 }
//             );
//           });
//         }
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(4.0),
//         child: Column(
//           children: [
//             Container(
//               width: 50,
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Color(MyColors.bg),
//                 borderRadius: BorderRadius.circular(50),
//               ),
//               child: Icon(
//                 icon,
//                 color: Color(MyColors.primary),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               text,
//               style: TextStyle(
//                   color: Color(MyColors.primary),
//                   fontSize: 13,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: 'Avenir'
//               ),
//               overflow: TextOverflow.fade,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class SearchInput extends StatelessWidget {
//   const SearchInput({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Color(MyColors.bg),
//         borderRadius: BorderRadius.circular(5),
//       ),
//       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             child: TextField(
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 hintText: 'Search',
//                 hintStyle: TextStyle(
//                     fontSize: 25,
//                     fontFamily: 'Avenir',
//                     color: Color(MyColors.purple01),
//                     fontWeight: FontWeight.w700),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 3),
//             child: Icon(
//               Icons.search,
//               color: Color(MyColors.purple02),
//             ),
//           ),
//           const SizedBox(
//             width: 15,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class UserIntro extends StatefulWidget {
//   const UserIntro({
//     Key? key,
//   }) : super(key: key);
//
//   _UserIntro createState()=> _UserIntro();
// }
//
// class _UserIntro extends State<UserIntro>{
//   String myName = "";
//
//
//   @override
//   void initState() {
//     getName();
//     super.initState();
//   }
//
//   getName() async{
//     var name = await getStringValuesSP(PrefStrings.FIRSTNAME);
//     setState(() {
//       myName = name;
//     });
//   }
//
//   logout() async{
//     await removeValues(PrefStrings.FIRSTNAME);
//     await removeValues(PrefStrings.LASTNAME);
//     await removeValues(PrefStrings.HOSPITAL_NAME);
//     await removeValues(PrefStrings.HOSPITAL_ID);
//     await removeValues(PrefStrings.BRANCH_NAME);
//     await removeValues(PrefStrings.BRANCH_ID);
//     await removeValues(PrefStrings.LOGGED_IN);
//     await removeValues(PrefStrings.OTP);
//     await removeValues(PrefStrings.USERNAME);
//
//     Navigator.pushNamed(context, '/');
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               '${Helpers().getGreetings()}',
//               style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Cabin', fontSize: 20),
//             ),
//             Text(
//               '$myName 👋',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, fontFamily: 'Avenir'),
//             ),
//           ],
//         ),
//         InkWell(
//           onTap: (){
//             showModalBottomSheet(
//                 isScrollControlled:true,
//                 context: context,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.vertical(
//                     top: Radius.circular(20),
//                   ),
//                 ),
//                 clipBehavior: Clip.antiAliasWithSaveLayer,
//                 builder: (builder){
//                   return new Container(
//                     height: MediaQuery.of(context).size.height-30,
//                     color: Colors.transparent, //could change this to Color(0xFF737373),
//                     //so you don't have to change MaterialApp canvasColor
//                     child: new Container(
//                       decoration: new BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: new BorderRadius.only(
//                               topLeft: const Radius.circular(20.0),
//                               topRight: const Radius.circular(20.0))),
//                       child: new Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           InkWell(
//                             onTap: (){
//                               Navigator.pop(context);
//
//                             },
//                             child: Container(
//                               width: MediaQuery.of(context).size.width*0.6,
//                               height: 50,
//                               decoration: BoxDecoration(
//                                   color: primaryColor,
//                                   borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topRight: Radius.circular(10), topLeft: Radius.circular(10))
//                               ),
//                               child: Center(
//                                 child: Text("Change Pin", style: TextStyle(
//                                     fontFamily: 'Avenir', fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold
//                                 ),),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10,),
//                           InkWell(
//                             onTap: (){
//                               Navigator.pop(context);
//                               logout();
//                             },
//                             child: Container(
//                               width: MediaQuery.of(context).size.width*0.6,
//                               height: 50,
//                               decoration: BoxDecoration(
//                                   color: Colors.red,
//                                   borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topRight: Radius.circular(10), topLeft: Radius.circular(10))
//                               ),
//                               child: Center(
//                                 child: Text("Logout", style: TextStyle(
//                                     fontFamily: 'Avenir', fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold
//                                 ),),
//                               ),
//                             ),
//                           ),
//
//                         ],
//                       ),),
//                   );
//                 }
//             );
//           },
//           child: CircleAvatar(
//             backgroundImage: AssetImage('assets/images/person.jpeg'),
//           ),
//         )
//       ],
//     );
//   }
// }
