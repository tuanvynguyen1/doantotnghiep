import 'package:flutter/material.dart';

import 'loading_dialog.dart';

class LoadingScreenWidget extends StatelessWidget {
  const LoadingScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Container(
        color: Colors.white,
        child: Center(
          child: LoadingDialogWidget(),
        ),
      ),
    );
  }
}
