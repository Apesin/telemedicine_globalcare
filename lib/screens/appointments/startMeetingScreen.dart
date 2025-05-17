import 'dart:async';
import 'package:doctor_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:zoom_meeting_flutter_sdk/zoom_meeting_flutter_sdk.dart';


class StartMeeting extends StatefulWidget {
  String meetingId;
  String meetingPassword;
   StartMeeting(this.meetingId, this.meetingPassword, {super.key});



  @override
  _StartMeeting createState() => _StartMeeting();
}

class _StartMeeting extends State<StartMeeting> {
  final _zoomSDK = ZoomMeetingFlutterSdk();
  bool isInitialized = false;



  @override
  void initState() {
    super.initState();
    initPlatformState();
    initSDK();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GlobalCare Telemedicine'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: isInitialized ? _joinMeting : initSDK,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: primaryColor
                ),
                child: Text(isInitialized ? "Joining, kindly click this if it meeting doesnt start immediately" : "Click to start",
                  style: const TextStyle(color: Colors.white), textAlign: TextAlign.center,),
              ),
            )

          ],
        ),
      ),
    );
  }

  Future<void> initSDK() async{
    try {
      debugPrint("initPlatformState");
      if (!isInitialized) {
        final jwtToken = generateJWT();
        debugPrint("initZoom -> isInitialized = $isInitialized");
        isInitialized = (await _zoomSDK.initZoom(jwtToken: jwtToken)) ?? false;
        debugPrint("initZoom -> result = $isInitialized");

        if (isInitialized) {
          setState(() {});
        }
        _joinMeting();
      }
    } catch (e) {
      debugPrint("Error initializing Zoom: $e");
    }
  }

  Future<void> _joinMeting() async {
    debugPrint("Joining meeting");

    if (widget.meetingId.isEmpty ||
        widget.meetingPassword.isEmpty) {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter meeting number and your name")),
      );
      return;
    }
    await _zoomSDK.joinMeting(
      meetingNumber: widget.meetingId,
      meetingPassword: widget.meetingPassword,
      displayName: 'Patient',
    );

  }


  String generateJWT() {
    final jwt = JWT(
      {
        'appKey': "f6V7yl5iQousR0I12WBwlA",
        'mn': widget.meetingId,
        'role': 0, // 0 for participant, 1 for host
        'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'exp': (DateTime.now().millisecondsSinceEpoch ~/ 1000) + 3600, // 1 hour expiration
        'tokenExp': (DateTime.now().millisecondsSinceEpoch ~/ 1000) + 3600, // 1 hour expiration
      },
    );

    final token = jwt.sign(SecretKey("9UGS60mu9cQyqOwuxEJzxjheSSf7EXmd"), algorithm: JWTAlgorithm.HS256);
    return token;
  }

}