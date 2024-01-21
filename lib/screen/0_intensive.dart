import 'dart:math';

import 'package:flutter/material.dart';

enum Shape {
  Circle,
  Rectangle,
}

class HelloDraggable extends StatefulWidget {
  const HelloDraggable({super.key});

  @override
  State<HelloDraggable> createState() => _HelloDraggableState();
}

class _HelloDraggableState extends State<HelloDraggable> {
  int _left = 0;
  int _right = 0;
  int _point = 1;
  Shape _shape = Shape.Circle;
  double _borderWidth = 2.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assignRandomShape();
  }

  void assignRandomShape() {
    final random = Random();
    final shapeIndex = random.nextInt(Shape.values.length);
    setState(() {
      _shape = Shape.values[shapeIndex];
    });
  }

  void onMove(DragTargetDetails<int> details, Shape shape) {
    if (_shape == shape) {
      setState(() {
        _borderWidth = 4.0; // Increase the border width
      });
    }
  }

  void onLeave() {
    setState(() {
      _borderWidth = 2.0; // Reset the border width
    });
  }

  void onAccept(int data, Shape shape) {
    if (_shape == shape) {
      setState(() {
        if (shape == Shape.Circle) {
          _right += data;
        } else {
          _left += data;
        }
        onLeave();
        assignRandomShape();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello Draggable'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildDragbody(_shape),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildDragTarget(Shape.Rectangle),
                    const SizedBox(width: 20),
                    buildDragTarget(Shape.Circle),
                  ],
                ),
              ]),
        ),
      ),
    );
  }

  Widget buildDragbody(Shape shape) {
    return Draggable<int>(
      data: _point,
      feedback: Container(
        decoration: BoxDecoration(
          shape: _shape == Shape.Circle ? BoxShape.circle : BoxShape.rectangle,
          border: Border.all(
            color: Colors.black, // Border color
            width: 2, // Border width
          ),
        ),
        height: 50,
        width: 50,
        child: const Icon(Icons.move_up_sharp),
      ),
      childWhenDragging: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // Border color
            width: 2, // Border width
          ),
        ),
        height: 50,
        width: 50,
        child: const Center(
          child: Icon(
            Icons.question_mark,
            color: Colors.black,
            size: 20,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.pinkAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        width: 50,
        height: 50,
        child: const Stack(
          children: [
            Icon(
              Icons.question_mark,
              color: Colors.white,
              size: 50,
            ),
            Center(
              child: Text('Drag!',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDragTarget(Shape shape) {
    return DragTarget<int>(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return Container(
          decoration: BoxDecoration(
            shape: shape == Shape.Circle ? BoxShape.circle : BoxShape.rectangle,
            border: Border.all(
              color: Colors.black, // Border color
              width: _shape == shape ? _borderWidth : 2, // Border width
            ),
          ),
          height: 50.0,
          width: 50.0,
          child: Center(
            child: Text('${shape == Shape.Circle ? _right : _left}'),
          ),
        );
      },
      onMove: (details) => onMove(details, shape),
      onLeave: (data) => onLeave(),
      onAccept: (int data) => onAccept(data, shape),
    );
  }
}
