# SQLite flutter project template

A Flutter baseline project with SQLite development classes/tools/templates.

## Getting Started

- Can display SQLite table info an excute queries
- Uses BLoC design
- Build Flavors of DEVICE, EMULATOR, RELEASE, TEST
- Flutter Module to allow for re-use of components
- Localization

### BLoC

Each BLoC should have BLoC, Event, and State class. <i>EX: initial_event.dart, initial_bloc.dart, initial_state.dart</i>

### Flavors

FlavorValues in <i>flavor_config.dart</i> is modified to include all values that a unique to a flavor (eg URL's, constants,...) and is created by each <i>main_*.dart</i> file, to be available to throughout the project.
<b>NOTE:</b> <i>launch.json</i> contains the required launch information for each flavor.
<b>Template of <i>launch.json</i>:</b>
<pre>
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Device",
      "request": "launch",
      "program": "lib/main/main_device.dart",
      "type": "dart"
    },
    {
      "name": "Emulator",
      "type": "dart",
      "request": "launch",
      "program": "lib/main/main_emulator.dart"
    },
    {
      "name": "Release",
      "type": "dart",
      "request": "launch",
      "program": "lib/main/main_release.dart"
    },
    {
      "name": "Test",
      "type": "dart",
      "request": "launch",
      "program": "lib/main/main_test.dart"
    },
  ]
}
</pre>

### Modules

<i>app_bloc.dart</i> part of module housekeeping
<i>app_module.dart</i> All the bindings and routes
<i>app_widget.dart</i>  BLoC providers, Light/Dark mode color schemes, material_app, localizations.
<b>GATEWAY</b> Screen widget

### Localization
1) Create a folder "languages"
2) Create a file using the first two(2) letters of a locale code (EX: en.json for English, es.json for Spanish) that contains key/value pairs of translation.

Any place a translation is needed wrap the key in <i>tr(context, "key")</i> to get the translated text.

#### Extended files

<pre>
initial_bloc.dart
initial_event.dart
initial_state.dart
</pre>
This is the initial BLoC pattern for the <i>initial_screen.dart</i>

<pre>
import '../resources/constants.dart' as Constants;
</pre>
Add constant values to this file for items (Images, Values, etc) here. The default contains the inital route "/", and icon (lightbulb) for dark/light mode
<pre>
app_module.dart
</pre>
Add <i>Binds</i> for BLoC(s) and Routes.
