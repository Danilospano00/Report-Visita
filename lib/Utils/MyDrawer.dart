import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/Models/factory/filter.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>_MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  static bool bassa=true;
  static bool media=true;
  static bool alta=true;

  @override
  void initState() {
    super.initState();
    print("open");
  }

  @override
  void dispose() {
    print("close");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title:  AutoSizeText('Filtra per urgenza',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp
              ),),
            leading: IconButton(icon: Icon(Icons.close,size:30),onPressed: (){
              Navigator.pop(context);
            },),
          ),
          Padding(
            padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*.20,left: 16.w,right: 16.w),
            child: Row(
              mainAxisSize: MainAxisSize.max,


              children: [
                Checkbox(
                  value: bassa,
                  activeColor: Colors.grey,
                  onChanged: (value) {
                    setState(() {
                      bassa = value!;
                    });
                    context.read<FilterModel>().setFilter(bassa, media, alta);
                  },
                ),
                Expanded(
                  child:AutoSizeText('Priorità Bassa',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp
                    ),) ,
                ),
                Padding(
                  padding:  EdgeInsets.only(right: 8.w),
                  child: Icon(
                    Icons.circle,
                    color: Colors.greenAccent,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:16.h,left: 16.w,right: 16.w),
            child: Row(

              children: [
                Checkbox(
                  value: media,
                  activeColor: Colors.grey,
                  onChanged: (value) {
                    setState(() {
                      media = value!;
                    });
                    context.read<FilterModel>().setFilter(bassa, media, alta);
                  },
                ),
                Expanded(
                  child:AutoSizeText('Priorità Media',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp
                    ),) ,
                ),
                Padding(
                  padding:  EdgeInsets.only(right: 8.w),
                  child: Icon(
                    Icons.circle,
                    color: Colors.yellowAccent,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:16.h,left: 16.w,right: 16.w),
            child: Row(

              children: [
                Checkbox(
                  value: alta,
                  activeColor: Colors.grey,
                  onChanged: (value) {
                    setState(() {
                      alta = value!;
                    });
                    context.read<FilterModel>().setFilter(bassa, media, alta);
                  },
                ),
                Expanded(
                  child:AutoSizeText('Priorità Alta',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp
                    ),) ,
                ),
                Padding(
                  padding:  EdgeInsets.only(right: 8.w),
                  child: Icon(
                    Icons.circle,
                    color: Colors.redAccent,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
