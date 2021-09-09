import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

class AccountEmpty extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountEmptyState();
}

class AccountEmptyState extends State<AccountEmpty> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => Scaffold(
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
        body: Card(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Stack(
                children: [
                  ShapeOfView(
                    elevation: 4,
                    height: 180,
                    shape: DiagonalShape(
                      position: DiagonalPosition.Bottom,
                      direction: DiagonalDirection.Left,
                      angle: DiagonalAngle.deg(angle: 10),
                    ),
                    child: ColoredBox(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.red[900],
                              radius: 50,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 45,
                                child: Icon(
                                  Icons.perm_identity_outlined,
                                  size: 48,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Ciao\nCrea un account",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.9.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text:
                        "Scopri tutti i vantaggi di un account registrato\n\n",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin molestie ullamcorper leo porta cursus. Curabitur convallis et dolor a faucibus. Maecenas suscipit, orci faucibus porttitor pretium, tellus libero eleifend massa, eget pharetra magna enim quis arcu. Sed tempus tincidunt viverra. Phasellus nisi ligula, malesuada ut ullamcorper eget, rutrum id tortor. Donec nisl mi, iaculis ut maximus vitae, feugiat vel nunc. Aliquam varius ullamcorper nunc, sit amet mattis leo vulputate a.",
                        style: TextStyle(fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      designSize: const Size(360, 760),
    );
  }
}
