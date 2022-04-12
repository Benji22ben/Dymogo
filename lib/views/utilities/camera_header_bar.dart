import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CameraHeaderBar extends StatelessWidget {
  const CameraHeaderBar({Key? key, required this.top, required this.color})
      : super(key: key);
  final double top;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: top, left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => {
              Navigator.pop(context),
            },
            child: Icon(
              Icons.arrow_back,
              size: 40,
              color: color,
            ),
          ),
          SvgPicture.asset(
            "assets/images/camera_screen/burger.svg",
            color: color,
          ),
        ],
      ),
    );
  }
}
