import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/models/trips.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:favorite_button/favorite_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String collectionName = 'trips';
  getData() {
    return FirebaseFirestore.instance.collection(collectionName).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    padding: EdgeInsets.only(left: 0),
                    onPressed: () {},
                    icon: Icon(
                      Icons.sort,
                      size: 45,
                      color: Colors.grey,
                    )),
                Row(
                  children: [
                    Icon(
                      Icons.my_location,
                      size: 20,
                      color: Color(0xffF6775F),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Dhaka, Bangladesh',
                        style: GoogleFonts.actor(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[350]),
                      ),
                    )
                  ],
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 7,
                          offset: Offset(1, 8), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(100.0),
                      border: Border.all(color: Colors.white, width: 5.0)),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        AssetImage('assets/images/1495088041-avatar.jpg'),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Align(
              child: Text('Hi John,', style: GoogleFonts.atma(fontSize: 20.0)),
              alignment: Alignment.centerLeft,
            ),
            Align(
              child: Text(
                'Where do you \nwanna go?',
                textScaleFactor: 1.7,
                style: GoogleFonts.acme(
                    fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.centerLeft,
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.only(
                right: 50.0,
              ),
              height: 60.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(width: 3, color: Color(0xffF7F7F7))),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Center(
                  child: TextFormField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        icon: Icon(
                          Icons.search_outlined,
                          size: 30,
                          color: Colors.grey.shade300,
                        ),
                        hintText: 'Where do you want to go?',
                        hintStyle: TextStyle(color: Colors.grey.shade500)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Align(
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.centerLeft,
            ),
            // ListView.builder(
            //   scrollDirection: Axis.horizontal,
            //   itemBuilder: (context, index) {
            //     return Container(
            //       height: 50.0,
            //       decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(25.0),
            //           border: Border.all(width: 3, color: Color(0xffF7F7F7))),
            //     );
            //   },
            // ),
            // Container(
            //   height: 80.0,
            //   width: 150.0,
            //   decoration: BoxDecoration(
            //     color: Color(0xffFE5D3D),
            //     borderRadius: BorderRadius.all(Radius.circular(25)),
            //   ),
            //   child: Center(
            //       child: Row(
            //     children: [ImageIcon(NetworkImage('')), Text('Trips')],
            //   )),
            // ),
            SizedBox(
              height: 20.0,
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text('Error ${snapshot.error}');
                if (snapshot.hasData) {
                  print('Documents ${snapshot.data!.docs.length}');
                  return buildList(context, snapshot.data!.docs);
                }
                return Center(child: CircularProgressIndicator());
              },
            )
          ],
        ),
      )),
    );
  }

  Widget buildList(BuildContext context,
      List<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
    return Flexible(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: snapshot.map((data) => buildListItem(context, data)).toList(),
      ),
    );
  }

  Widget buildListItem(
      BuildContext context, DocumentSnapshot<Map<String, dynamic>> data) {
    final record = Trips.fromSnapshot(data);
    return Padding(
        key: ValueKey(record.name),
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: locationCard(record));
  }

  Widget locationCard(Trips trip) {
    return Container(
      padding:
          EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0, bottom: 18.0),
      width: 330,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Column(
        children: [
          Stack(children: [
            Center(
              child: Container(
                clipBehavior: Clip.antiAlias,
                height: 180.0,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Image.network(
                  trip.image.toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: FavoriteButton(
                valueChanged: () {},
              ),
            )
          ]),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                direction: Axis.vertical,
                children: [
                  Text(trip.name.toString(),
                      style: GoogleFonts.jetBrainsMono(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      )),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.location_solid,
                        color: Color(0xffFE5D3E),
                      ),
                      Text(trip.location.toString(),
                          style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            color: Colors.grey,
                          )),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    size: 30.0,
                    color: Color(0xffFE5D3E),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(trip.rating.toString(),
                        style: GoogleFonts.aBeeZee(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          color: Colors.grey,
                        )),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
