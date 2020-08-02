# PickerWidget Example

Simple app to show/develop date time picker

## Getting Started

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
