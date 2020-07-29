import 'package:date_time_package/date_time_package.dart';

import '../modules/initial_module.dart';
import '../resources/app_localizations.dart';
import '../resources/widgets/theme_icon_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mode_theme/mode_theme.dart';

class InitialScreen extends ModularStatelessWidget<InitialModule> {
  @override
  Widget build(BuildContext context) {
    return _scaffold(context);
  }

  Widget _scaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: ThemeIconWidget(),
            onPressed: () {
              ModeTheme.of(context).toggleBrightness();
            },
          )
        ],
        title: Text(tr(context, 'Title')),
      ),
      body: _InitialWidget(), // body(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        tooltip: 'NoOp',
        child: Icon(Icons.add),
      ),
    );
  }
}

//MARK:
class _InitialWidget extends StatelessWidget {
  GlobalKey _containerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return buttonWidget(context);
    //return Center(child: DateTimePickerWidget());
  }

  Widget buttonWidget(BuildContext context) {
    return RaisedButton(
      key: _containerKey,
      onPressed: () {
        DateTimePopoverWidget(context: context)..show(widgetKey: _containerKey);
      },
      child: Text('Bleh', style: TextStyle(fontSize: 24.0)),
    );
  }
}
