import 'package:flutter/material.dart';
import 'dart:math';

class SetAppTheme extends StatelessWidget {

  final Widget child;

  SetAppTheme({this.child});

  @override
  Widget build(BuildContext context) {

    final _divisor = 400.0;

    final MediaQueryData _mediaQueryData = MediaQuery.of(context);

    final _screenWidth = _mediaQueryData.size.width;
    final _factorHorizontal = _screenWidth / _divisor;

    final _screenHeight = _mediaQueryData.size.height;
    final _factorVertical = _screenHeight / _divisor;

    final _textScalingFactor = min(_factorVertical, _factorHorizontal);

    final _safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    final _safeFactorHorizontal = (_screenWidth - _safeAreaHorizontal) / _divisor;

    final _safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    final _safeFactorVertical = (_screenHeight - _safeAreaVertical) / _divisor;

    final _safeAreaTextScalingFactor = min(_safeFactorHorizontal, _safeFactorHorizontal);

    print('Screen Scaling Values:' + '_screenWidth: $_screenWidth');
    print('Screen Scaling Values:' + '_factorHorizontal: $_factorHorizontal ');

    print('Screen Scaling Values:' + '_screenHeight: $_screenHeight');
    print('Screen Scaling Values:' + '_factorVertical: $_factorVertical ');

    print('_textScalingFactor: $_textScalingFactor ');

    print('Screen Scaling Values:' + '_safeAreaHorizontal: $_safeAreaHorizontal ');
    print('Screen Scaling Values:' + '_safeFactorHorizontal: $_safeFactorHorizontal ');

    print('Screen Scaling Values:' + '_safeAreaVertical: $_safeAreaVertical ');
    print('Screen Scaling Values:' + '_safeFactorVertical: $_safeFactorVertical ');

    print('_safeAreaTextScalingFactor: $_safeAreaTextScalingFactor ');

    print('Default Material Design Text Themes');
    print('display4: ${Theme.of(context).textTheme.display4}');
    print('display3: ${Theme.of(context).textTheme.display3}');
    print('display2: ${Theme.of(context).textTheme.display2}');
    print('display1: ${Theme.of(context).textTheme.display1}');
    print('headline: ${Theme.of(context).textTheme.headline}');
    print('title: ${Theme.of(context).textTheme.title}');
    print('subtitle: ${Theme.of(context).textTheme.subtitle}');
    print('body2: ${Theme.of(context).textTheme.body2}');
    print('body1: ${Theme.of(context).textTheme.body1}');
    print('caption: ${Theme.of(context).textTheme.caption}');
    print('button: ${Theme.of(context).textTheme.button}');

    TextScalingFactors _textScalingFactors = TextScalingFactors(
        display4ScaledSize: (Theme.of(context).textTheme.display4.fontSize * _safeAreaTextScalingFactor),
        display3ScaledSize: (Theme.of(context).textTheme.display3.fontSize * _safeAreaTextScalingFactor),
        display2ScaledSize: (Theme.of(context).textTheme.display2.fontSize * _safeAreaTextScalingFactor),
        display1ScaledSize: (Theme.of(context).textTheme.display1.fontSize * _safeAreaTextScalingFactor),
        headlineScaledSize: (Theme.of(context).textTheme.headline.fontSize * _safeAreaTextScalingFactor),
        titleScaledSize: (Theme.of(context).textTheme.title.fontSize * _safeAreaTextScalingFactor),
        subtitleScaledSize: (Theme.of(context).textTheme.subtitle.fontSize * _safeAreaTextScalingFactor),
        body2ScaledSize: (Theme.of(context).textTheme.body2.fontSize * _safeAreaTextScalingFactor),
        body1ScaledSize: (Theme.of(context).textTheme.body1.fontSize * _safeAreaTextScalingFactor),
        captionScaledSize: (Theme.of(context).textTheme.caption.fontSize * _safeAreaTextScalingFactor),
        buttonScaledSize: (Theme.of(context).textTheme.button.fontSize * _safeAreaTextScalingFactor));

    return Theme(
      child: child,
      data: _buildAppTheme(_textScalingFactors),
    );
  }
}

final ThemeData customTheme = ThemeData(
  primarySwatch: appColorSwatch,
  // fontFamily: x,
);

final MaterialColor appColorSwatch = MaterialColor(0xFF3787AD, appSwatchColors);

Map<int, Color> appSwatchColors =
{
  50  : Color(0xFFE3F5F8),
  100 : Color(0xFFB8E4ED),
  200 : Color(0xFF8DD3E3),
  300 : Color(0xFF6BC1D8),
  400 : Color(0xFF56B4D2),
  500 : Color(0xFF48A8CD),
  600 : Color(0xFF419ABF),
  700 : Color(0xFF3787AD),
  800 : Color(0xFF337799),
  900 : Color(0xFF285877),
};

