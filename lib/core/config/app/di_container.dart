

import 'package:get_it/get_it.dart';
import 'package:heunets_assessment_app/features/home/presentation/controller/home_controller.dart';

final diContainer = GetIt.instance;

Future<void> init() async {
  diContainer.registerFactory(
          () => HomeController());

}
