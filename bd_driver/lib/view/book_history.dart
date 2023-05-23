
import 'package:bd_driver/model/booking.dart';
import 'package:bd_driver/services/booking_services.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class BookHistory extends StatefulWidget {
  @override
  _BookHistoryState createState() => _BookHistoryState();
}

class _BookHistoryState extends State<BookHistory> {

  late Future<List<Booking>> list;

  @override
  void initState() {
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
        title: const Text('Lịch sử'),
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
        }
      ),
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
          trailing: SmoothStarRating(
            rating: book.rate == null ? 0 : book.rate,
            isReadOnly: true,
            size: 80,
            filledIconData: Icons.star,
            halfFilledIconData: Icons.star_half,
            defaultIconData: Icons.star_border,
            starCount: 5,
            allowHalfRating: true,
            spacing: 2.0,

          ),
        ),
      ),
    );
  }
}