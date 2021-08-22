import 'package:cloud_firestore/cloud_firestore.dart';

class Trips {
  String? name, location, rating, distance, restaurants, description, image;
  DocumentReference? reference;

  Trips({
    required this.name,
    required this.location,
    required this.rating,
    required this.distance,
    required this.restaurants,
    required this.description,
    required this.image,
    required this.reference,
  });

  Trips.fromCloud(Map<String, dynamic> key, {this.reference}) {
    name = key['name'];
    location = key['location'];
    rating = key['rating'];
    distance = key['distance'];
    restaurants = key['restaurants'];
    description = key['description'];
    image = key['image'];
    reference = key['reference'];
  } // will set the data in Trips variables from Cloud Firestore

  Trips.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromCloud(snapshot.data()!, reference: snapshot.reference);

  // retrieve the data and its reference from Cloud

}
