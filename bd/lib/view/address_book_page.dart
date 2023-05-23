import 'package:bd/model/address_book.dart';
import 'package:bd/services/address_book_services.dart';
import 'package:bd/view/select_address_page.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class AddressBookPage extends StatefulWidget {
  @override
  _AddressBookState createState() => _AddressBookState();
}

class _AddressBookState extends State<AddressBookPage> {
  late Future<List<AddressBook>> list;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = AddressBookServices.getList();
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
          title: const Text('Sổ địa chỉ'),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: IconButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectAddressPage()));
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
                      address: data[index],
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
  final AddressBook address;

  const AddressView({Key? key, required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        elevation: 5,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: ListTile(
          title: Text(address.name),
          subtitle: Text(address.address),
          trailing: ElevatedButton(
            onPressed: () { 
              
            }, child: Icon(Icons.delete),

          ),
        ),
      ),
    );
  }

}