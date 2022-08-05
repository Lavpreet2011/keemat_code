import 'package:flutter/material.dart';
import 'package:keemat_controller/Provider/themeProvider.dart';
import 'package:provider/provider.dart';

class ChangeThemeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return InkWell(
      onTap: () {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(!themeProvider.isDarkMode);
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset(
          'assets/images/' +
              (themeProvider.isDarkMode ? 'lightMode' : 'darkMode') +
              '.png',
          color: Theme.of(context).highlightColor,
          height: 18,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
