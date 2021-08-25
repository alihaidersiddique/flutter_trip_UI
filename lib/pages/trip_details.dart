import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_trip_ui/models/trips.dart';

class TripDetails extends StatefulWidget {
  Trips trip;
  TripDetails({
    Key? key,
    required this.trip,
  }) : super(key: key);

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
                        'https://firebasestorage.googleapis.com/v0/b/flutter-trip-ui-9047.appspot.com/o/islands%2F89oh4ssC0TmgKsR7T9NW-1.jpg?alt=media&token=0240d3ee-3218-4de0-b524-bab8d84feda8',
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 1.2 / 3,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: IconButton(
                          onPressed: () {},
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
                        'Island',
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
                      Text('Kanikhao, Ireland',
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
                          data: '4.8'),
                      TripDetailsBox(
                          icon: Icons.directions_transit_outlined,
                          name: 'Distance',
                          data: '3800 Km'),
                      TripDetailsBox(
                          icon: Icons.food_bank_outlined,
                          name: 'Food',
                          data: '108 Avail.')
                    ],
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    'The Gulf of Thailand, also known as the Gulf of Siam, is a shallow inlet in the southwestern South China Sea, bounded between the southwestern shores of the Indochinese Peninsula and the northern half of the Malay Peninsula.',
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
