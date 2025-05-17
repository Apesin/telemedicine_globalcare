// import 'dart:typed_data';
//
// import 'package:doctor_app/constants.dart';
// import 'package:doctor_app/models/departmentModel.dart';
// import 'package:doctor_app/persistence/persistence.dart';
// import 'package:doctor_app/persistence/strings.dart';
// import 'package:doctor_app/widgets/loader.dart';
// import 'package:flutter/material.dart';
// import 'dart:math' as math;
// import 'dart:ui' as ui;
//
//
// import 'package:flutter/rendering.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
//
// import '../../widgets/alert.dart';
//
// class GenerateToken extends StatefulWidget{
//   _GenerateToken createState ()=> _GenerateToken();
// }
//
// class _GenerateToken extends State<GenerateToken>{
//   GlobalKey _globalKey = GlobalKey();
//   bool isLoading = true;
//   String hospitalName = "";
//   String branchName = "";
//   String patientName = "";
//
//
//   getDetails() async{
//     var h = await getStringValuesSP(PrefStrings.HOSPITAL_NAME);
//     var b = await getStringValuesSP(PrefStrings.BRANCH_NAME);
//     var p = await getStringValuesSP(PrefStrings.FIRSTNAME);
//     setState(() {
//       hospitalName = h;
//       branchName = b;
//       patientName = p;
//     });
//   }
//
//   _saveScreen() async {
//     RenderRepaintBoundary boundary =
//     _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//     ui.Image image = await boundary.toImage();
//     ByteData? byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
//     if (byteData != null) {
//       final result =
//       await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
//       if(result['isSuccess']){
//         Alerts().showAlert(context, true, "Saved to gallery");
//       }else{
//         Alerts().showAlert(context, false, "Unable to save to gallery");
//
//       }
//     }
//   }
//
//
//   @override
//   void initState() {
//     getDetails();
//     Future.delayed(Duration(seconds: 3)).then((value){
//       setState(() {
//         isLoading = false;
//       });
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Scaffold(
//           appBar: AppBar(
//             backgroundColor: primaryColor,
//             centerTitle: true,
//             title: Text("Generate token", style: TextStyle(
//                 fontFamily: 'Avenir', fontSize: 20
//             ),),
//           ),
//           body: ListView.builder(
//               itemCount: _departments.length,
//               itemBuilder: (BuildContext context, int index){
//                 return ListTile(
//                   onTap: (){
//                     setState(() {
//                       isLoading = true;
//                     });
//                     Future.delayed(Duration(seconds: 2)).then((value){
//                       setState(() {
//                         isLoading = false;
//                       });
//                       showModalBottomSheet(
//                           context: context,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.vertical(
//                               top: Radius.circular(20),
//                             ),
//                           ),
//                           clipBehavior: Clip.antiAliasWithSaveLayer,
//                           builder: (builder){
//                             return  Container(
//                               width: 450,
//                               child: Column(
//                                 children: [
//                                   RepaintBoundary(
//                                       key: _globalKey,
//                                       child: Container(
//                                         height: 350.0,
//                                         color: Colors.transparent,
//                                         child: new Container(
//                                             decoration: new BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius: new BorderRadius.only(
//                                                     topLeft: const Radius.circular(20.0),
//                                                     topRight: const Radius.circular(20.0))),
//                                             child: new Center(
//                                               child: Container(
//                                                 height:250,
//                                                 width: MediaQuery.of(context).size.width*0.8,
//                                                 decoration: BoxDecoration(
//                                                   border: Border.all(color: Colors.grey.withOpacity(0.3)),
//                                                   borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10) ),
//                                                 ),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(8.0),
//                                                   child: Column(
//                                                     mainAxisAlignment: MainAxisAlignment.center,
//                                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                                     children: [
//                                                       Text("$hospitalName", style: TextStyle(
//                                                         fontSize: 25, fontFamily: 'Avenir', fontWeight: FontWeight.bold,
//                                                       ),),
//                                                       SizedBox(),
//                                                       Text("No 37 Usuma street maitama Abuja, Nigeria",style: TextStyle(
//                                                           fontFamily: 'Avenir'
//                                                       )),
//                                                       Text("Token No:",style: TextStyle(
//                                                           fontFamily: 'Avenir'
//                                                       )),
//                                                       Text("${_departments[index].title} - 0001", style: TextStyle(
//                                                           fontFamily: 'Avenir', fontSize: 20, fontWeight: FontWeight.bold
//                                                       ),),
//                                                       Container(
//                                                         width: MediaQuery.of(context).size.width,
//                                                         height: 20,
//                                                         child: Row(
//                                                           mainAxisAlignment: MainAxisAlignment.center,
//                                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                                           children: [
//                                                             Text("Patient No: ", style: TextStyle(
//                                                                 fontFamily: 'Avenir', fontSize: 20
//                                                             ),),
//                                                             Text("78813", style: TextStyle(
//                                                                 fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Avenir'
//                                                             ),),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         width: MediaQuery.of(context).size.width,
//                                                         height: 20,
//                                                         child: Row(
//                                                           mainAxisAlignment: MainAxisAlignment.center,
//                                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                                           children: [
//                                                             Text("Patient Name: ", style: TextStyle(
//                                                                 fontFamily: 'Avenir', fontSize: 20
//                                                             ),),
//                                                             Text("$patientName", style: TextStyle(
//                                                                 fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Avenir'
//                                                             ),),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         width: MediaQuery.of(context).size.width,
//                                                         height: 20,
//                                                         child: Row(
//                                                           mainAxisAlignment: MainAxisAlignment.center,
//                                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                                           children: [
//                                                             Text("Clinic:", style: TextStyle(
//                                                                 fontFamily: 'Avenir', fontSize: 20
//                                                             ),),
//                                                             Text("${_departments[index].title}", style: TextStyle(
//                                                                 fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Avenir'
//                                                             ),),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         width: MediaQuery.of(context).size.width,
//                                                         height: 20,
//                                                         child: Row(
//                                                           mainAxisAlignment: MainAxisAlignment.center,
//                                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                                           children: [
//                                                             Text("Date / Time: ", style: TextStyle(
//                                                                 fontFamily: 'Avenir', fontSize: 20
//                                                             ),),
//                                                             Text("${DateTime.now().toString().substring(0,10)} ${DateTime.now().toString().substring(11,16)}", style: TextStyle(
//                                                                 fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Avenir'
//                                                             ),),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         width: MediaQuery.of(context).size.width,
//                                                         height: 20,
//                                                         child: Row(
//                                                           mainAxisAlignment: MainAxisAlignment.center,
//                                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                                           children: [
//                                                             Text("Card No: ", style: TextStyle(
//                                                                 fontFamily: 'Avenir', fontSize: 20
//                                                             ),),
//                                                             Text("0012212970", style: TextStyle(
//                                                                 fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Avenir'
//                                                             ),),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             )),
//                                       )
//                                   ),
//                                   InkWell(
//                                     onTap: (){
//                                       Navigator.pop(context);
//                                       _saveScreen();
//                                     },
//                                     child: Container(
//                                       width: MediaQuery.of(context).size.width*0.6,
//                                       height: 50,
//                                       decoration: BoxDecoration(
//                                           color: primaryColor,
//                                           borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topRight: Radius.circular(10), topLeft: Radius.circular(10))
//                                       ),
//                                       child: Center(
//                                         child: Text("Save to gallery", style: TextStyle(
//                                             fontFamily: 'Avenir', fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold
//                                         ),),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }
//                       );
//                     });
//
//                   },
//                   title: Text("${_departments[index].title}", style: TextStyle(fontFamily: 'Avenir'),),
//                   subtitle: Text("${_departments[index].description}",style: TextStyle(fontFamily: 'Avenir')),
//                   leading: Container(
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                         color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)
//                     ),
//                     child: Center(
//                       child: Text("${_departments[index].title.substring(0,2).toUpperCase()}", style: TextStyle(
//                           color: Colors.white, fontFamily: 'Avenir', fontSize: 15
//                       ),),
//                     ),
//                   ),
//                 );
//               }),
//         ),
//         Visibility(
//             visible: isLoading,
//             child: Loader())
//       ],
//     );
//   }
// }