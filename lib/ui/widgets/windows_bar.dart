import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class WindowsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final windowsBarColor = Theme.of(context).primaryColor;
    final primaryColor = Theme.of(context).primaryColorLight;
    final primaryColor45 = Theme.of(context).accentTextTheme.subtitle1.color;
    final buttonColors = WindowButtonColors(
      iconNormal: primaryColor45,
      mouseOver: primaryColor,
      mouseDown: primaryColor45,
      iconMouseOver: primaryColor45,
      iconMouseDown: primaryColor,
    );

    final closeButtonColors = WindowButtonColors(
      mouseOver: Color(0xFFD32F2F),
      mouseDown: Color(0xFFB71C1C),
      iconNormal: primaryColor45,
      iconMouseOver: Colors.white,
    );
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      margin: EdgeInsets.zero,
      child: Container(
        height: kToolbarHeight,
        color: windowsBarColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: MoveWindow(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 15),
                  child: Text(
                    'Movie Search',
                    style: Theme.of(context).accentTextTheme.subtitle1,
                  ),
                ),
              ),
            ),
            MinimizeWindowButton(colors: buttonColors),
            MaximizeWindowButton(colors: buttonColors),
            CloseWindowButton(colors: closeButtonColors),
          ],
        ),
      ),
    );
  }
}
