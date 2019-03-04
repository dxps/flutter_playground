import 'package:flutter/material.dart';

import 'screens/calculate_distance_scr.dart';
import 'screens/current_location_scr.dart';
import 'screens/location_stream_scr.dart';

void main() => runApp(GeolocatorExampleApp());

enum TabItem { singleLocation, locationStream, distance }

///
///
///
class GeolocatorExampleApp extends StatefulWidget {
  //

  @override
  State<GeolocatorExampleApp> createState() => BottomNavigationState();

  //
}

///
class BottomNavigationState extends State<GeolocatorExampleApp> {
  //

  TabItem _currentItem = TabItem.singleLocation;

  @override
  Widget build(BuildContext context) {
    //
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Geolocator Example App'),
        ),
        body: _buildBody(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
    //
  }

  Widget _buildBody() {
    //
    switch (_currentItem) {
      case TabItem.locationStream:
        return LocationStreamScreen();
      case TabItem.distance:
        return CalculateDistanceScreen();
      case TabItem.singleLocation:
      default:
        return CurrentLocationScreen();
    }
    //
  }

  Widget _buildBottomNavigationBar() {
    //
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        _buildBottomNavigationBarItem(Icons.location_on, TabItem.singleLocation),
        _buildBottomNavigationBarItem(Icons.clear_all, TabItem.locationStream),
        _buildBottomNavigationBarItem(Icons.redo, TabItem.distance),
      ],
      onTap: _onSelectTab,
    );
    //
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(IconData icon, TabItem tabItem) {
    //
    final String text = tabItem.toString().split('.').last;
    final Color color = _currentItem == tabItem ? Theme.of(context).primaryColor : Colors.grey;

    return BottomNavigationBarItem(
      icon: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
    );
    //
  }

  void _onSelectTab(int index) {
    //
    TabItem selectedTabItem;

    switch (index) {
      case 1:
        selectedTabItem = TabItem.locationStream;
        break;
      case 2:
        selectedTabItem = TabItem.distance;
        break;
      default:
        selectedTabItem = TabItem.singleLocation;
    }

    setState(() {
      _currentItem = selectedTabItem;
    });
    //
  }

  //
}
