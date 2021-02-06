import 'package:flutter/material.dart';

Future push(BuildContext context, Widget page) {
  return Navigator.push(context, MaterialPageRoute(builder: (context){
    return page;
  }));
}

Future pushReplacement(BuildContext context, Widget page) {
  return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
    return page;
  }));
}

Future pushAndRemove(BuildContext context, Widget page){
  return Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context){
    return page;
  }),ModalRoute.withName('/'),);

}