import "package:flutter/material.dart";

class GradientAppBar extends StatelessWidget {

  final String title;
  final Color firstColor;
  final Color secondColor;
  final double barHeight = 60.0;

  GradientAppBar(this.title,this.firstColor,this.secondColor);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontFamily: 'SF Pro Display',fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold,letterSpacing: 2),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
        gradient: LinearGradient(
            colors: [firstColor, secondColor],

        ),
      ),
    );
  }
}