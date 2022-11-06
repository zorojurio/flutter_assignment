import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => HomePage(),
  );
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData media;
    media = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Height: ${media.size.height}'),
            Text('Width: ${media.size.width}'),
            Text('Device Pixel Ratio: ${media.devicePixelRatio}'),
            Text('Scale Factor: ${MediaQuery.textScaleFactorOf(context)}'),
            Text('Brightness: ${MediaQuery.platformBrightnessOf(context)}'),
            Text('System View Insets: ${media.viewInsets}'),
            Text('System Padding: ${media.padding}'),
            Text('System View Padding: ${media.viewPadding}'),
            Text('System Gesture Insets: ${media.systemGestureInsets}'),
            Text('Always 24 Hours: ${media.alwaysUse24HourFormat}'),
            Text('Accessible Navigation: ${media.accessibleNavigation}'),
            Text('Inverting Colors: ${media.invertColors}'),
            Text('In High Contrast: ${MediaQuery.highContrastOf(context)}'),
            Text('Disable Animation: ${media.disableAnimations}'),
            Text('In Bold Text: ${MediaQuery.boldTextOverride(context)}'),
            Text('Navigation Mode: ${media.navigationMode}'),
            Text('Orientation: ${media.orientation}'),
          ],

        ),
      ),
    );
  }
}