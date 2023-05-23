import 'package:flutter/material.dart';

class LoadingDialogWidget extends StatelessWidget
{


  @override
  Widget build(BuildContext context){
    return AlertDialog(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 14),
            child: Image.asset('assets/gif/loading.gif' ),
          )
        ],
      ),
    );
  }
}