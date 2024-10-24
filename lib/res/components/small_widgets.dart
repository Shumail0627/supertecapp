import 'package:flutter/material.dart';

//push navigate

pushNavigate(context, route) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => route));
}

//replace navigate

replacedNavigate(context, route) {
  return Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => route));
}

//pop navigate

popNavigate(context) {
  return Navigator.pop(context);
}

//popuntil navigate

popUntilNavigate(context) {
  return Navigator.popUntil(context, (route) => route.isFirst);
}

//sizedbox

sizedBox({double? h, double? width}) {
  return SizedBox(
    height: h ?? 20,
    width: width,
  );
}

//vertical padding

verticalPadding({double? v, double? h, required Widget child}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: v ?? 20, horizontal: h ?? 0),
    child: child,
  );
}

//horizontal padding

horizontalPadding({double? h, required Widget child}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: h ?? 20),
    child: child,
  );
}
