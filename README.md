# date_time_package

## Getting Started

Allows a field to host a popover that allows for selection Date/Time

## Steps

1 - The widget relies on flutter_module [https://pub.dev/packages/flutter_modular], so the host project must include <i>PickerModularBloc</i> in the module that extends <b>MainModule</b>:
<pre>
class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppBloc()),
        Bind((i) => PickerModularBloc()), /// <*** INCLUDED HERE
      ];

  @override
  List<Router> get routers => [
        :
      ];

  @override
  Widget get bootstrap => AppWidget();
}
</pre>

2 - Create GlobalKey that will be added to the widget that 'Hosts' the popover

3 - Create and instance of <i>DateTimePopoverWidget()</i> passing a context and <i>Function(DateTimeEvent dateTimeEvent)</i> that

4 - Call <i><b>show(widgetKey:  {globalkey});</b></i> to display the popover

# See Example

## Usage

<pre>

/// - Set PickerModularBloc() in MainModule (see above)
  :
  :
final GlobalKey _containerKey = GlobalKey();

Widget buttonWidget(BuildContext context) {
    return RaisedButton(
      key: _containerKey,
      onPressed: () {
        DateTimePopoverWidget(
          context: context,
          initialDateTime: DateTime(2019, 1, 2, 16, 27, 30, 0, 0),  // null => DateTime.now()
          dismissCallback: (){
            // Called if popover dismissed
            print('User tapped out/dismissed');
          }

          resultCallback: (DateTimeEvent dateTimeEvent) {
            print('${dateTimeEvent.toString()}');
          },
        )..show(widgetKey: _containerKey);
      },
      child: Text('Pick Date/Time', style: TextStyle(fontSize: 24.0)),
    );
  }
</pre>

### DateTimeEvent
Class that wraps all information about the DateTime that was created by the popover. The most used/important is <i>dateTime</i> that is resulting DateTime.
#### NOTE: tap outside the widget dismisses the popover and the callback is not called.

##### DateTimeEvent user properties

<pre>
DateTime dateTime
String formatted  - a 'pretty print' of the dateTime
String formattedTime - a 'pretty print' of the time
String formattedDate - a 'pretty print' of the date
bool isLeapYear
String months - a 'pretty print' of the month as text using ISO 'MMM' format string
String hours - a 'pretty print' of the 12-hour bounded time
String meridian - a 'pretty print' of the meridian (am/pm)
Meridian meridianEnum - meridian: Meridian.AM or Meridian.PM

</pre>
