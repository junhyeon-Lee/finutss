import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class TestResolutionScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.red,
              width: 200.r,
              height: 200.r,
              child: Center(child: Text('SOMETHING', style: TextStyle(fontSize: 30.sp, color: Colors.white),)),
            ),
            Center(child: Text('SOMETHING', style: TextStyle(fontSize: 30, color: Colors.black),)),
            Container(
              color: Colors.red,
              width: 100,
              height: 100,
              child: Center(child: Text('SOMETHING', style: TextStyle(fontSize: 30, color: Colors.white),)),
            ),
          ],
        ),
      ),
    );
  }
}
