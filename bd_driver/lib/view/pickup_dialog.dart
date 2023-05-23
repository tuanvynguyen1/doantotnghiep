import 'package:flutter/material.dart';

class PickupDialog extends StatelessWidget
{
  const PickupDialog({super.key});



  @override
  Widget build(BuildContext context){
    return AlertDialog(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStatePropertyAll<Color>(Colors.cyan),
                  shape:
                  MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                          side: BorderSide(color: Colors.cyan)))),
              onPressed: ()  async {
              },
              child: Text(
                'Nhận khách',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              )),
        ],
      ),
    );
  }
}