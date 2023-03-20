import 'package:demos_ai/application/maps_cubit/maps_cubit.dart';
import 'package:demos_ai/presentation/pages/maps/widgets/my_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

import '../../../infrastructure/services/time_deleyed.dart';

class MapsPage extends StatefulWidget {
  final VoidCallback onExit;

  const MapsPage({Key? key, required this.onExit}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final _delayed = Delayed(milliseconds: 700);

  MapType type = MapType.normal;

  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    var event = context.read<MapsCubit>();
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        widget.onExit();
        return Future(() => false);
      },
      child: BlocBuilder<MapsCubit, MapsState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: LayoutBuilder(builder: (context, v) {
              return Stack(
                children: [
                  GoogleMap(
                    indoorViewEnabled: true,
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                    myLocationEnabled: true,
                    mapType: type,
                    markers: state.setOfMarker ?? {},
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    initialCameraPosition: const CameraPosition(
                        target: LatLng(41.285416, 69.204007), zoom: 17),
                    onMapCreated: (GoogleMapController controller) {
                      controller.setMapStyle(state.mapTheme);
                      mapController = controller;
                    },
                    onTap: (position) {
                      context.read<MapsCubit>().setMarkerIcon(
                          position: position, onTap: () {}, context: context);
                    },
                  ),
                  SafeArea(
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 16, right: 24, left: 24),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MyFormFiled(
                            title: "Search",
                            onChange: (s) async {
                              _delayed.run(() async {
                                event.search(s);
                              });
                            },
                            fillColor:
                                Theme.of(context).scaffoldBackgroundColor,
                          ),
                          searchWidget(
                              searchText: state.searchText ?? "",
                              onTap: (position) {
                                FocusScope.of(context).unfocus();
                                event.search("");
                                event.setMarkerIcon(
                                    context: context, position: position);
                                changeCamera(
                                    lat: position.latitude,
                                    lng: position.longitude);
                              })
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await context.read<MapsCubit>().determinePosition(context);
                changeCamera(
                    lat: state.currentPosition?.latitude ?? 0,
                    lng: state.currentPosition?.longitude ?? 0);
              },
              child: Icon(
                Icons.my_location,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          );
        },
      ),
    );
  }

  changeCamera({required double? lat, required double? lng}) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat ?? 0, lng ?? 0), zoom: 18),
      ),
    );
  }

  searchWidget(
      {required String searchText, required ValueChanged<LatLng> onTap}) {
    return Center(
      child: (searchText.isNotEmpty)
          ? FutureBuilder(
              future: Nominatim.searchByName(
                query: searchText,
                limit: 5,
                addressDetails: true,
                extraTags: true,
                nameDetails: true,
              ),
              builder: (context, value) {
                if (value.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: value.data?.length ?? 0,
                      itemBuilder: (context2, index) {
                        return GestureDetector(
                          onTap: () {
                            onTap(
                              LatLng(value.data?[index].lat ?? 0,
                                  value.data?[index].lon ?? 0),
                            );
                          },
                          child: Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: Padding(
                              padding: EdgeInsets.all(12.r),
                              child: Text(
                                value.data?[index].displayName ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(fontSize: 14.3),
                              ),
                            ),
                          ),
                        );
                      });
                } else if (value.hasError) {
                  return Text(value.error.toString());
                } else {
                  return const CircularProgressIndicator();
                }
              })
          : const SizedBox.shrink(),
    );
  }
}
