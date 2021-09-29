import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Utils/FormatDate.dart';
import 'package:report_visita_danilo/Utils/ZoomButtonsPluginOption.dart';
import 'package:report_visita_danilo/Models/Event.dart';

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

  late Store _store;
  late List<Azienda> listaAziende = [];

   bool hasBeenInitialized = false;
  bool locationInitialized = false;
  bool inizializedMap = false;
  final key=GlobalKey<ScaffoldState>();

  List<Azienda> listaAziende2 = [];

 late FlutterMap mappa;

  @override
  initState() {
    super.initState();
    Azienda azienda1 =
        Azienda(nome: "Azienda 1", indirizzo: "Via casa mia", citta: "Roma",lng: 9.188120,lat:45.463619);
    Event element = new Event();
    element.date = new DateTime.utc(2021, 9, 30, 10, 30);
    azienda1.events.add(element);

    Azienda azienda2 =
        Azienda(nome: "SS Lazio", indirizzo: "Via casa mia", citta: "Roma",lng: -95.903633,lat:36.076637 );
    Event element2 = new Event();
    element2.date = new DateTime.utc(2021, 9, 30, 10, 30);
    azienda2.events.add(element2);

    Azienda azienda3 =
        Azienda(nome: "Fc Inter", indirizzo: "Via casa mia", citta: "Roma",lng:13.181720,lat:41.473430);
    Event element3 = new Event();
    element3.date = new DateTime.utc(2021, 9, 30, 10, 30);
    azienda3.events.add(element3);

    listaAziende2 = [
      azienda1,
      azienda2,
      azienda3,
    ];
    _prepareMarker();


   // _mapController = MapController();
    _getCurrentLocation();
  }

  void _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentLocation = position;
        locationInitialized=true;
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
      key: key,
      body: !hasBeenInitialized && !locationInitialized
          ? Center(child: CircularProgressIndicator(color:Colors.red))
          : Stack(
              children: [
                Visibility(visible: viewMap ,
                    child: inizializedMap? buildBodyMap():
                    Center(child: CircularProgressIndicator(color:Colors.red))),
                Visibility(visible: !viewMap ,
                    child: buildBody()),

                Padding(
                  padding: EdgeInsets.only(top: 28.h, left: 4.w, right: 4.w),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * .80,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
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
                                suffixIcon:
                                    Icon(Icons.search, color: Colors.black),
                                hintText: "cerca",
                                hintStyle: new TextStyle(color: Colors.black)),
                            onChanged: searchOperation,
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
    for (int i = 0; i < listaAziende2.length; i++) {
      String data = listaAziende2[i].nome!;
      if (data.toLowerCase().contains(searchText.toLowerCase())) {
        setState(() {
          searchresult.add(listaAziende2[i]);
        });
      }
      setState(() {});
    }
  }

  buildBody() {
    return Padding(
      padding: EdgeInsets.only(top: 80.h),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: AlphabetListScrollView(
            indexedHeight: (int i) {
              return 67.h;
            },
            strList: List<String>.generate(listaAziende2.length, (i) {
              return "${listaAziende2[i].nome}";
            }),
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.only(left: 21.w, top: 8.h, bottom: 8.h),
                  child: Card(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                listaAziende2[index].nome!,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 15.712129.sp,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.15,
                                ),
                              ),
                              Text(
                                FormatDate.fromDateTimeToString(
                                    listaAziende2[index]
                                        .events
                                        .elementAt(0)
                                        .date!,
                                    "data"),
                                style: TextStyle(
                                  color: Colors.red[700],
                                  fontSize: 15.712129.sp,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.15,
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ));
            }),
      ),
    );
  }

  buildBodyMap() {
    return SafeArea(

        top: false,
        bottom: false,
        child: Padding(
            padding: EdgeInsets.all(0.0),
            child: Column(
                children: [Flexible(
                    child: mappa)])));
  }

  creaListaAzienda() async {
    final lista = await _store.box<Azienda>().getAll();
    setState(() {
      listaAziende2 = lista;
      hasBeenInitialized = false;
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
            polygonOptions: PolygonOptions(
                borderColor: Colors.blueAccent,
                color: Colors.black12,
                borderStrokeWidth: 2),
            onMarkerTap: (marker) {

              final Azienda _actualAziendaSelected = listaAziende2.firstWhere((element) => element.getKey() == marker.key.toString());
             key.currentState!.showSnackBar(
               new SnackBar(duration: Duration(days:1),
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
                             child: IconButton( icon:Icon(
                               Icons.arrow_drop_down,
                               color: Colors.white,
                               size: 36,
                             ),
                             onPressed: (){

                               key.currentState!.hideCurrentSnackBar();
                             },),
                           ),
                         ),
                         Container(
                           width: MediaQuery.of(context).size.width*.70,
                           child: AutoSizeText(
                             _actualAziendaSelected.nome!+"\n"+_actualAziendaSelected.indirizzo!,
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
      mappa= _flutterMap;
      inizializedMap=true;
    });
  }
}
