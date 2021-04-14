import 'package:flutter/material.dart';

class NoTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final toReturn = Center(
      child: Container(
        height: 200,
        child: Column(
          children: [
            Text(
              "¡No hay tareas!",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: "Lato",
                color: Color.fromRGBO(10, 36, 99, 1)
              ),
            ),
            Text(
              "Añade una Ahora",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lato",
                  color: Color.fromRGBO(10, 36, 99, 1)
              ),
            )
          ],
        ),
      )
    );

    return toReturn;
  }
}
