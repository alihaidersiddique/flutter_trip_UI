import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_trip_ui/models/trips.dart';

class TripDetails extends StatefulWidget {
  const TripDetails({Key? key, required this.record}) : super(key: key);
  final Trips record;

  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F6F6),
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0))),
                child: Stack(
                  children: [
                    Positioned(
                      child: Image.network(
                        '${widget.record.image}',
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 1.2 / 3,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          )),
                    )
                  ],
                )),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 35.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.record.name}',
                        style: GoogleFonts.abel(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 28.0),
                      ),
                      FavoriteButton(valueChanged: () {})
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.location_solid,
                        color: Color(0xffFE5D3E),
                      ),
                      Text('${widget.record.location}',
                          style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            color: Colors.grey,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TripDetailsBox(
                          icon: Icons.star_border_outlined,
                          name: 'Ratings',
                          data: '${widget.record.rating}'),
                      TripDetailsBox(
                          icon: Icons.directions_transit_outlined,
                          name: 'Distance',
                          data: '${widget.record.distance}'),
                      TripDetailsBox(
                          icon: Icons.food_bank_outlined,
                          name: 'Food',
                          data: '${widget.record.restaurants}')
                    ],
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    '${widget.record.description}',
                    style: GoogleFonts.adventPro(fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  // Book A Trip Button
                  SizedBox(
                    width: double.infinity,
                    height: 60.0,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff2F313A), side: BorderSide()),
                        onPressed: () {},
                        child: Text(
                          'Book A Trip',
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

class TripDetailsBox extends StatelessWidget {
  final IconData icon;
  final String name, data;
  const TripDetailsBox({
    Key? key,
    required this.name,
    required this.data,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 7,
                  offset: Offset(2, 6), // changes position of shadow
                ),
              ],
            ),
            child: Icon(icon)),
        SizedBox(
          height: 10.0,
        ),
        Text('$name',
            style: GoogleFonts.aBeeZee(
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              color: Colors.grey,
            )),
        Text('$data',
            style: GoogleFonts.aBeeZee(
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
            )),
      ],
    );
  }
}
