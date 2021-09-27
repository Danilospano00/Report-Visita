import 'package:flutter/material.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListaAziende extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListaAziendeState();
}

class ListaAziendeState extends State<ListaAziende> {
  List<String> listaAziende = [
    "Yiv3a",
    "Q8w5y",
    "UesNV",
    "zEj1",
    "brcIo",
    "AqgD",
    "SfPO0",
    "S6lHj",
    "DsbJr",
    "ag7n5",
    "pnf71",
    "ZcvS7",
    "xzYkl",
    "d6gDj",
    "ODq8U",
    "bZzxz",
    "m5JeQ",
    "NnfUD",
    "LBpsR",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlphabetListScrollView(
          indexedHeight: (int i) {
            return 80;
          },
          strList: listaAziende,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          listaAziende[index],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 12.075892.sp,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 2.w),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Text(
                        listaAziende[index],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20.126488.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.25,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          listaAziende[index],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12.075892.sp,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.4,
                            color: Colors.grey[700],
                          ),
                        ),
                        ElevatedButton(
                          child: Text(
                            "map",
                            style: TextStyle(
                                fontSize: 10.sp, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(18.w, 25.h),
                            primary: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  height: 1,
                  thickness: 2,
                ),
              ],
            );
          }),
    );
  }
}
