import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:azlistview/azlistview.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Screen/AziendaDettaglio.dart';
import 'package:report_visita_danilo/Utils/ZoomButtonsPluginOption.dart';
import 'package:report_visita_danilo/Models/Event.dart';
import 'package:report_visita_danilo/costanti.dart';

import '../objectbox.g.dart';

class ListaAziende extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListaAziendeState();
}

class ListaAziendeState extends State<ListaAziende> {
  late final MapController _mapController;
  List<Marker> _markers = [];
  Position? _currentLocation;

  bool viewMap = false;
  final TextEditingController _controller = new TextEditingController();
  List<Azienda> searchresult = [];
  bool hasBeenInitialized = false;
  bool locationInitialized = false;
  bool inizializedMap = false;
  final key = GlobalKey<ScaffoldState>();

  List<Azienda> listaAziende2 = [];

  late FlutterMap mappa;

  List<_AZItem> items = [];

  void initList(List<Azienda> listaAziende2) {
    this.items = listaAziende2
        .map((item) => _AZItem(
            nomeAzienda: item.nome!,
            tag: item.nome![0].toUpperCase(),
            azienda: item))
        .toList();

    SuspensionUtil.sortListBySuspensionTag(this.items);
    SuspensionUtil.setShowSuspensionStatus(this.items);
    setState(() {});
  }

  @override
  initState() {
    super.initState();

    creaListaAzienda();

    Timer(Duration(seconds: 5), (){

      initList(listaAziende2);
      _prepareMarker();
      _getCurrentLocation();


    });

  }

