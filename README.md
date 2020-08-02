# date_time_package

## Getting Started

Allows a field to host a popover that allows for selection Date/Time

## Steps
1 - Create GlobalKey that will be added to the widget that 'Hosts' the popover

2 - Create and instance of <i>DateTimePopoverWidget()</i> passing a context and <i>Function(DateTimeEvent dateTimeEvent)</i> that

3 - Call <i><b>show(widgetKey:  {globalkey});</b></i> to display the popover

# See Example

## Usage

<pre>

final GlobalKey _containerKey = GlobalKey();

Widget buttonWidget(BuildContext context) {
    return RaisedButton(
      key: _containerKey,
      onPressed: () {
        DateTimePopoverWidget(
          context: context,
          resultCallback: (dateTimeEvent) {
            print('${dateTimeEvent.toString()}');
          },
        )..show(widgetKey: _containerKey);
      },
      child: Text('Bleh', style: TextStyle(fontSize: 24.0)),
    );
  }
</pre>

### DateTimeEvent
Class that wraps all information about the DateTime that was created by the popover. The most used/important is <i>dateTime</i> that is resulting DateTime.
#### NOTE: tap outside the widget dismisses the popover and the callback is not called.

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
