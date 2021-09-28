import 'package:flutter/material.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Utils/ZoomButtonsPluginOption.dart';

class ListaAziende extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListaAziendeState();
}

class ListaAziendeState extends State<ListaAziende> {

  late final MapController _mapController;
  List<Marker> _markers = [];
  Position? _currentLocation;


  bool viewMap=false;
  final TextEditingController _controller = new TextEditingController();
  List<Azienda> searchresult = [];

  List<Azienda> listaAziende = [
    Azienda(nome: "aaaa"),
    Azienda(nome: "bbbbb"),
    Azienda(nome: "ccccc")
  ];



  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getCurrentLocation();
  }


  void _getCurrentLocation() {
    Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentLocation = position;
       // _buildBody();
      });
    }).catchError((e) {
      print(e);
    });
  }


  void _prepareMarker() {

    if(searchresult.isEmpty){

    _markers = listaAziende.map((element) {

      Marker marker = Marker(
          point:LatLng(element.lat!, element.lng!),
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
    } else{
      void _prepareMarker() {
        _markers = searchresult.map((element) {
          Marker marker = Marker(
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

    }
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          !viewMap?buildBody():buildBodyMap(),
          Padding(
            padding: EdgeInsets.only(top: 28.h,left: 4.w,right: 4.w),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(

                children: [

                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width*.80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)
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
                            borderSide:
                            BorderSide(color: Colors.white, width: 0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 0),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          suffixIcon: Icon(Icons.search, color: Colors.black),
                          hintText: "cerca",
                          hintStyle: new TextStyle(color: Colors.black)),
                      onChanged: searchOperation,
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 4.0.w),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.red,
                      child: IconButton(
                        icon: Icon(
                          viewMap?Icons.list_alt:Icons.map_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {

                          setState(() {
                            viewMap=!viewMap;
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

    for (int i = 0; i < listaAziende.length; i++) {
      String data = listaAziende[i].nome!;
      if (data.toLowerCase().contains(searchText.toLowerCase())) {
        setState(() {
          searchresult.add(listaAziende[i]);
        });
      }
      setState(() {});
    }
  }

  buildBody() {
    return  Padding(
      padding: EdgeInsets.only(top:80.h),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: AlphabetListScrollView(
            indexedHeight: (int i) {
              return 80;
            },
            strList: List<String>.generate(listaAziende.length, (i) {
              return "${listaAziende[i].nome}";
            }),
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      listaAziende[index].nome!,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 12.075892.sp,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 2.w),
                                    ),
                                  ],
                                ),
                              ]),
                        ]),
                  ));
            }),
      ),
    );
  }

  buildBodyMap() {
    return SafeArea(
      top:false,
      bottom: false,
      child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Column(children: [Flexible(child: _buildFlatterMap(context))]))

    );
  }



  Widget _buildFlatterMap(BuildContext context) {
    late LatLng _location;
    if (_currentLocation != null) {
      _location =
          LatLng(_currentLocation!.latitude, _currentLocation!.longitude);
    } else {

    }

    FlutterMap _flutterMap = FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: _location,
          zoom: 8.0,
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
            polygonOptions: PolygonOptions(
                borderColor: Colors.blueAccent,
                color: Colors.black12,
                borderStrokeWidth: 2),
            onMarkerTap: (marker) {
              //_showSheet(marker.key.toString());
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
            zoomInColor:  Colors.red,
            zoomInColorIcon: Colors.white,
            zoomOutColorIcon: Colors.white,
            alignment: Alignment.bottomLeft,
          )

        ]);
    return _flutterMap;
  }







}
