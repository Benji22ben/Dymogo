import 'package:camera/camera.dart';
import 'package:dymogo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final CameraController _cameraController =
      CameraController(cameras.first, ResolutionPreset.medium);
  @override
  BuildContext get context => super.context;

  @override
  void initState() {
    super.initState();

    _cameraController.initialize().then((_) {
      if (!mounted) return;

      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(children: [
        if (_cameraController.value.isInitialized)
          _buildCameraPreview(context, _cameraController),
      ]),
    );
  }
}

Widget _buildCameraUX(context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      SvgPicture.asset(
        "assets/images/camera_screen/galerie.svg",
        width: 60,
      ),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 8),
          borderRadius: BorderRadius.circular(60),
        ),
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 33,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 28,
          ),
        ),
      ),
      GestureDetector(
        onTap: (() => {}),
        child: SvgPicture.asset(
          "assets/images/camera_screen/flip.svg",
          width: 60,
        ),
      ),
    ]),
  );
}

Widget _buildCameraPreview(context, _cameraController) {
  final size = MediaQuery.of(context).size;
  final deviceRatio = size.width / size.height;

  return Container(
    color: Colors.black,
    height: MediaQuery.of(context).size.height,
    child: Stack(children: [
      Padding(
        padding: const EdgeInsets.only(top: 75),
        child: Transform.scale(
          scale: 1,
          alignment: Alignment.center,
          child: CameraPreview(
            _cameraController,
          ),
        ),
      ),
      Column(children: [
        Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.only(top: 75, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => {
                    Navigator.pop(context),
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 40,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                SvgPicture.asset(
                  "assets/images/camera_screen/burger.svg",
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        _buildCameraUX(context)
      ]),
    ]),
  );
}
