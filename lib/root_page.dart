import 'package:flutter/material.dart';
import 'package:login/auth.dart';
import 'package:login/login_page.dart';
import 'package:login/home_page.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:login/placeholder_widget.dart';

class RootPage extends StatefulWidget {
  RootPage({Key key, this.auth, Position currPos}) : super(key: key);
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {

  Position _position;
  AuthStatus authStatus = AuthStatus.notSignedIn;

  initState() {
    super.initState();
    _initPlatformState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus = userId != null ? AuthStatus.signedIn : AuthStatus.notSignedIn;
      });
    });
  }

  void _updateAuthStatus(AuthStatus status) {
    setState(() {
      authStatus = status;
    });
  }

  //void initState() {
  //  super.initState();
  //  _initPlatformState();
  //}

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initPlatformState() async {
    Position position;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final Geolocator geolocator = Geolocator()
        ..forceAndroidLocationManager = true;
      position = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
    } on PlatformException {
      position = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      _position = position;
    });

    //while(_position.latitude == 0 || _position.longitude == 0);
  }



  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginPage(
          title: 'HobbyHelper Login',
          auth: widget.auth,
          onSignIn: () => _updateAuthStatus(AuthStatus.signedIn),
            //currPos:_position
        );
      case AuthStatus.signedIn:
        return FutureBuilder<GeolocationStatus>(
            future: Geolocator().checkGeolocationPermissionStatus(),
            builder:
                (BuildContext context, AsyncSnapshot<GeolocationStatus> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              else if (snapshot.data == GeolocationStatus.disabled) {
                return const PlaceholderWidget('Location services disabled',
                    'Enable location services for this App using the device settings.');
              }

              else if (snapshot.data == GeolocationStatus.denied) {
                return const PlaceholderWidget('Access to location denied',
                    'Allow access to the location services for this App using the device settings.');
              }

              else if (_position.latitude != null) {
                return new HomePage(
                    auth: widget.auth,
                    onSignOut: () => _updateAuthStatus(AuthStatus.notSignedIn),
                    currPos: _position
                );
              }
            });

    }
  }
}