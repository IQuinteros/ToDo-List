import 'package:flutter/material.dart';

class TaskInList extends StatefulWidget {
  @override
  _TaskInListState createState() => _TaskInListState();
}

class _TaskInListState extends State<TaskInList> {
  @override
  Widget build(BuildContext context) {

    final colorBox = Container(
      height: 70,
      width: 10,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
    );

    final textZone = Container(
      margin: EdgeInsets.only(
        left: 20
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Nombre de Tarea",
              style: TextStyle(
                color: Color.fromRGBO(10, 36, 99, 1),
                fontFamily: "Lato",
                fontWeight: FontWeight.bold,
                fontSize: 17
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 5
              ),
              child: Text(
                "05/12/2020",
                style: TextStyle(
                    color: Color.fromRGBO(10, 36, 99, 1),
                    fontFamily: "Lato",
                    fontWeight: FontWeight.normal,
                    fontSize: 15
                ),
              ),
            ),
          ],
      ),
    );

    final allContent = Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(
        left: 5,
        right: 5
      ),
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: Row(
        children: [
          colorBox,
          textZone
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 2
          )
        ]
      ),
    );

    return InkWell(
      child: allContent,
      onTap: (){
        print('Pressed');
      },
    );
  }
}
