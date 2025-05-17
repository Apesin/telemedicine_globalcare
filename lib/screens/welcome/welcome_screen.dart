import 'package:doctor_app/constants.dart';
import 'package:doctor_app/persistence/persistence.dart';
import 'package:doctor_app/persistence/strings.dart';
import 'package:doctor_app/screens/auth/anonymousLogin.dart';
import 'package:doctor_app/screens/auth/sign_in_screen.dart';
import 'package:doctor_app/screens/auth/sign_up_screen.dart';
import 'package:doctor_app/screens/home/home.dart';
import 'package:doctor_app/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  _WelcomeScreen createState()=> _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen>{
  bool showLoginButton = false;
  check() async{
    var loggedIn = await getStringValuesSP(PrefStrings.LOGGED_IN);
    if(loggedIn == "yes"){
      pushPageAsReplacement(context, const Home());
    }else{
      setState(() {
        showLoginButton = true;
      });
    }

  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5)).then((value){
      check();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                children: [
                  const Spacer(),
                  Image.asset('assets/images/logo.png', width: 100,),
                  const SizedBox(),
                  TextAnimator('GlobalCare PSSA', style: const TextStyle(
                    fontFamily: 'Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: 50, color: Colors.white,
                  ),
                    textAlign: TextAlign.center,
                    incomingEffect: WidgetTransitionEffects(blur: const Offset(2, 2), duration: const Duration(milliseconds: 600)),
                    atRestEffect: WidgetRestingEffects.wave(),
                    outgoingEffect: WidgetTransitionEffects(blur: const Offset(2, 2), duration: const Duration(milliseconds: 600)),
                  ),
                  const Spacer(),
                  Visibility(
                      visible: showLoginButton,
                      child: WidgetAnimator(
                            incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(),
                            // atRestEffect: WidgetRestingEffects.slide(),
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding),
                          child: SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignInScreen(),
                                  )),
                              style: TextButton.styleFrom(
                                // backgroundColor: Color(0xFF6CD8D1),
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), ),
                                  side: BorderSide(color: Colors.white),
                                ),
                              ),
                              child: const Text("Sign In", style: TextStyle(fontSize: 20, color: Colors.white),),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(height: defaultPadding),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
