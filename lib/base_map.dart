import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';
import 'package:flutter_application_1/themes/light_color.dart';
import 'package:flutter_application_1/themes/theme.dart';
import 'package:flutter_application_1/widgets/title_text.dart';
import 'package:flutter_application_1/widgets/extentions.dart';


class BaseMapPage extends StatefulWidget {
  @override
  _BaseMapPageState createState() => _BaseMapPageState();
}

class _BaseMapPageState extends State<BaseMapPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<NaverMapController> _controller = Completer();
  List<Marker> _markers = [];
  bool detail = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OverlayImage.fromAssetImage(
        assetName: 'icon/marker.png',
        context: context,
      ).then((image) {
        setState(() {
          Marker(
              markerId: 'id',
              position: LatLng(37.563600, 126.962370),
              captionText: "커스텀 아이콘",
              captionColor: Colors.indigo,
              captionTextSize: 20.0,
              alpha: 0.8,
              icon: image,
              anchor: AnchorPoint(0.5, 1),
              minZoom: 10,
              captionMinZoom: 10,
              width: 45,
              height: 45,
              infoWindow: '인포 윈도우',
              onMarkerTab: _onMarkerTap);
        });
      });
    });
    /*
    _markers.add(Marker(
        markerId: DateTime.now().toIso8601String(),
        position: LatLng(37.569968415084, 126.93120094519),
        infoWindow: '테스트',
        onMarkerTab: _onMarkerTap,
      ));
    setState(() {});
    */
    FirebaseFirestore.instance.collection('point1').get().then((value) {
      if(value.docs.isNotEmpty){
        for(int i =0; i<value.docs.length; i++){
          print(value.docs[i]);
          print('위치 : ${value.docs[i].data()['location'].latitude},'
                '${value.docs[i].data()['location'].longitude}');
          _markers.add(Marker(
            markerId: _markers.length.toString(),
            position: LatLng(value.docs[i].data()['location'].latitude, value.docs[i].data()['location'].longitude),
            infoWindow: '인포 윈도우',
            captionText: value.docs[i].id,
            captionMinZoom: 15,
            onMarkerTab: _onMarkerTap));
          setState(() {});
        }
      }
    });

    /*
    FirebaseFirestore.instance.collection('point1').get().then((value) {
      if(value.docs.isNotEmpty){
          print('firebase 불러오기 성공!');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            OverlayImage.fromAssetImage(
              assetName: 'icon/marker.png',
              context: context,
            ).then((image) {
              setState(() {
                for(int i =0; i<value.docs.length; i++){
                    print(value.docs[i].data());
                    _markers.add(Marker(
                    markerId: 'id',
                    position: LatLng(
                      value.docs[i].data()["loaction"].latitude, 
                      value.docs[i].data()["loaction"].longitude),
                    captionText: "커스텀 아이콘",
                    captionColor: Colors.indigo,
                    captionTextSize: 20.0,
                    alpha: 0.8,
                    icon: image,
                    anchor: AnchorPoint(0.5, 1),
                    width: 45,
                    height: 45,
                    infoWindow: '인포 윈도우',
                    onMarkerTab: _onMarkerTap));
                }
              });
            });
          });
        /*
        for(int i =0; i<value.docs.length; i++){
                    print('위치 : ${value.docs[i].data()['loaction'].latitude},'
                          '${value.docs[i].data()['loaction'].longitude}');
                    _markers.add(Marker(
                    markerId: 'id',
                    position: LatLng(
                      value.docs[i].data()['loaction'].latitude, 
                      value.docs[i].data()['loaction'].longitude),
                    infoWindow: '인포 윈도우',
                    onMarkerTab: _onMarkerTap));
        }
        setState(() {});
        */
      }
    });
    */
    super.initState();
  }

  MapType _mapType = MapType.Basic;
  LocationTrackingMode _trackingMode = LocationTrackingMode.NoFollow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          NaverMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(37.569968415084, 126.93120094519),
              zoom: 17,
            ),
            onMapCreated: onMapCreated,
            mapType: _mapType,
            initLocationTrackingMode: _trackingMode,
            locationButtonEnable: true,
            indoorEnable: true,
            onCameraChange: _onCameraChange,
            onCameraIdle: _onCameraIdle,
            onMapTap: _onMapTap,
            onMapLongTap: _onMapLongTap,
            onMapDoubleTap: _onMapDoubleTap,
            onMapTwoFingerTap: _onMapTwoFingerTap,
            onSymbolTap: _onSymbolTap,
            markers: _markers,
          ),
          if(detail == true)_detailWidget(),
          Padding(
            padding: EdgeInsets.all(16),
            child: _mapTypeSelector(),
          ),
          _trackingModeSelector(),
        ],
      ),
    );
  }

  _onMapTap(LatLng position) async{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
          Text('[onTap] lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
    setState(() {
      detail = false;
    });
  }

  _onMapLongTap(LatLng position) {
    /*
    _markers.add(Marker(
        markerId: DateTime.now().toIso8601String(),
        position: LatLng(37.569968415084, 126.93120094519),
        infoWindow: '테스트',
        onMarkerTab: _onMarkerTap,
      ));
      for(int i =0; i< _markers.length; i++)
      {
        print('마커 ${i}: ${_markers[i].position.latitude},'
                          '${_markers[i].position.longitude}');
      }
      setState(() {});
    */
    setState(() {
      _markers.clear();
    });
    /*
    LatLng tmp = LatLng(37.569968415084954, 126.93120094519954);
    FirebaseFirestore.instance.collection('point1').get().then((value) {
      if(value.docs.isNotEmpty){
        for(int i =0; i<value.docs.length; i++){
                    print('위치 : ${value.docs[i].data()['loaction'].latitude},'
                          '${value.docs[i].data()['loaction'].longitude}');
                    OverlayImage.fromAssetImage(
                      assetName: 'icon/marker.png',
                      context: context,
                    ).then((image) {
                      setState(() {
                        _markers.add(Marker(
                            markerId: 'id',
                            position: tmp,
                            captionText: "커스텀 아이콘",
                            captionColor: Colors.indigo,
                            captionTextSize: 20.0,
                            alpha: 0.8,
                            icon: image,
                            anchor: AnchorPoint(0.5, 1),
                            width: 45,
                            height: 45,
                            infoWindow: '인포 윈도우',
                            onMarkerTab: _onMarkerTap));
                      });
                    });      
                    //_markers.add(Marker(
                    //markerId: 'id',
                    //position: tmp,
                    //infoWindow: '인포 윈도우',
                    //onMarkerTab: _onMarkerTap));
                    //setState(() {});
        }
      }
    });
    */
    //setState(() {});
        
    
    /*
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          '[onLongTap] lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
    */
  }

  _onMapDoubleTap(LatLng position) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          '[onDoubleTap] lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
  }

  _onMapTwoFingerTap(LatLng position) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          '[onTwoFingerTap] lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
  }

  _onSymbolTap(LatLng position, String caption) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          '[onSymbolTap] caption: $caption, lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
  }

  _mapTypeSelector() {
    return SizedBox(
      height: kToolbarHeight,
      child: ListView.separated(
        itemCount: MapType.values.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => SizedBox(width: 16),
        itemBuilder: (_, index) {
          final type = MapType.values[index];
          String title;
          switch (type) {
            case MapType.Basic:
              title = '기본';
              break;
            case MapType.Navi:
              title = '내비';
              break;
            case MapType.Satellite:
              title = '위성';
              break;
            case MapType.Hybrid:
              title = '위성혼합';
              break;
            case MapType.Terrain:
              title = '지형도';
              break;
          }

          return GestureDetector(
            onTap: () => _onTapTypeSelector(type),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 3)]),
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 13),
              ),
            ),
          );
        },
      ),
    );
  }

  _trackingModeSelector() {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: _onTapTakeSnapShot,
        child: Container(
          margin: EdgeInsets.only(right: 16, bottom: 48),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                )
              ]),
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.photo_camera,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 지도 생성 완료시
  void onMapCreated(NaverMapController controller) {
    if (_controller.isCompleted) _controller = Completer();
    _controller.complete(controller);
  }

  /// 지도 유형 선택시
  void _onTapTypeSelector(MapType type) async {
    if (_mapType != type) {
      setState(() {
        _mapType = type;
      });
    }
  }

  /// my location button
  // void _onTapLocation() async {
  //   final controller = await _controller.future;
  //   controller.setLocationTrackingMode(LocationTrackingMode.Follow);
  // }

  void _onCameraChange(
      LatLng latLng, CameraChangeReason reason, bool isAnimated) {
    print('카메라 움직임 >>> 위치 : ${latLng.latitude}, ${latLng.longitude}'
        '\n원인: $reason'
        '\n에니메이션 여부: $isAnimated');
    
  }

  void _onCameraIdle() {
    print('카메라 움직임 멈춤');
  }

  /// 지도 스냅샷
  void _onTapTakeSnapShot() async {
    final controller = await _controller.future;
    controller.takeSnapshot((path) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: path != null
                  ? Image.file(
                      File(path),
                    )
                  : Text('path is null!'),
              titlePadding: EdgeInsets.zero,
            );
          });
    });
  }

  void _onMarkerTap(Marker marker, Map<String, int> iconSize) {
    int pos = _markers.indexWhere((m) => m.markerId == marker.markerId);
    setState(() {
      detail = true;
      //_markers[pos].captionText = '선택됨';
    });
  }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .8,
      initialChildSize: .53,
      minChildSize: .53,
      builder: (context, scrollController) {
        return Container(
          padding: AppTheme.padding.copyWith(bottom: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: LightColor.iconColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TitleText(text: "NIKE AIR MAX 200", fontSize: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TitleText(
                                text: "\$ ",
                                fontSize: 18,
                                color: LightColor.red,
                              ),
                              TitleText(
                                text: "240",
                                fontSize: 25,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.star,
                                  color: LightColor.yellowColor, size: 17),
                              Icon(Icons.star,
                                  color: LightColor.yellowColor, size: 17),
                              Icon(Icons.star,
                                  color: LightColor.yellowColor, size: 17),
                              Icon(Icons.star,
                                  color: LightColor.yellowColor, size: 17),
                              Icon(Icons.star_border, size: 17),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _availableSize(),
                SizedBox(
                  height: 20,
                ),
                _availableColor(),
                SizedBox(
                  height: 20,
                ),
                _description(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _availableSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Available Size",
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _sizeWidget("US 6"),
            _sizeWidget("US 7", isSelected: true),
            _sizeWidget("US 8"),
            _sizeWidget("US 9"),
          ],
        )
      ],
    );
  }

  Widget _sizeWidget(String text,
      {Color color = LightColor.iconColor, bool isSelected = false}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
            color: LightColor.iconColor,
            style: !isSelected ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color:
            isSelected ? LightColor.orange : Theme.of(context).backgroundColor,
      ),
      child: TitleText(
        text: text,
        fontSize: 16,
        color: isSelected ? LightColor.background : LightColor.titleTextColor,
      ),
    ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _availableColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Available Size",
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _colorWidget(LightColor.yellowColor, isSelected: true),
            SizedBox(
              width: 30,
            ),
            _colorWidget(LightColor.lightBlue),
            SizedBox(
              width: 30,
            ),
            _colorWidget(LightColor.black),
            SizedBox(
              width: 30,
            ),
            _colorWidget(LightColor.red),
            SizedBox(
              width: 30,
            ),
            _colorWidget(LightColor.skyBlue),
          ],
        )
      ],
    );
  }

  Widget _colorWidget(Color color, {bool isSelected = false}) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: color.withAlpha(150),
      child: isSelected
          ? Icon(
              Icons.check_circle,
              color: color,
              size: 18,
            )
          : CircleAvatar(radius: 7, backgroundColor: color),
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Available Size",
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Text('Hello World'),
      ],
    );
  }

}