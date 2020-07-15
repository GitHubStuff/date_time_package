import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mode_theme/mode_theme.dart';
import 'package:sqlite_explorer/sqlite_explorer.dart';
import 'package:sqlite_controller/sqlite_controller.dart' as SQL;
import 'package:tracers/tracers.dart' as Log;

import '../flavor_config.dart';
import '../modules/initial_screen.dart';
import 'logging_bloc_delegate.dart';
import '../resources/constants.dart' as Constants;
import '../resources/app_localizations.dart';
import '../bloc_providers/bloc/initial_bloc.dart';

class AppWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (!Foundation.kReleaseMode) {
      Bloc.observer = LoggingBlocObserver();
    }
    return _blocProviders(context);
  }

  Widget _blocProviders(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InitialBloc>(create: (context) {
          final servicesBloc = Modular.get<InitialBloc>();
          return servicesBloc;
        }),
      ],
      child: _modeTheme(context),
    );
  }

  ModeTheme _modeTheme(BuildContext context) {
    return ModeTheme(
      themeDataFunction: (brightness) {
        // buttonModeColor
        // cardColor
        // contrastColors
        // dialogModeColor
        // disabledColor
        // iconBrightness
        // iconColors
        // primaryModeColor
        // productModeColor
        // scaffoldColors

        return (brightness == Brightness.light) ? ModeTheme.light : ModeTheme.dark;
      },
      defaultBrightness: Brightness.dark,
      themedWidgetBuilder: (context, theme) {
        return _materialApp(context, theme);
      },
    );
  }

  Widget _materialApp(BuildContext context, ThemeData themeData) {
    if (FlavorConfig.instance.values.sqliteDatabaseName == null) {
      final message = 'Set "sqliteDatabaseName" to a non-null string for ${FlavorConfig.instance.flavor.toString()}';
      Log.c(message);
      throw FlutterError(message);
    }
    if (FlavorConfig.instance.values.sqliteDevelopment == null) {
      final message = 'Set "sqliteDevelopment" to a non-null boolean for ${FlavorConfig.instance.flavor.toString()}';
      Log.c(message);
      throw FlutterError(message);
    }

    return MaterialApp(
      home: SqliteScreenWidget(
        childWidget: InitialScreen(),
        sqliteIdentity: SQL.SQLiteIdentity(databaseName: FlavorConfig.instance.values.sqliteDatabaseName),
        enabled: FlavorConfig.instance.values.sqliteDevelopment,
      ),
      title: '...',
      theme: themeData,
      initialRoute: Constants.initalRoute,
      onGenerateRoute: Modular.generateRoute,
      navigatorKey: Modular.navigatorKey,
      supportedLocales: [
        Locale('en'),
        Locale('es'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
