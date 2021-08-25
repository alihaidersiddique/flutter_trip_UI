import 'package:cloud_firestore/cloud_firestore.dart';

class Trips {
  String? name, location, rating, distance, restaurants, description, image;
  DocumentReference? reference;

  Trips({
    this.name,
    this.location,
    this.rating,
    this.distance,
    this.restaurants,
    this.description,
    this.image,
    this.reference,
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

class Categories {
  String? name, icon;
  DocumentReference? reference;

  Categories({
    required this.icon,
    required this.reference,
  });

  Categories.fromCloud(Map<String, dynamic> key, {this.reference}) {
    name = key['name'];
    icon = key['icon'];
  }

  Categories.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromCloud(snapshot.data()!, reference: snapshot.reference);
}
