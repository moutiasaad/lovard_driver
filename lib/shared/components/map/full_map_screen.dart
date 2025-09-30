import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lovard_delivery_app/shared/language/extension.dart';

import '../../../utils/app_images.dart';
import '../buttons/default_button.dart';

class FullMapScreen extends StatefulWidget {
  const FullMapScreen({super.key, required this.latitude, required this.longitude});
  final double latitude ;
  final double longitude ;

  @override
  State<FullMapScreen> createState() => _FullMapScreenState();
}

class _FullMapScreenState extends State<FullMapScreen> {

  late GoogleMapController mapController;
  BitmapDescriptor? _customIcon;
  bool doneLoading = false;
  late LatLng _center;

  @override
  void initState() {

    _loadCustomIcon().then((value) {

      setState(() {
        doneLoading = true;
      });
    });
    _center = LatLng(widget.latitude, widget.longitude);
    super.initState();
  }

  Future<void> _loadCustomIcon() async {
    _customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)), // Set the size of the icon
      AppImages.marker,
      // Path to the custom icon
    );
  }

  // San Francisco

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  void _onMapTapped(LatLng position) {
    setState(() {
      _center = position;

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: doneLoading
          ? Stack(
        children: [
          Container(
            child: GoogleMap(
              onTap: _onMapTapped,
              mapType: MapType.normal,
              markers: {
                Marker(
                  markerId: MarkerId(_center.toString()),
                  position: _center,
                  icon: _customIcon ?? BitmapDescriptor.defaultMarker,
                )
              },
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 16.0,
              ),
            ),
          ),
          Positioned(
              bottom: 50,
              right: 80,
              left: 80,
              child:
              DefaultButton(
                  text: context.translate('buttons.save'),
                  pressed: (){
                    Navigator.pop(context,[_center.latitude,_center.longitude]);
                  },
                  activated: true))

        ],
      )
          : const CircularProgressIndicator(),
    );
  }
}
