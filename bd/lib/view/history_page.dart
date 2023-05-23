import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../model/booking.dart';
import '../services/booking_services.dart';
import '../services/review_services.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<HistoryPage> {
  late Future<List<Booking>> list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = BookingServices.getList();
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
        title: const Text('Lịch sử đặt xe'),
      ),
      body: FutureBuilder(
          future: list,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return Padding(
                padding: EdgeInsets.all(10.0),
                child: ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return BookingView(
                        book: data[index],
                      );
                    }),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class BookingView extends StatelessWidget {
  final Booking book;

  const BookingView({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: ListTile(
          title: Text(book.addressdes),
          subtitle: Text('$book.starttime - $book.endtime'),
          trailing: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    book.rate == null ? Colors.blue : Colors.grey)),
            onPressed: () {
              book.rate == null
                  ? showDialog(
                      context: context,
                      builder: (c) {
                        return RatingView(
                          book: book,
                        );
                      })
                  : null;

            },
            child: Icon(Icons.star),
          ),
        ),
      ),
    );
  }
}

class RatingView extends StatelessWidget {
  final Booking book;
  var star = 0.0;
  var reviewController = TextEditingController();
  RatingView({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      // backgroundColor: Colors.transparent,
      // shadowColor: Colors.transparent,
      // key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              child: SmoothStarRating(
            color: Colors.yellow,
            borderColor: Colors.yellow,
            rating: 0,
            isReadOnly: false,
            size: 35,
            filledIconData: Icons.star,
            halfFilledIconData: Icons.star_half,
            defaultIconData: Icons.star_border,
            starCount: 5,
            allowHalfRating: true,
            spacing: 2.0,
            onRated: (value) {
              // print("rating value dd -> ${value.truncate()}");
              star = value;
            },
          )),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: TextField(
              controller: reviewController,
              maxLines: 4, //or null
              decoration:
                  InputDecoration.collapsed(hintText: "Nhập nhận xét của bạn"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        book.rate == null ? Colors.blue : Colors.grey)),
                onPressed: () {
                  ReviewServices.addReview(book.id, star, reviewController.text);
                },
                child: Text('Nhận xét'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
