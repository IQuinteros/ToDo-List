import 'package:flutter/material.dart';

class TaskColorPicker extends StatefulWidget {
  String value = "blue";

  @override
  _TaskColorPickerState createState() => _TaskColorPickerState();
}

class _TaskColorPickerState extends State<TaskColorPicker> {

  @override
  Widget build(BuildContext context) {
    final titleText = Container(
      margin: EdgeInsets.only(
        top: 10
      ),
      child: Text(
        "Color",
        style: TextStyle(
          color: Color.fromRGBO(10, 36, 99, 1),
          fontFamily: "Lato",
          fontSize: 15,
          fontWeight: FontWeight.bold
        ),
      ),
    );

    final colors = Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
        left: 10,
        right: 10
      ),
      height: 260,
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: [
          ColorBox(
            color: Colors.red,
            value: "red",
            selectedValue: widget.value,
            onTap: (){
              setState(() {
                widget.value = "red";
              });
            },
          ),
          ColorBox(
            color: Colors.yellow,
            value: "yellow",
            selectedValue: widget.value,
            onTap: (){
              setState(() {
                widget.value = "yellow";
              });
            },
          ),
          ColorBox(
            color: Colors.blue,
            value: "blue",
            selectedValue: widget.value,
            onTap: (){
              setState(() {
                widget.value = "blue";
              });
            },
          ),
          ColorBox(
            color: Colors.green,
            value: "green",
            selectedValue: widget.value,
            onTap: (){
              setState(() {
                widget.value = "green";
              });
            },
          ),
          ColorBox(
            color: Colors.purple,
            value: "purple",
            selectedValue: widget.value,
            onTap: (){
              setState(() {
                widget.value = "purple";
              });
            },
          ),
          ColorBox(
            color: Colors.orange,
            value: "orange",
            selectedValue: widget.value,
            onTap: (){
              setState(() {
                widget.value = "orange";
              });
            },
          )
        ],
      ),
    );

    return Container(
      margin: EdgeInsets.only(
        top: 10
      ),
      child: Column(
        children: [
          titleText,
          colors
        ],
      ),
    );
  }
}

class ColorBox extends StatefulWidget {

  final Color color;
  final String value;
  final String selectedValue;

  VoidCallback onTap;

  ColorBox({
    @required this.color,
    @required this.value,
    @required this.selectedValue,
    this.onTap
  });

  @override
  _ColorBoxState createState() => _ColorBoxState();
}

class _ColorBoxState extends State<ColorBox> {
  @override
  Widget build(BuildContext context) {

    Widget selected = Container();

    if(widget.value == widget.selectedValue){
      selected = Container(
        margin: EdgeInsets.all(5),
        alignment: Alignment.bottomRight,
        child: Icon(
          Icons.check_circle,
          color: Color.fromRGBO(10, 36, 99, 1),
          size: 25,
        ),
      );
    }

    final intContent = Stack(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                    offset: Offset(0,1)
                )
              ]
          ),
        ),
        selected
      ],
    );

    final allContent = Center(
      child: intContent
    );

    final button = InkWell(
      child: allContent,
      onTap: widget.onTap,
    );

    return button;
  }
}

