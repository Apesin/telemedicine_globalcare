import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../constants.dart';

class Loader extends StatefulWidget{
  _Loader createState ()=> _Loader();
}

class _Loader extends State<Loader>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor.withOpacity(0.3),
      body: Center(
        child: Image.asset('assets/images/spinner.gif', width: 50,)
        // WidgetAnimator(
        //     incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(),
        //     atRestEffect: WidgetRestingEffects.pulse(),
        //   child: Image.asset('assets/images/spinner.gif', width: 50,)
        // ),
      ),
    );
  }
}