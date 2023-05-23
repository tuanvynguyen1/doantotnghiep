

import 'dart:async';
import 'dart:math';
import 'package:bd_driver/view/pickup_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:bd_driver/model/book_pending.dart';
import 'package:bd_driver/services/trip_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wakelock/wakelock.dart';
class OnGoingWidget extends StatelessWidget {
  BookPending? booking;
  OnGoingWidget({super.key, required this.booking});


  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return MaterialApp(home: OnGoingPage(booking: booking));
  }
}
class OnGoingPage extends StatefulWidget{
  BookPending? booking;

  OnGoingPage({super.key, this.booking});
  @override
  _OnGoingState createState() =>_OnGoingState();

}

class _OnGoingState extends State<OnGoingPage>{
  final Completer<GoogleMapController> _controller = Completer();
  Position? _currentLocation;
  StreamSubscription<Position>? _positionStream;
  Timer? _timer;
  int? _curStage,_isWaiting= 0;

  late BitmapDescriptor icon = BitmapDescriptor.defaultMarker;


  double currentDistance(lat, long){
    double distance = 0;
    distance = Geolocator.distanceBetween(_currentLocation!.latitude!, _currentLocation!.longitude!, lat , long);

    return distance;
  }
  void sendNotify(){
    double lat;
    double lng;

    if(_curStage ==0){
      lat = double.parse(widget.booking!.lat1);
      lng = double.parse(widget.booking!.lng1);
    }
    else{
      lat = double.parse(widget.booking!.lat2);
      lng = double.parse(widget.booking!.lng2);
    }
    double distance = currentDistance(lat,lng);
    if(distance <= 300){
        if(_curStage == 0 && _isWaiting == 0){
          _isWaiting = 1;
          showDialog(
              context: context,
              builder: (c){
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
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
                            TripService.setStatus(widget.booking!.bookID, 1);
                            _isWaiting = 0;
                            _curStage=1;
                            Navigator.of(context, rootNavigator: true).pop('dialog');
                          },
                          child: Text(
                            'Nhận khách',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 40),
                          )),
                    ],
                  ),
                );
              }
          );
        }
        else if(_curStage == 1 && _isWaiting == 0){
          _isWaiting = 1;
          showDialog(
              context: context,
              builder: (c){
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
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
                            TripService.finishTrip(widget.booking!.bookID);
                            print('heets');
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Hoàn thành',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 40),
                          )),
                    ],
                  ),
                );
              }
          );
        }
    }
  }
  void SendLocation(){
    if(_currentLocation != null)
    TripService.sendTripData(widget.booking!.bookID, _currentLocation!.latitude, _currentLocation!.longitude);
  }
  void getCurrentLocation() {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5,
    );
    _positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position? position) {
      _currentLocation = position;
      SendLocation();
      sendNotify();
      setState(() {

      });
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    _curStage = widget.booking!.status;


    // TODO: implement initState
    super.initState();

  }
  @override
  void dispose() {

    _timer!.cancel();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          title: Text(_curStage == 0? 'Di chuyển đón khách': 'Hoành thành chuyến đi'),
        ),
      body: _currentLocation == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(
                _currentLocation!.latitude!, _currentLocation!.longitude!),
            zoom: 14.5),
        zoomControlsEnabled: false,
        myLocationButtonEnabled: true,
        markers: {
          Marker(
            markerId: const MarkerId("curPosition"),
            position: LatLng(
                _currentLocation!.latitude!, _currentLocation!.longitude!),
            icon: icon,
          ),
          Marker(
            markerId: const MarkerId("Customer"),
            position: LatLng(
              double.parse(widget.booking!.lat1),double.parse(widget.booking!.lng1)
            )
          ),
          Marker(
              markerId: const MarkerId("Customer"),
              position: LatLng(
                  double.parse(widget.booking!.lat2),double.parse(widget.booking!.lng2)
              )
          )
        },
        onMapCreated: (mapController) {
          _controller.complete(mapController);
        },
      ),
    );
  }

}