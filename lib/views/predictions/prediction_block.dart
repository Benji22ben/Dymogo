import 'package:dymogo/viewmodel/map/location_service.dart';
import 'package:flutter/material.dart';

class PredictionBlock extends StatefulWidget {
  final percent;

  final String label;

  const PredictionBlock({
    Key? key,
    required this.percent,
    required this.label,
  }) : super(key: key);

  @override
  State<PredictionBlock> createState() => _PredictionBlockState();
}

class _PredictionBlockState extends State<PredictionBlock> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.label == "autre")
          Text(
            "We're sorry, we didn't recognize your image",
            textAlign: TextAlign.center,
          )
        else
          Text(capitalize(widget.label)),
        // widget.label != "autre"
        //     ? Text(widget.percent + '%')
        //     : Container(),
        FutureBuilder(
          future: LocationService.getAddress(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text(
                'There was an error :(',
              );
            } else if (snapshot.hasData) {
              return Text(snapshot.data.toString());
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
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
