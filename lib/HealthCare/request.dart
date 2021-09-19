import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';
import './requests/google_map_requests.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../twilio.dart';

class Request extends StatefulWidget {
  @override
  State<Request> createState() => RequestState();
}

class RequestState extends State<Request> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  static LatLng _initialPosition;
  LatLng _lastPosition = _initialPosition;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController purposeController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _markers.add(Marker(
        markerId: MarkerId("1"),
        position: LatLng(37.43296265331129, -122.08832357078792)));

    _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return _initialPosition == null
        ? Container(
            alignment: Alignment.center,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            body: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 14.4746,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: Set.from(_markers),
                  myLocationButtonEnabled: true,
                  onCameraMove: onCameraMove,
                  polylines: _polyLines,
                ),
                Positioned(
                  top: 50.0,
                  right: 15.0,
                  left: 15.0,
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1.0, 5.0),
                            blurRadius: 10,
                            spreadRadius: 3)
                      ],
                    ),
                    child: TextField(
                      controller: locationController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        icon: Container(
                          margin: EdgeInsets.only(left: 20, top: 5),
                          width: 10,
                          height: 10,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.black,
                          ),
                        ),
                        hintText: "Starting Point",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 105.0,
                  right: 15.0,
                  left: 15.0,
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1.0, 5.0),
                            blurRadius: 10,
                            spreadRadius: 3)
                      ],
                    ),
                    child: TextField(
                      cursorColor: Colors.black,
                      controller: destinationController,
                      onSubmitted: (value) {
                        sendRequest(value);
                      },
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                        icon: Container(
                          margin: EdgeInsets.only(left: 20, top: 5),
                          width: 10,
                          height: 10,
                          child: Icon(
                            Icons.local_taxi,
                            color: Colors.black,
                          ),
                        ),
                        hintText: "Destination",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 160.0,
                  right: 15.0,
                  left: 15.0,
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1.0, 5.0),
                            blurRadius: 10,
                            spreadRadius: 3)
                      ],
                    ),
                    child: TextField(
                      controller: purposeController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        icon: Container(
                          margin: EdgeInsets.only(left: 20, top: 5),
                          width: 10,
                          height: 10,
                          child: Icon(
                            Icons.mail,
                            color: Colors.black,
                          ),
                        ),
                        hintText: "Purpose",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 50.0,
                  right: 15.0,
                  left: 15.0,
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      color: Colors.white,
                    ),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(
                              color: Color.fromRGBO(223, 74, 74, 1))),
                      height: 60,
                      color: Color.fromRGBO(223, 74, 74, 1),
                      onPressed: () async {
                        List<Placemark> toPlaceMark = await Geolocator()
                            .placemarkFromAddress(locationController.text);
                        final String to = toPlaceMark[0].locality;
                        List<Placemark> fromPlaceMark = await Geolocator()
                            .placemarkFromAddress(destinationController.text);
                        final String from = fromPlaceMark[0].locality;

                        CollectionReference notifs = FirebaseFirestore.instance
                            .collection('notifications');

                        final data = {
                          "to": to,
                          "from": from,
                          "purpose": purposeController.text
                        };

                        final result = await notifs.add(data);

                        //send sms
                        CollectionReference police =
                            FirebaseFirestore.instance.collection('police');

                        police
                            .where('location', isEqualTo: from)
                            .get()
                            .then((QuerySnapshot querySnapshot) {
                          querySnapshot.docs.forEach((doc) {
                            var phone = doc['phone'].toString();
                            twilioFlutter.sendSMS(
                                toNumber: phone,
                                messageBody:
                                    'EMERGENCY!! \n$from to $to traffic needs to be made into a green corridor ASAP!! \nPurpose - ${purposeController.text}. \nPlease do the needful');
                          });
                        });

                        police
                            .where('location', isEqualTo: to)
                            .get()
                            .then((QuerySnapshot querySnapshot) {
                          querySnapshot.docs.forEach((doc) {
                            var phone = doc['phone'].toString();
                            twilioFlutter.sendSMS(
                                toNumber: phone,
                                messageBody:
                                    'EMERGENCY!! \n$from to $to traffic needs to be made into a green corridor ASAP!! \nPurpose - ${purposeController.text}. \nPlease do the needful');
                          });
                        });
                      },
                      child: Text(
                        "Notify Concerned Officials",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  List<LatLng> convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];

    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }

    return result;
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = [];
    int index = 0;
    int len = poly.length;
    int c = 0;
// repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negetive then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

/*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  void onCameraMove(CameraPosition position) {
    setState(() {
      _lastPosition = position.target;
    });
  }

  void _getUserLocation() async {
    print("GET USER METHOD RUNNING =========");
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });

    print(
        "the latitude is: ${position.longitude} and the longitude is: ${position.longitude} ");
    print("initial position is : ${_initialPosition.toString()}");
    _addMarker(
        LatLng(position.latitude, position.longitude), placemark[0].name);
    locationController.text = placemark[0].name;
  }

  void sendRequest(String intendedLocation) async {
    List<Placemark> placemark =
        await Geolocator().placemarkFromAddress(intendedLocation);
    double latitude = placemark[0].position.latitude;
    double longitude = placemark[0].position.longitude;
    LatLng destination = LatLng(latitude, longitude);
    print("====================================");
    print(intendedLocation);
    _addMarker(destination, intendedLocation);
    // String route = await _googleMapsServices.getRouteCoordinates(
    //     _initialPosition, destination);
    // createRoute(route);
    // notifyListeners();
  }

  void _addMarker(LatLng location, String address) {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(_lastPosition.toString()),
          position: location,
          infoWindow: InfoWindow(title: address, snippet: "go here"),
          icon: BitmapDescriptor.defaultMarker));
    });
    // notifyListeners();
  }

  void createRoute(String encondedPoly) {
    setState(() {
      _polyLines.add(Polyline(
          polylineId: PolylineId(_lastPosition.toString()),
          width: 10,
          points: convertToLatLng(_decodePoly(encondedPoly)),
          color: Colors.black));
    });
    // notifyListeners();
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
