import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String setIcon = 'images/setter.png';

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
      //color: Colors.pink,
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
