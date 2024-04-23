import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_application_1/views/trangChu.dart';
import 'package:location/location.dart' as location;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late List<Polygon> _polygons;
  int _selectedIndex = 1;
  late Marker _userLocationMarker;
List<Map<String, dynamic>> stores = [
    {
      'tenCH': 'Cửa hàng A',
      'maCH': 'CH001',
      'diaChi': 'Địa chỉ A',
      'cttb': 'Chi tiết thông báo A',
            'location': LatLng(16.0544, 107.8689)

    },
    {
      'tenCH': 'Cửa hàng B',
      'maCH': 'CH002',
      'diaChi': 'Địa chỉ B',
      'cttb': 'Chi tiết thông báo B',
            'location': LatLng(16.0544, 107.8690)

    },
    {
      'tenCH': 'Cửa hàng C',
      'maCH': 'CH003',
      'diaChi': 'Địa chỉ C',
      'cttb': 'Chi tiết thông báo C',
            'location': LatLng(16.0545, 107.8689)

    },
  ];
  late Map<String, dynamic> _selectedStore = {};

    @override
  void initState() {
    super.initState();
    _userLocationMarker = Marker(
      width: 40.0,
      height: 40.0,
      point: LatLng(0, 0), // Placeholder position
      child: Icon(
        Icons.phone_android,
        color: Colors.blue,
        size: 40,
      ),
    );
    _getUserLocation();
  }


  Future<void> _getUserLocation() async {
    try {
      final locationData = await location.Location().getLocation();
      setState(() {
        Marker _userLocationMarker = Marker(
          width: 40.0,
          height: 40.0,
          point: LatLng(0, 0),
          
          child: Icon(
            Icons.store,
            color: Colors.blue,
            size: 40,
          ),
        );
      });
    } catch (e) {
      print("Error getting user location: $e");
    }
  }

void _onMarkerTapped(Map<String, dynamic> store) {
    setState(() {
      _selectedStore = store;
    });
  }
  

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'Digitalized Checker',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 18, 78, 128),
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.menu, color: Color.fromARGB(255, 18, 78, 128)),
        onPressed: () {
          _showMenuOptions(context);
        },
      ),
    ),
    body: Column(
      children: [
        Container(
          height: 520,
          child: Center(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(16.0544, 107.8689),
                zoom: 5.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    _userLocationMarker,
                    
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      'Thông tin cửa hàng',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
    ),
    SizedBox(height: 8.0),
    Text(
      'Mã CH: 123456',
      style: TextStyle(fontSize: 14.0),
    ),
    Text(
      'Tên CH: Cửa hàng ABC',
      style: TextStyle(fontSize: 14.0),
    ),
    Text(
      'Địa chỉ: 123 Đường XYZ, Quận ABC, TP HCM',
      style: TextStyle(fontSize: 14.0),
    ),
    Text(
      'CTTB: Dây',
      style: TextStyle(fontSize: 14.0),
    ),
    SizedBox(height: 34.0), 
    Row(
      children: [
        Container(
          width: 12.0,
          height: 12.0,
          color: Color.fromARGB(255, 231, 231, 231), // Color of the legend
          margin: EdgeInsets.only(right: 4.0),
        ),
        Text(
          'Chưa ghé - trong tuyến',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10.0,),
        Container(
          width: 12.0,
          height: 12.0,
          color: Color.fromARGB(255, 141, 221, 143), // Color of the legend
          margin: EdgeInsets.only(right: 4.0),
        ),
        Text(
          'Chưa ghé - ngoài tuyến',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
        
      ],
    ),
    SizedBox(height: 8.0), 
    Row(
      children: [
        Container(
          width: 12.0,
          height: 12.0,
          color: const Color.fromARGB(
            255, 130, 197, 252), // Color of the legend
          margin: EdgeInsets.only(right: 4.0),
        ),
        Text(
          'Đã ghé - chụp hình',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 40.0,),
        Container(
          width: 12.0,
          height: 12.0,
          color: Color.fromARGB(255, 247, 116, 107), // Color of the legend
          margin: EdgeInsets.only(right: 4.0),
        ),
        Text(
          'Đã ghé - Chưa chụp',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
        
      ],
    ),
  ],
),

        ),
      ],
    ),
    bottomNavigationBar: _buildBottomNavigationBar(),
  );
}


  void _showMenuOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            color: Colors.white,
          ),
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.info, color: Colors.blue),
                title: Text('Giới thiệu'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.report, color: Colors.red),
                title: Text('Báo cáo'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.bar_chart, color: Colors.green),
                title: Text('Thống kê'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.orange),
                title: Text('Đăng xuất'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            gap: 8,
            activeColor: Colors.white,
            iconSize: 28,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            duration: Duration(milliseconds: 800),
            tabBackgroundColor: const Color.fromARGB(255, 18, 78, 128),
            tabs: [
              GButton(
                icon: Icons.list,
                text: 'Danh sách',
              ),
              GButton(
                icon: Icons.map,
                text: 'Bản đồ',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
              switch (index) {
                case 0:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TrangChu()));
                  break;
                case 1:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MapPage()));
                  break;
                default:
              }
            },
          ),
        ),
      ),
    );
  }
}