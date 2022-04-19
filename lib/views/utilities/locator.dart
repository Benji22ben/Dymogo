import 'package:dymogo/viewmodel/camera/camera_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<CameraService>(CameraService());
}
