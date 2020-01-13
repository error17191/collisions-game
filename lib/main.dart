import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

double largeSquareDim,
    smallSquareDim,
    largeSquareTop,
    largeSquareLeft,
    smallSquareTop,
    smallSquareLeft,
    totalHeight,
    totalWidth,
    limitTop,
    limitBottom,
    limitLeft,
    limitRight;
Square square;
_SquareState squareState;
Random generator;

void main() {
  generator = new Random();

  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    totalHeight = MediaQuery.of(context).size.height;
    totalWidth = MediaQuery.of(context).size.width;
    largeSquareDim = totalWidth * 0.8;
    smallSquareDim = largeSquareDim / 6;
    largeSquareTop = (totalHeight - largeSquareDim) / 2;
    smallSquareTop = (totalHeight - smallSquareDim) / 2;
    largeSquareLeft = (totalWidth - largeSquareDim) / 2;
    smallSquareLeft = (totalWidth - smallSquareDim) / 2;
    limitTop = largeSquareTop;
    limitBottom = largeSquareTop + largeSquareDim;
    limitLeft = largeSquareLeft;
    limitRight = largeSquareLeft + largeSquareDim;

    square =
        Square(smallSquareTop, smallSquareLeft, smallSquareDim, smallSquareDim);

    return Stack(
      children: [
        Positioned(
          top: largeSquareTop,
          left: largeSquareLeft,
          height: largeSquareDim,
          width: largeSquareDim,
          child: Container(
            color: Colors.yellow,
          ),
        ),
        square
      ],
    );
  }
}

class Square extends StatefulWidget {
  double top, left, height, width;

  Square(this.top, this.left, this.height, this.width);

  @override
  _SquareState createState() =>
      _SquareState(this.top, this.left, this.height, this.width);
}

class _SquareState extends State<Square> {
  double top, left, height, width;
  int directionV = -1;
  int directionH = -1;
  int offsetH, offsetV, max = 5;

  _SquareState(top, left, height, width) {
    this.top = top;
    this.left = left;
    this.height = height;
    this.width = width;
    this.offsetH = this.directionH * generator.nextInt(max);
    this.offsetV = this.directionV * generator.nextInt(max);
    Timer.periodic(Duration(milliseconds: 5), (timer) {
      setState(() {
        if (this.left >= limitRight - width) {
          this.directionH = -1;
          this.offsetH = this.directionH * generator.nextInt(max);
          this.offsetV = this.directionV * generator.nextInt(max);
        }
        if (this.left <= limitLeft) {
          this.directionH = 1;
          this.offsetH = this.directionH * generator.nextInt(max);
          this.offsetV = this.directionV * generator.nextInt(max);
        }
        if (this.top >= limitBottom - height) {
          this.directionV = -1;
          this.offsetH = this.directionH * generator.nextInt(max);
          this.offsetV = this.directionV * generator.nextInt(max);
        }
        if (this.top <= limitTop) {
          this.directionV = 1;
          this.offsetH = this.directionH * generator.nextInt(max);
          this.offsetV = this.directionV * generator.nextInt(max);
        }
        this.left = this.left + this.offsetH;
        this.top = this.top + this.offsetV;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      height: height,
      width: width,
      child: Container(
        color: Colors.red,
      ),
    );
  }
}
