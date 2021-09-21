import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/Screen/LogInScreen.dart';
import 'package:report_visita_danilo/Screen/Registration.dart';
import 'package:report_visita_danilo/Utils/authService.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

class AccountEmpty extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountEmptyState();
}

class AccountEmptyState extends State<AccountEmpty> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.grey[700]),
          title: Text("Account",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 24.151785.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700]),
          ),
        ),
        body: AuthService().handleAuth()
      );

  }
}
