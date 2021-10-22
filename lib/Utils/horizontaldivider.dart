import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalOrLine extends StatelessWidget {
  const HorizontalOrLine({
    this.color = Colors.black,
    this.label = "",
    this.height = 1,
  });

  final String label;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: new Container(
            margin: EdgeInsets.only(
                left: ScreenUtil().setSp(10),
                right: ScreenUtil().setSp(15)),
            child: Divider(
              color: color,
              height: height,

            )),
      ),

      Text(label),

      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: Divider(
              color: color,
              height: height,
            )),
      ),
    ]);
  }
}