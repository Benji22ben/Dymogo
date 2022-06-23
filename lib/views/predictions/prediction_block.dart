import 'package:dymogo/constants.dart';
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
            "Nous n'arrivons pas à joindre votre signalement à une catégorie",
            textAlign: TextAlign.center,
          )
        else
          Text(capitalize(widget.label)),
        // widget.label != "autre"
        //     ? Text(widget.percent + '%')
        //     : Container(),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: FutureBuilder(
            future: LocationService.getAddress(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text(
                  'There was an error :(',
                );
              } else if (snapshot.hasData) {
                return Text(snapshot.data.toString());
              } else {
                return const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                  ),
                );
              }
            },
          ),
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
