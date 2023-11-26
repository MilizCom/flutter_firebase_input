import 'package:flutter/material.dart';

NavigatePush(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

navigatePop(BuildContext context) {
  Navigator.of(context);
}
