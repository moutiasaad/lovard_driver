import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_text_styles.dart';
import '../buttons/default_button.dart';
import 'full_map_screen.dart';

class MapScreenComponent extends StatefulWidget {
  const MapScreenComponent(
      {super.key,
      required this.latitudeS,
      required this.longitudeS,
      this.merchantName,
      this.userName,
      this.onFullScreen = false,
      this.selectResult,
      this.latitudeC,
      this.longitudeC,
      this.zoom = 16});

  final double? latitudeC;
  final double? longitudeC;
  final double latitudeS;
  final double longitudeS;
  final String? merchantName;
  final bool onFullScreen;
  final Function? selectResult;
  final String? userName;
  final double zoom;

  @override
  _MapScreenComponentState createState() => _MapScreenComponentState();
}

class _MapScreenComponentState extends State<MapScreenComponent> {
  late GoogleMapController mapController;
  BitmapDescriptor? _customIconShop;
  BitmapDescriptor? _customIconCustomer;
  bool doneLoading = false;
  late LatLng _center;

  @override
  void initState() {
    _loadCustomIcon().then((value) {
      print('test');
      setState(() {
        doneLoading = true;
      });
    });
    if (widget.latitudeC != null && widget.longitudeC != null) {
      _center = LatLng(
        (widget.latitudeS + widget.latitudeC!) / 2,
        (widget.longitudeS + widget.longitudeC!) / 2,
      );
    } else {
      _center = LatLng(widget.latitudeS, widget.longitudeS);
    }
    super.initState();
  }

  Future<void> _loadCustomIcon() async {
    _customIconShop = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)), // Set the size of the icon
      AppImages.shopMarker, // Path to the custom icon
    );
    _customIconCustomer = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)), // Set the size of the icon
      AppImages.customerMarker, // Path to the custom icon
    );
  }

  // San Francisco

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    if (widget.latitudeC != null && widget.longitudeC != null) {
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          widget.latitudeS < widget.latitudeC!
              ? widget.latitudeS
              : widget.latitudeC!,
          widget.longitudeS < widget.longitudeC!
              ? widget.longitudeS
              : widget.longitudeC!,
        ),
        northeast: LatLng(
          widget.latitudeS > widget.latitudeC!
              ? widget.latitudeS
              : widget.latitudeC!,
          widget.longitudeS > widget.longitudeC!
              ? widget.longitudeS
              : widget.longitudeC!,
        ),
      );
      !Platform.isIOS
          ? Future.delayed(const Duration(milliseconds: 300), () {
              mapController
                  .animateCamera(CameraUpdate.newLatLngBounds(bounds, 80));
            })
          : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return doneLoading
        ? Stack(
            children: [
              Container(
                child: GoogleMap(
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                    Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer()),
                  },
                  mapType: MapType.normal,
                  markers: {
                    Marker(
                        markerId: MarkerId(_center.toString()),
                        position: _center,
                        icon: _customIconShop ?? BitmapDescriptor.defaultMarker,
                        infoWindow: InfoWindow(
                          title: widget.merchantName,
                          //snippet: "This is a marker snippet",
                        )),
                    if (widget.latitudeC != null && widget.longitudeC != null)
                      Marker(
                        markerId: MarkerId('SecondTarget'),
                        position: LatLng(widget.latitudeC!, widget.longitudeC!),
                        icon: _customIconCustomer ??
                            BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueBlue),
                        infoWindow:
                            InfoWindow(title: widget.userName ?? 'name'),
                      ),
                  },
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: widget.zoom,
                  ),
                ),
              ),
              Visibility(
                visible: widget.onFullScreen,
                child: Positioned(
                    top: 10,
                    right: 10,
                    child: DefaultButton(
                        textStyle: AppTextStyle.mediumWhite12,
                        width: 80,
                        height: 28,
                        text: 'تتبع المسار',
                        pressed: () async {
                          String destination1 =
                              '${widget.latitudeS},${widget.longitudeS}';
                          String url;

                          if (widget.latitudeC != null &&
                              widget.longitudeC != null) {
                            String destination2 =
                                '${widget.latitudeC},${widget.longitudeC}';
                            url =
                                'https://www.google.com/maps/dir/?api=1&origin=My+Location&destination=$destination1&waypoints=$destination2&travelmode=driving';
                          } else {
                            url =
                                'https://www.google.com/maps/dir/?api=1&origin=My+Location&destination=$destination1&travelmode=driving';
                          }

                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url),
                                mode: LaunchMode.externalApplication);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        activated: true)),
              )
            ],
          )
        : const SizedBox();
  }
}
