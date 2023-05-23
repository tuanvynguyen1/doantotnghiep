import 'dart:async';
import 'dart:developer';

import 'package:bd/services/address_book_services.dart';
import 'package:bd/services/authenticator_services.dart';
import 'package:bd/services/banner_services.dart';
import 'package:bd/services/booking_services.dart';
import 'package:bd/view/address_book_page.dart';
import 'package:bd/view/history_page.dart';
import 'package:bd/view/login_page.dart';
import 'package:bd/view/user_page.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:wakelock/wakelock.dart';

import '../model/address_book.dart';
import '../model/banner_obj.dart';

import '../model/user.dart';
import '../services/authenticator_services.dart';
import 'carousel_widget.dart';
import 'find_driver_dialog.dart';
import 'loading_dialog.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return MaterialApp(
        home: HomePage(user: user));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user});
  final User user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? bookingID = null;
  int? _price = null;
  int? _selected = null;
  late List<NetworkImage> imageList = <NetworkImage>[];
  late Future<List<BannerObj>> list;
  late List<AddressBook>? listAddress = null;
  AddressBook? currentAddressBook;
  final Completer<GoogleMapController> _controller = Completer();
  LocationData? currentLocation;
  late BitmapDescriptor icon = BitmapDescriptor.defaultMarker;
  Future<void> getPrice() async{
    await getCurrentLocation();
    _price = await BookingServices.getPrice(currentLocation!.latitude, currentLocation!.longitude, currentAddressBook!.lat, currentAddressBook!.long, _selected);
    setState(() {

    });
  }
  Future<void> getCurrentLocation() async{
    Location location = Location();
    currentLocation = await location.getLocation();

  }
  Future<void> setAddressBook() async{
    AddressBookServices.getList().then((value){
      listAddress = value;
      setState(() {

      });
    });
  }
  getIcons() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(5, 5)),
            "assets/icon/markeruser_icon.jpg")
        .then((icon) {
      setState(() {
        this.icon = icon;
      });
    });
  }
  void getBanner(){
    BannerServices.getList().then((value){
      for(final i in value){
        print(i.image);
        imageList.add(NetworkImage('http://20.2.66.17:8000/storage' + i.image));
      }
    });
    setState(() {

    });
  }
  @override
  void initState() {
    getBanner();
    getCurrentLocation();
    getIcons();
    setAddressBook();

    // timer = Timer.periodic(Duration(seconds: 15), (Timer t) => checkForNewSharedLists());
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('BD - Ứng dụng tìm tài xế'),
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('${widget.user.name}'),
            accountEmail: Text('${widget.user.email}'),
            currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white))),
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserPage(user: widget.user)));
              },
              child: ListTile(
                  title: Text('Tài khoản'), leading: Icon(Icons.person))),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddressBookPage()));
              },
              child: ListTile(
                title: Text('Sổ địa chỉ'),
                leading: Icon(Icons.book),
              )),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HistoryPage()));
              },
              child: ListTile(
                title: Text('Lịch sử'),
                leading: Icon(Icons.book_online, color: Colors.green),
              )),
          Divider(),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('About'),
              leading: Icon(Icons.help, color: Colors.blue),
            ),
          ),
          InkWell(
              onTap: () async {
                // await AuthenticatorServices.logOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: ListTile(
                title: Text('Đăng xuất'),
                leading: Icon(Icons.logout),
              ))
        ],
      )),
      body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(30),
                child: Container(
                  height: 30,
                  child: Carousel(
                      boxFit: BoxFit.cover,
                      images: imageList,
                      autoplay: false,
                      animationCurve: Curves.fastOutSlowIn,
                      animationDuration: Duration(microseconds: 1000),
                      dotSize: 3.0),
                )),
            Padding(
                padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _icon(0, text: 'Xe Máy', icon: AssetImage('assets/icon/motorcycle.png')),
                  _icon(1, text: 'Ô tô', icon: AssetImage('assets/icon/car.png'))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: listAddress!=null ? DropdownButtonFormField(
                items: listAddress!.map((AddressBook val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(
                      val.name,
                    ),
                  );
                }).toList(),
                onChanged: (AddressBook? value) {
                  currentAddressBook = value;
                  if(_selected != null ){
                    getPrice();
                  }
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  label: const Text(
                    "Chọn điểm đến",
                    style:
                    TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  prefixIcon: const Icon(
                    Icons.house,
                    color: Colors.grey,
                  ),
                ),
              ):
              const CircularProgressIndicator()
            ),
            _price==null ?Container():Padding(
                padding: EdgeInsets.all(10),
              child: Container(
                child: Text('Giá: $_price VND'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                width: double.infinity, //  match_parent
                height: 100, // match_parent
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        (_selected == null || currentAddressBook == null) ?MaterialStatePropertyAll<Color>(Colors.grey) : MaterialStatePropertyAll<Color>(Colors.blueAccent),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                                side: BorderSide(color: Colors.blueAccent)))),
                    onPressed: ()  async {


                      if(_selected != null && currentAddressBook != null){

                        showDialog(
                            context: context,
                            builder: (c){
                              return FindDriverDialog(type: _selected!, currentAddressBook: currentAddressBook!,);
                            }
                        );

                      }
                    },
                    child: Text(
                      'Gọi Tài xế Ngay',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    )),
              ),
            ),
          ],
      ),
    );
  }
  Widget _icon(int index, {required String text, required AssetImage icon}){
    return Padding(
      padding: EdgeInsets.all(16),
      child: InkResponse(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageIcon(icon,
              color: _selected == index ? Colors.red :  Color(0xFF3A5A98),
              size: 100,
            ),
            Text(text, style: TextStyle(color: _selected == index ? Colors.red : null, fontSize: 26))
          ],
        ),
      onTap: ()=> setState(() {
        _selected = index;
        if(currentAddressBook != null ){
          getPrice();
        }
      }),
      ),

    );
  }

}
