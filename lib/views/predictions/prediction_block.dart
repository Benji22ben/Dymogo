import 'package:flutter/cupertino.dart';

class PredictionBlock extends StatelessWidget {
  final percent;

  final String label;

  const PredictionBlock({
    Key? key,
    required this.percent,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (label == "autre")
          Text(
            "We're very sorry, we don't know what you're showing us",
            textAlign: TextAlign.center,
          )
        else
          Text(capitalize(label)),
        label != "autre" ? Text(percent + '%') : Container()
      ],
    );
  }
}

String capitalize(String string) {
  if (string.isEmpty) {
    return string;
  }

  return string[0].toUpperCase() + string.substring(1);
}
