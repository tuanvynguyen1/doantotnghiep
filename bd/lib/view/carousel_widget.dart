import 'package:bd/services/banner_services.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

import '../model/banner_obj.dart';

class CarouselWidget extends StatefulWidget {
  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late Future<List<BannerObj>> list;
  late List<NetworkImage> imageList = <NetworkImage>[];
  @override
  void initState() {
    list = BannerServices.getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: list,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

        if (snapshot.hasData) {
          for (int i = 0; i < snapshot.data.length; i++) {
            print(snapshot.data[i].image);
            imageList.add(NetworkImage('http://20.2.66.17:8000/storage' + snapshot.data[i].image));
          }
          return Container(
            height: 40,
              child: Carousel(
                  boxFit: BoxFit.cover,
                  images: imageList,
                  autoplay: false,
                  animationCurve: Curves.fastOutSlowIn,
                  animationDuration: Duration(microseconds: 1000),
                  dotSize: 3.0));
        } else {
          return  const SizedBox(
            height: 40,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
