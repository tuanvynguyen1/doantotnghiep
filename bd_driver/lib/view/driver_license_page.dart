
import 'package:bd_driver/model/driver_license.dart';
import 'package:bd_driver/services/driver_license_service.dart';
import 'package:bd_driver/view/add_driver_license_page.dart';

import 'package:flutter/material.dart';

class DriverLicensePage extends StatefulWidget {
  @override
  _DriverLicenseState createState() => _DriverLicenseState();
}

class _DriverLicenseState extends State<DriverLicensePage> {
  late Future<List<DriverLicense>> list;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = DriverLicenseService.getListLicense();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Bằng lái'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddDriverLicensePage()));
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 40,
                )
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: list,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
        {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return AddressView(
                      li: data[index],
                    );
                  }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

}
class AddressView extends StatelessWidget{
  final DriverLicense li;

  const AddressView({Key? key, required this.li}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: ListTile(
          title: Text('Bằng lái hạng: ${li.rank}'),
          subtitle: li.status == 0?Text("Chưa được duyệt", style: TextStyle(color: Colors.red),):
          Text("Đã duyệt", style: TextStyle(color: Colors.green),),
          trailing: ElevatedButton(
            onPressed: () {

            }, child: Icon(Icons.remove_red_eye),

          ),
        ),
      ),
    );
  }

}