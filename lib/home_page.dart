import 'package:flutter/material.dart';
import 'package:login/auth.dart';
import 'package:login/root_page.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:login/page.dart';
import 'package:login/optionspage.dart';
import 'package:login/messagespage.dart';
import 'package:login/placeholder_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignOut, this.currPos});
  final BaseAuth auth;
  final VoidCallback onSignOut;
  final Position currPos;

  @override
  Widget build(BuildContext context) {

    void _signOut() async {
      try {
        await auth.signOut();
        onSignOut();
      } catch (e) {
        print(e);
      }

    }

    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          new FlatButton(
              onPressed: _signOut,
              child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white))
          )
        ],
      ),
      //body: new Center(
        //child: new Text(
          //currPos.longitude.toString(),
          //style: new TextStyle(fontSize: 32.0),
        //),
      //)
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountEmail: new Text("hjime008@ucr.edu"),
              accountName: new Text("Hector Jimenez"),
              //accountName: new Text(_testlogin.username),//write getter function
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  //backgroundImage: new NetworkImage(currentProfilePic),
                  backgroundColor: Colors.brown.shade800,
                  child: Text('HJ'),
                ),
                onTap: () => print("This is your current account."),
              ),
              decoration: new BoxDecoration(
                //image: new DecorationImage(
                //image: new NetworkImage("https://img00.deviantart.net/35f0/i/2015/018/2/6/low_poly_landscape__the_river_cut_by_bv_designs-d8eib00.jpg"),
                //fit: BoxFit.fill
                //
                color: const Color(0xff6c94b6),
              ),
            ),
            new ListTile(
                title: new Text("Rent a space"),
                trailing: new Icon(Icons.calendar_today),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new Page("Rent a space")));
                }),
            new ListTile(
                title: new Text("Filters"),
                trailing: new Icon(Icons.toc),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new OptionsPage("Filters")));
                }),
            new ListTile(
                title: new Text("Messages"),
                trailing: new Icon(Icons.message),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new MessagesPage("Messages")));
                }),
            new Divider(),
            //new ListTile(
            //  title: new Text("Sign Out"),
            //  trailing: new Icon(Icons.cancel),
            //  onTap: () => Navigator.pop(context),
            //),
          ],
        ),
      ),


      body: new FlutterMap(
        options: new MapOptions(
          center: //new LatLng(
//33.975034, -117.326006),
          new LatLng(
              currPos.latitude, currPos.longitude),
          zoom: 18.0,
        ),
        layers: [
          new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                width: 30.0,
                height: 30.0,
                point: new LatLng(33.974482, -117.324441),
                builder: (ctx) => new Container(
                  child: new Icon(Icons.pin_drop),
                ),
              ),
            ],
          ),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                width: 30.0,
                height: 30.0,
                point: new LatLng(currPos.latitude, currPos.longitude),
                builder: (ctx) => new Container(
                  child: Icon(Icons.my_location),
                ),
              ),
            ],
          ),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                width: 30.0,
                height: 30.0,
                point: new LatLng(33.975066, -117.326609),
                builder: (ctx) => new Container(
                  child: new Icon(Icons.pin_drop),
                ),
              ),
            ],
          ),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                width: 30.0,
                height: 30.0,
                point: new LatLng(33.978293, -117.327754),
                builder: (ctx) => new Container(
                  child: new Icon(Icons.pin_drop),
                ),
              ),
            ],
          ),
        ],
      ),


    );
  }
}

