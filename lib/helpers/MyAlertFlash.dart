import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

class MyAlertFlash{
  //showBasicsFlash(duration: Duration(seconds: 2));
  showBasicsFlash({Duration duration, flashStyle = FlashStyle.floating, BuildContext context}){
    showFlash(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          style: flashStyle,
          boxShadows: kElevationToShadow[4],
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          child: FlashBar(
            message: Text('This is a basic flash'),
          ),
        );
      },
    );
  }

  //showBottomFlash(margin: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 34.0));
  showBottomFlash({bool persistent = true, EdgeInsets margin = EdgeInsets.zero, BuildContext context}) {
    showFlash(
      context: context,
      persistent: persistent,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          margin: margin,
          borderRadius: BorderRadius.circular(8.0),
          borderColor: Colors.blue,
          boxShadows: kElevationToShadow[8],
          backgroundGradient: RadialGradient(
            colors: [Colors.amber, Colors.black87],
            center: Alignment.topLeft,
            radius: 2,
          ),
          onTap: () => controller.dismiss(),
          forwardAnimationCurve: Curves.easeInCirc,
          reverseAnimationCurve: Curves.bounceIn,
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: FlashBar(
              title: Text('Hello Flash'),
              message: Text('You can put any message of any length here.'),
              leftBarIndicatorColor: Colors.red,
              icon: Icon(Icons.info_outline),
              primaryAction: FlatButton(
                onPressed: () => controller.dismiss(),
                child: Text('DISMISS'),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => controller.dismiss('Yes, I do!'),
                    child: Text('YES')),
                FlatButton(
                    onPressed: () => controller.dismiss('No, I do not!'),
                    child: Text('NO')),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      if (_ != null) {
        showMessage(_.toString(), context);
      }
    });
  }

  showMessage(String message, BuildContext context) {
//    if (!mounted) return;
    showFlash(
        context: context,
        duration: Duration(seconds: 3),
        builder: (_, controller) {
          return Flash(
            controller: controller,
            position: FlashPosition.top,
            style: FlashStyle.grounded,
            child: FlashBar(
              icon: Icon(
                Icons.face,
                size: 36.0,
                color: Colors.black,
              ),
              message: Text(message),
            ),
          );
        });
  }

  //showTopFlash(style: FlashStyle.grounded)
  showTopFlash_({String msg, BuildContext context, String position}) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 6),
      persistent: true,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          backgroundColor: Colors.red,
          brightness: Brightness.light,
          boxShadows: [BoxShadow(blurRadius: 4)],
          barrierBlur: 3.0,
          insetAnimationDuration: Duration(seconds: 3),
          barrierColor: Colors.black38,
          barrierDismissible: false,
          style: FlashStyle.grounded,
          position: position=="BOTTOM" ? FlashPosition.bottom : FlashPosition.top,
          child: FlashBar(
            title: Text('Information', style: TextStyle(color: Colors.white, fontSize: 15.0)),
            message: Text('${msg}', style: TextStyle(color: Colors.white, fontSize: 15.0)),
//            showProgressIndicator: true,
            primaryAction: FlatButton(
              onPressed: () => controller.dismiss(),
              child: Text('Close', style: TextStyle(color: Colors.amber)),
            ),
          ),
        );
      },
    );
  }

  showTopFlash(BuildContext context,{FlashStyle style = FlashStyle.floating, String msg}) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 5),
      persistent: true,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          boxShadows: [BoxShadow(blurRadius: 4)],
          barrierBlur: 3.0,
          insetAnimationDuration: Duration(seconds: 5),
          barrierColor: Colors.black38,
          barrierDismissible: false,
          style: FlashStyle.grounded,
          position: FlashPosition.top,
          child: FlashBar(
            title: Text('Informasi', style: TextStyle(color: Colors.black, fontSize: 15.0)),
            message: Text('${msg}', style: TextStyle(color: Colors.black, fontSize: 15.0)),
//            showProgressIndicator: true,
            primaryAction: FlatButton(
              onPressed: () => controller.dismiss(),
              child: Text('Tutup', style: TextStyle(color: Colors.amber)),
            ),
          ),
        );
      },
    );
  }
}