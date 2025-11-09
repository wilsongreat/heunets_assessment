import 'package:flutter/material.dart';
import 'package:heunets_assessment_app/features/home/presentation/controller/home_controller.dart';

import 'di_container.dart';
import 'package:provider/provider.dart';

class AppProvidersWrapper extends StatelessWidget {
  const AppProvidersWrapper({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => diContainer<HomeController>()),
      ],
      child: child,
    );
  }
}