_buildAppTheme (TextScalingFactors textScalingFactors) {

  return customTheme.copyWith(

    accentColor: appColorSwatch[300],
    buttonTheme: customTheme.buttonTheme.copyWith(buttonColor: Colors.grey[500],),
    cardColor: Colors.white,
    errorColor: Colors.red,
    inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder(),),
    primaryColor: appColorSwatch[700],
    primaryIconTheme: customTheme.iconTheme.copyWith(color: appColorSwatch),
    scaffoldBackgroundColor: Colors.grey[100],
    textSelectionColor: appColorSwatch[300],
    textTheme: _buildAppTextTheme(customTheme.textTheme, textScalingFactors),
    appBarTheme: customTheme.appBarTheme.copyWith(
        textTheme: _buildAppTextTheme(customTheme.textTheme, textScalingFactors)),

//    accentColorBrightness: ,
//    accentIconTheme: ,
//    accentTextTheme: ,
//    appBarTheme: ,
//    applyElevationOverlayColor: ,
//    backgroundColor: ,
//    bannerTheme: ,
//    bottomAppBarColor: ,
//    bottomAppBarTheme: ,
//    bottomSheetTheme: ,
//    brightness: ,
//    buttonBarTheme: ,
//    buttonColor: ,
//    canvasColor: ,
//    cardTheme: ,
//    chipTheme: ,
//    colorScheme: ,
//    cupertinoOverrideTheme: ,
//    cursorColor: ,
//    dialogBackgroundColor: ,
//    dialogTheme: ,
//    disabledColor: ,
//    dividerColor: ,
//    dividerTheme: ,
//    floatingActionButtonTheme: ,
//    focusColor: ,
//    highlightColor: ,
//    hintColor: ,
//    hoverColor: ,
//    iconTheme: ,
//    indicatorColor: ,
//    materialTapTargetSize: ,
//    pageTransitionsTheme: ,
//    platform: ,
//    popupMenuTheme: ,
//    primaryColorBrightness: ,
//    primaryColorDark: ,
//    primaryColorLight: ,
//    primaryTextTheme: ,
//    secondaryHeaderColor: ,
//    selectedRowColor: ,
//    sliderTheme: ,
//    snackBarTheme: ,
//    splashColor: ,
//    splashFactory: ,
//    tabBarTheme: ,
//    textSelectionHandleColor: ,
//    toggleableActiveColor: ,
//    toggleButtonsTheme: ,
//    tooltipTheme: ,
//    typography: ,
//    unselectedWidgetColor: ,
  );
}

class TextScalingFactors {

  final double display4ScaledSize;
  final double display3ScaledSize;
  final double display2ScaledSize;
  final double display1ScaledSize;
  final double headlineScaledSize;
  final double titleScaledSize;
  final double subtitleScaledSize;
  final double body2ScaledSize;
  final double body1ScaledSize;
  final double captionScaledSize;
  final double buttonScaledSize;

  TextScalingFactors({

    @required this.display4ScaledSize,
    @required this.display3ScaledSize,
    @required this.display2ScaledSize,
    @required this.display1ScaledSize,
    @required this.headlineScaledSize,
    @required this.titleScaledSize,
    @required this.subtitleScaledSize,
    @required this.body2ScaledSize,
    @required this.body1ScaledSize,
    @required this.captionScaledSize,
    @required this.buttonScaledSize
  });
}

TextTheme _buildAppTextTheme(

    TextTheme _customTextTheme,
    TextScalingFactors _scaledText) {

  return _customTextTheme.copyWith(

    display4: _customTextTheme.display4.copyWith(fontSize: _scaledText.display4ScaledSize),
    display3: _customTextTheme.display3.copyWith(fontSize: _scaledText.display3ScaledSize),
    display2: _customTextTheme.display2.copyWith(fontSize: _scaledText.display2ScaledSize),
    display1: _customTextTheme.display1.copyWith(fontSize: _scaledText.display1ScaledSize),
    headline: _customTextTheme.headline.copyWith(fontSize: _scaledText.headlineScaledSize),
    title: _customTextTheme.title.copyWith(fontSize: _scaledText.titleScaledSize),
    subtitle: _customTextTheme.subtitle.copyWith(fontSize: _scaledText.subtitleScaledSize),
    body2: _customTextTheme.body2.copyWith(fontSize: _scaledText.body2ScaledSize),
    body1: _customTextTheme.body1.copyWith(fontSize: _scaledText.body1ScaledSize),
    caption: _customTextTheme.caption.copyWith(fontSize: _scaledText.captionScaledSize),
    button: _customTextTheme.button.copyWith(fontSize: _scaledText.buttonScaledSize),

  ).apply(bodyColor: Colors.black);
}