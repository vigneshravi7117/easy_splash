import 'dart:async';

import 'package:flutter/material.dart';

enum ImgType { assetImage, networkImage }

class EasySplash extends StatefulWidget {
  final int seconds;
  final Widget nextScreen;
  final ImgType imgType;
  final String image;
  final EdgeInsetsGeometry padding;
  final bool hasIndicator;
  final AlignmentGeometry indicatorAlignment;
  final Color indicatorColor;
  final double indicatorHeight;

  const EasySplash(
      {Key? key,
      required this.seconds,
      required this.nextScreen,
      required this.imgType,
      required this.image,
      this.padding = const EdgeInsets.all(20),
      required this.hasIndicator,
      this.indicatorAlignment = Alignment.bottomCenter,
      this.indicatorColor = Colors.blueAccent,
      this.indicatorHeight = 30})
      : super(key: key);

  @override
  State<EasySplash> createState() => _EasySplashState();
}

class _EasySplashState extends State<EasySplash> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: widget.seconds),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => widget.nextScreen)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              padding: widget.padding,
              child: Align(
                alignment: Alignment.center,
                child: (widget.imgType == ImgType.assetImage)
                    ? Image(image: AssetImage(widget.image))
                    : Image(image: NetworkImage(widget.image)),
              ),
            ),
            if (widget.hasIndicator) ...[
              Align(
                alignment: widget.indicatorAlignment,
                child: LinearProgressIndicator(
                  color: widget.indicatorColor,
                  minHeight: widget.indicatorHeight,
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
