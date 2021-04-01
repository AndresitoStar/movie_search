import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class WindowsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).hintColor;
    final primaryColor45 = Theme.of(context).accentColor.withOpacity(0.45);
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: WindowTitleBarBox(
                child: MoveWindow(
                  child: ListTile(
                    title: Text(
                      'Buscador de Peliculas y Series',
                      style: TextStyle(color: Colors.grey),
                    ),
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