  void _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentLocation = position;
        locationInitialized = true;
      });
      _buildFlatterMap();
    }).catchError((e) {
      print(e);
    });
  }

  void _prepareMarker() {
    if (searchresult.isEmpty) {
      _markers = listaAziende2.map((element) {
        Key _key = GlobalKey();
        element.setKey(_key);
        Marker marker = Marker(
            key: _key,
            point: LatLng(element.lat!, element.lng!),
            width: ScreenUtil().setWidth(49),
            height: ScreenUtil().setHeight(65),
            builder: (context) => Opacity(
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        "assets/marker.png",
                        width: ScreenUtil().setWidth(49),
                        height: ScreenUtil().setHeight(65),
                      )),
                  opacity: 1.0,
                ));
        return marker;
      }).toList();
    } else {

      _markers = searchresult.map((element) {
        Key _key = GlobalKey();
        element.setKey(_key);
        Marker marker = Marker(
            key: _key,
            point: LatLng(element.lat!, element.lng!),
            width: ScreenUtil().setWidth(49),
            height: ScreenUtil().setHeight(65),
            builder: (context) => Opacity(
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        "assets/marker.png",
                        width: ScreenUtil().setWidth(49),
                        height: ScreenUtil().setHeight(65),
                      )),
                  opacity: 1.0,
                ));

        return marker;
      }).toList();
    }


    setState(() {
      hasBeenInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,

      key: key,
      body: !hasBeenInitialized && !locationInitialized ? Center(child: CircularProgressIndicator(color:Colors.red)):
          Stack(
        children: [
          Visibility(
              visible: viewMap,
              child: inizializedMap
                  ? buildBodyMap()
                  : Center(
                      child: CircularProgressIndicator(color: Colors.red))),
          Visibility(visible: !viewMap, child: buildBody()),
          Padding(
            padding: EdgeInsets.only(top: 28.h, left: 4.w, right: 4.w),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only (left: 20.w),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * .75,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: TextField(
                        controller: _controller,
                        style: new TextStyle(
                          color: Colors.black,
                        ),
                        decoration: new InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          suffixIcon: Icon(Icons.search, color: Colors.black),
                        ),
                        onChanged: searchOperation,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.0.w),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.red,
                      child: IconButton(
                        icon: Icon(
                          viewMap ? Icons.list_alt : Icons.map_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            viewMap = !viewMap;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    for (int i = 0; i < items.length; i++) {
      String? data = items[i].nomeAzienda;
      if (data.toLowerCase().contains(searchText.toLowerCase())) {
        setState(() {
          searchresult.add(items[i].azienda);
        });
      } else
        setState(() {});
    }
  }

  buildBody() {
    return Padding(
      padding: EdgeInsets.only(top: 80.h, left: 4.w, right: 8.w),
      child: AzListView(
          data: items,
          indexBarHeight: 340.h,
          indexBarWidth: 12.h,
          indexBarAlignment: Alignment.topRight,
          indexBarOptions: IndexBarOptions(
            needRebuild: true,ignoreDragCancel: false,
            downColor: Colors.red,
            selectTextStyle: TextStyle(color: Colors.white),
            indexHintDecoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            selectItemDecoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            textStyle: TextStyle(color: Colors.white),
            indexHintAlignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(color: Colors.red, width: 0.0),
              borderRadius: new BorderRadius.all(Radius.elliptical(100, 100),
              ),
            ),
          ),
          itemBuilder: (BuildContext context, int index) {
            if (searchresult.isEmpty) {
              return _buildListItem(items[index]);
            } else
              return _buildListItem(fromAziendaToAZItem(searchresult[index]));
          },
          itemCount: searchresult.isEmpty ? items.length : searchresult.length,
      ),
    );
  }

  Widget _buildListItem(_AZItem item) {
    final tag = item.getSuspensionTag();
    final offstage = !item.isShowSuspension;

    return GestureDetector(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AziendaDettaglio(azienda: item.azienda)));
      },
      child: Column(
        children: [
          Offstage(offstage: offstage, child: _buildHeader(tag)),
          Padding(
            padding: EdgeInsets.only(right: 40.w, left: 21.w),
            child: Card(
              elevation: 5,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.symmetric(vertical: 8.h),
              child: Container(
                height: 60.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12.w),
                          child: Text(
                            item.nomeAzienda,
                            style: TextStyle(
                                fontSize: 15.712129,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[700]),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: Text(item.azienda.events.isNotEmpty?
                            item.azienda.events
                                    .elementAt(0)
                                    .date!
                                    .day
                                    .toString() +
                                "/" +
                                item.azienda.events
                                    .elementAt(0)
                                    .date!
                                    .month
                                    .toString() +
                                "/" +
                                item.azienda.events
                                    .elementAt(0)
                                    .date!
                                    .year
                                    .toString():"non ci sono eventi",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 13.748113.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(right: 12.w, bottom: 4.h, top: 8.h),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(
                          Icons.circle,
                          color: Colors.lightGreenAccent,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String tag) {
    return Padding(
      padding: EdgeInsets.only(left: 21.w),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text('$tag',
            softWrap: false,
            style: TextStyle(
                fontSize: 20.126488.sp,
                fontWeight: FontWeight.w400,
                color: Colors.red)),
      ),
    );
  }

  buildBodyMap() {
    return SafeArea(
        top: false,
        bottom: false,
        child: Padding(
            padding: EdgeInsets.all(0.0),
            child: Column(children: [Expanded(child: mappa)])));
  }

  creaListaAzienda() async {

    final lista =   mainStore!.box<Azienda>().getAll();
    setState(() {
      listaAziende2 = lista;
    });
  }

  _buildFlatterMap() {
    late LatLng _location;
    if (_currentLocation != null) {
      _location =
          LatLng(_currentLocation!.latitude, _currentLocation!.longitude);
    } else {
      return CircularProgressIndicator();
    }

    FlutterMap _flutterMap = FlutterMap(

        options: MapOptions(

          center: _location,
          zoom: 8.0,
          maxZoom: 18,
          minZoom: 1,
          interactiveFlags: InteractiveFlag.all - InteractiveFlag.rotate,
          plugins: [ZoomButtonsPlugin(), MarkerClusterPlugin()],
          onTap: (tapPosition, point) => null,
        ),
        layers: [
          //LocationMarkerLayerOptions(),
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),

          MarkerClusterLayerOptions(
            maxClusterRadius: 50,
            disableClusteringAtZoom: 8,
            size: Size(ScreenUtil().setWidth(50), ScreenUtil().setWidth(50)),
            fitBoundsOptions: FitBoundsOptions(
              padding: EdgeInsets.all(ScreenUtil().setWidth(50)),
            ),
            markers: _markers,
            centerMarkerOnClick: true,

            polygonOptions: PolygonOptions(
                borderColor: Colors.blueAccent,
                color: Colors.black12,
                borderStrokeWidth: 2),
            onMarkerTap: (marker) {
              final Azienda _actualAziendaSelected = listaAziende2.firstWhere(
                  (element) => element.getKey() == marker.key.toString());
              key.currentState!.showSnackBar(new SnackBar(
                duration: Duration(days: 1),
                padding: EdgeInsets.all(4),

                //width:double.infinity ,

                backgroundColor: Colors.black,
                content: Container(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(100),
                    color: Colors.black,
                    child: Column(
                      //mainAxisAlignment:MainAxisAlignment.start ,
                      // crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Container(
                          // height: ScreenUtil().setHeight(24),
                          child: Align(
                            alignment: Alignment.center,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                                size: 36,
                              ),
                              onPressed: () {
                                key.currentState!.hideCurrentSnackBar();
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .70,
                          child: AutoSizeText(
                            _actualAziendaSelected.nome! +
                                "\n" +
                                _actualAziendaSelected.indirizzo!,
                            maxLines: 3,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.088542.sp,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.25),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: RichText(
                              text: TextSpan(
                            text: 'REPORT',
                            style: new TextStyle(
                              color: Colors.orange,
                              fontSize: ScreenUtil().setSp(13.748113),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.25,
                            ),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () {},
                          )),
                        )
                      ],
                    )),
              ));
              //far visualizzare un toast
            },
            builder: (context, markers) {
              return Container(
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                child: Text('${markers.length}'),
              );
            },
          )
        ],
        nonRotatedLayers: [
          ZoomButtonsPluginOption(
            minZoom: 5,
            maxZoom: 19,
            mini: true,
            padding: 8,
            zoomOutColor: Colors.red,
            zoomInColor: Colors.red,
            zoomInColorIcon: Colors.white,
            zoomOutColorIcon: Colors.white,
            alignment: Alignment.bottomLeft,
          )
        ]);
    setState(() {
      mappa = _flutterMap;
      inizializedMap = true;
    });
  }

  _AZItem fromAziendaToAZItem(Azienda azienda) {
    _AZItem item = new _AZItem(
        tag: azienda.nome![0].toUpperCase(),
        azienda: azienda,
        nomeAzienda: azienda.nome!);
    return item;
  }
}

class _AZItem extends ISuspensionBean {
  final String nomeAzienda;
  final String tag;
  final Azienda azienda;

  _AZItem(
      {required this.nomeAzienda, required this.tag, required this.azienda});

  @override
  String getSuspensionTag() => tag;
}
