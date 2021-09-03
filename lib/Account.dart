import 'package:flutter/material.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

class Account extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountState();
}

class AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        title: Text("Account",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 28, color: Colors.grey[700])),
      ),
      body: Card(
        margin: EdgeInsets.all(10),
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Transform.rotate(
                            angle: 10.5,
                            origin: Offset.fromDirection(1000),
                            alignment: AlignmentDirectional.bottomEnd,
                            child: FloatingActionButton(
                              onPressed: () {},
                              backgroundColor: Colors.grey[700],
                              child: Icon(Icons.add),
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
              padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 10.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Hai 3 meeting oggi",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                        Text(
                          "Controlla il planner",
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.navigate_next_rounded,
                    size: 24,
                    color: Colors.grey[700],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.open_in_new_outlined,
                        size: 80,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Allerte attive",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text("Dall'ultimo sync\ndel 03/09 alle 15:30",
                                overflow: TextOverflow.visible,
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 40.0, right: 10, left: 10, bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 5,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Nome azienda o contatto",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Padding(padding: const EdgeInsets.symmetric(vertical: 2)),
                          Text(
                            "è passato olte un mese dall'ultimo incontro...",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Column(
                      children: [
                        Icon(
                          Icons.navigate_next_rounded,
                          size: 24,
                          color: Colors.grey[700],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: ElevatedButton(
                    child: Text(
                      "vedi tutti",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 110.5, vertical: 10),
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.tune_outlined,
                    ),
                    label: Text(
                      "Setting",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
