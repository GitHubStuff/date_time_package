import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mode_theme/mode_theme.dart';

const String setIcon = 'images/setter.png';
ModeColor primaryColor = ModeColor(light: Color(0xffecf8f8), dark: Color(0xff230c33));
ModeColor dateColor = ModeColor(light: Color(0xffeee4e1), dark: Color(0xff290025));
ModeColor timeColor = ModeColor(light: Color(0xffe6beae), dark: Color(0xff4f0147));
ModeColor textColor = ModeColor(light: Colors.black87, dark: Colors.tealAccent);

get setterImage => Image(
      image: AssetImage(
        setIcon,
        package: 'date_time_package',
      ),
      key: Key('setIcon'),
    );

//get dateImage => IconData(59701, fontFamily: 'MaterialIcons');
get dateImage => Icon(
      IconData(59701, fontFamily: 'MaterialIcons'),
      size: 24.0,
      semanticLabel: 'Date Segment',
    );

const IconData _timeIconData =
    const IconData(0xf4be, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage);

//Icon(baseball);

get timeImage => Icon(
      _timeIconData,
      size: 24.0,
      semanticLabel: 'Time Segment',
    );
