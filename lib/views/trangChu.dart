import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/login.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_application_1/views/map.dart';
enum StoreStatus {
  TrongTuyen,
  NgoaiTuyen,
  DaGheThamChuaChupHinh,
  DaGheThamDaChupHinh,
  ChuaXuLy,
}

class TrangChu extends StatefulWidget {
  @override
  _TrangChuState createState() => _TrangChuState();
}

class _TrangChuState extends State<TrangChu> {
  int _selectedIndex = 0;
  bool _isSearching = false;
  String _selectedCity = 'Hồ Chí Minh'; // Thành phố mặc định

  List<Map<String, dynamic>> stores = [
    {
      'maCH': 'CH001',
      'tenCH': 'Cửa hàng A',
      'diaChi': 'Thành phố HCM',
      'cttb': 'Dây',
      'status': StoreStatus.TrongTuyen,
      'lat': 10.8231,
      'lng': 106.6297,
    },
    {
      'maCH': 'CH002',
      'tenCH': 'Cửa hàng B',
      'diaChi': 'Số 2, Thành phố HCM',
      'cttb': 'Chai',
      'status': StoreStatus.NgoaiTuyen,
      'lat': 10.7769,
      'lng': 106.7009,
    },
    {
      'maCH': 'CH003',
      'tenCH': 'Cửa hàng C',
      'diaChi': 'Số 3, Thành phố HCM',
      'cttb': 'Dây',
      'status': StoreStatus.ChuaXuLy,
      'lat': 10.8231,
      'lng': 106.6297,
    },
    {
      'maCH': 'CH002',
      'tenCH': 'Cửa hàng B',
      'diaChi': 'Số 2, Thành phố HCM',
      'cttb': 'Chai',
      'status': StoreStatus.DaGheThamChuaChupHinh,
      'lat': 10.7769,
      'lng': 106.7009,
    },
    {
      'maCH': 'CH003',
      'tenCH': 'Cửa hàng C',
      'diaChi': 'Số 3, Thành phố HCM',
      'cttb': 'Dây',
      'status': StoreStatus.DaGheThamDaChupHinh,
      'lat': 10.8231,
      'lng': 106.6297,
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : _buildTitle(),
        actions: _buildActions(),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Color.fromARGB(255, 18, 78, 128)),
          onPressed: () {
            _showMenuOptions(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 10.0),
                Row(
                  children: [
                    SizedBox(width: 5.0),
                    Text('Thành phố:'),
                    SizedBox(width: 20.0),
                    DropdownButton<String>(
                      value: _selectedCity,
                      items: <String>[
                        'Hà Nội',
                        'Hồ Chí Minh',
                        'Đà Nẵng',
                        'Hải Phòng'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 16.0,color: Color.fromARGB(255, 18, 78, 128)),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedCity = value!;
                        });
                      },
                    ),
                    SizedBox(width: 35.0),
                    Text('Khu vực:'),
                    IconButton(
                      icon: Icon(Icons.filter_list,
                          color:  Color.fromARGB(255, 18, 78, 128)),
                      onPressed: () {
                        _showFilterOptions(context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Divider(height: 0.0),
              ],
            ),
          ),
        ),
      ),
      body: _buildBody(),
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
                  // Xử lý khi người dùng chọn 'Giới thiệu'
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.report, color: Colors.red),
                title: Text('Báo cáo'),
                onTap: () {
                  // Xử lý khi người dùng chọn 'Báo cáo'
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.bar_chart, color: Colors.green),
                title: Text('Thống kê'),
                onTap: () {
                  // Xử lý khi người dùng chọn 'Thống kê'
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.orange),
                title: Text('Đăng xuất'),
                onTap: () {
                  // Xử lý khi người dùng chọn 'Đăng xuất'
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      itemCount: stores.length,
      itemBuilder: (context, index) {
        return _buildStoreItem(stores[index]);
      },
    );
  }

  Widget _buildStoreItem(Map<String, dynamic> store) {
    Color? cardColor;
    switch (store['status']) {
      case StoreStatus.TrongTuyen:
        cardColor = Color.fromARGB(255, 231, 231, 231); // Trong tuyến
        break;
      case StoreStatus.NgoaiTuyen:
        cardColor = Color.fromARGB(255, 141, 221, 143); // Ngoài tuyến
        break;
      case StoreStatus.DaGheThamChuaChupHinh:
        cardColor = const Color.fromARGB(
            255, 130, 197, 252); // Đã ghé thăm, chưa chụp hình
        break;
      case StoreStatus.DaGheThamDaChupHinh:
        cardColor =
            Color.fromARGB(255, 247, 116, 107); // Đã ghé thăm, đã chụp hình
        break;
      case StoreStatus.ChuaXuLy:
        cardColor = Color.fromARGB(255, 255, 243, 137); // Chưa xử lý
        break;
    }

    return Card(
      color: cardColor ??
          Colors
              .white, // Sử dụng màu trắng nếu cardColor không được gán giá trị
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        title: Text(
          '${store['tenCH']} - ${store['maCH']}',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            Text(
              'Địa chỉ: ${store['diaChi']}',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 4.0),
            Text(
              'CTTB: ${store['cttb']}',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.arrow_circle_right,
            color: Colors.black,
          ),
          onPressed: () {
            _viewStoreDetails(store);
          },
        ),
      ),
    );
  }

  void _viewStoreDetails(Map<String, dynamic> store) {
    print('Xem chi tiết của cửa hàng ${store['tenCH']}');
  }

  Widget _buildTitle() {
    return Text(
      'Digitalized Checker',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 18, 78, 128),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Tìm kiếm...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: const Color.fromARGB(255, 18, 78, 128)),
      ),
      style: TextStyle(color: Colors.black),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            setState(() {
              _isSearching = false;
            });
          },
        ),
      ];
    } else {
      return <Widget>[
        IconButton(
          icon:
              Icon(Icons.search, color: const Color.fromARGB(255, 18, 78, 128)),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
        ),
      ];
    }
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            color: Colors.white,
          ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Khu vực',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  dense: true,
                ),
                ListTile(
                  leading: Icon(
                    Icons.location_on,
                    color: Colors.blue,
                  ),
                  title: Text(
                    'Trong tuyến',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  onTap: () {
                    // Xử lý khi người dùng chọn lọc trong tuyến
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Ngoài tuyến',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  onTap: () {
                    // Xử lý khi người dùng chọn lọc ngoài tuyến
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
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
