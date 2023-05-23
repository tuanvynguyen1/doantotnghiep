import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:bd_driver/model/book_pending.dart';
import 'package:bd_driver/services/authenticator_services.dart';
import 'package:bd_driver/services/booking_services.dart';
import 'package:bd_driver/services/trip_service.dart';
import 'package:bd_driver/view/found_booking_dialog.dart';
import 'package:bd_driver/view/login_page.dart';
import 'package:bd_driver/view/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:wakelock/wakelock.dart';
import 'dart:ui' as ui;
import '../model/user.dart';
import 'book_history.dart';
import 'driver_license_page.dart';
import 'loading_dialog.dart';
import 'on_going_page.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return MaterialApp(home: HomePage(user: user));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user});
  final User user;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  final GeolocatorPlatform geolocatorAndroid = GeolocatorPlatform.instance;
  Position?  currentLocation;
  StreamSubscription<Position>? _positionStream;
  Timer? _timer, _checkBooking, _sendLocation;
  bool? _isRejoin = false;
  BookPending? _bpending = null;
  late BitmapDescriptor icon = BitmapDescriptor.defaultMarker;
  void getCurrentLocation() {
     final LocationSettings locationSettings = LocationSettings(
       accuracy: LocationAccuracy.high,
       distanceFilter: 1,
     );
     _positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position? position) {

       setState(() {
         currentLocation = position;
       });
     });
  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(String path, int width) async {
    final Uint8List imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData);
  }
  getIcons() {
     getBitmapDescriptorFromAssetBytes("assets/images/marker.png", 150).then((icon) {
       setState(() {
         this.icon = icon;
       });
     });
  }
  Future<void> updateLocation()async {
    if(currentLocation != null ){
      AuthenticatorServices.updateLocation(currentLocation!.latitude, currentLocation!.longitude);

    }
  }

  Future<void> checkRequest() async{
      BookPending? b  = await BookingServices.checkRequest();
      if(b!= null){

        if(b.isRejoin == false){
          showDialog(
              context: context,
              builder: (c){
                return FoundBookingDialog(b: b,);
              }
          );
        }
        else{
          _bpending = b;
          _isRejoin = true;
        }
        setState(() {

        });
      }

  }
  @override
  void initState() {
    getCurrentLocation();
    getIcons();
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer t) => updateLocation());
    _checkBooking = Timer.periodic(const Duration(seconds: 10), (Timer t) => checkRequest());
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    _timer!.cancel();
    _checkBooking!.cancel();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Ứng dụng tài xế'),
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('${widget.user.name}'),
            accountEmail: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${widget.user.email}'),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Bằng lái: "),
                    Icon(Icons.pedal_bike, color: widget.user.isBike == true? Colors.green: Colors.red),
                    Icon(Icons.car_crash_rounded, color: widget.user.isCar == true? Colors.green: Colors.red),
                  ],
                )
              ],
            ),
            currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white))),
          ),
          InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home),
              )),
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
                Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => DriverLicensePage()));
              },
              child: ListTile(
                title: Text('Bằng lái'),
                leading: Icon(Icons.add_card_outlined),
              )),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BookHistory()));
              },
              child: ListTile(
                title: Text('Lịch sử'),
                leading: Icon(Icons.book),
              )),
          Divider(),
          InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Setting'),
                leading: Icon(Icons.settings, color: Colors.blueGrey),
              )),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('About'),
              leading: Icon(Icons.help, color: Colors.blue),
            ),
          ),
          InkWell(
              onTap: () async {
                await AuthenticatorServices.logOut();
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: ListTile(
                title: Text('Đăng xuất'),
                leading: Icon(Icons.logout),
              ))
        ],
      )),
      body: currentLocation == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                  zoom: 14.5),
              zoomControlsEnabled: false,
              myLocationButtonEnabled: true,
              markers: {
                Marker(
                  markerId: const MarkerId("curPosition"),
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                  icon: icon,
                ),
              },
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
            ),
      floatingActionButton: _isRejoin == true?
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                MaterialStatePropertyAll<Color>(Colors.green),
                shape:
                MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        side: BorderSide(color: Colors.green)))),
            onPressed: ()   {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OnGoingWidget(booking: _bpending)));
            },
            child: Text(
              'Tiếp tục hành trình',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            )):
          null
    );
  }
}
