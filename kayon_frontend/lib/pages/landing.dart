import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kayon_frontend/classes/colors.dart';
import 'package:kayon_frontend/components/background.dart';
import 'package:kayon_frontend/pages/Terms_page.dart';
import 'package:kayon_frontend/pages/catalog_page.dart';
import 'package:kayon_frontend/pages/contact_page.dart';
import 'package:kayon_frontend/pages/customer_space_page_login.dart';
import 'package:kayon_frontend/pages/discounts.dart';

import 'package:kayon_frontend/pages/geo.dart';
import 'package:kayon_frontend/pages/home.dart';
import 'package:kayon_frontend/pages/map_page.dart';
import 'package:kayon_frontend/pages/policy_page.dart';


class Landing extends StatefulWidget {
  const Landing({super.key, required this.title});
  final String title;

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _selectedIndex = 0;

  static TextStyle menuStyle = GoogleFonts.lexend(
    fontSize: 12,
    letterSpacing: 0.5,
    fontWeight: FontWeight.bold,
  );

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const DiscountPage(showAppbar:false),
    const CatalogPage(showAppbar:false),
    AddressMap(showAppbar:false),
    const CustomerPage(showAppbar:false),
    const ContactPage(showAppbar:false),
    const TermsPage(showAppbar:false),
    const PolicyPage(showAppbar:false),
  ];

  final List<Map<String, dynamic>> _menuItems = [
   {
      'title': 'Page Principale',
      'icon': Icons.home,
      'index': 0,
    }, {
      'title': 'Promotions',
      'icon': Icons.percent,
      'index': 1,
    },
    {
      'title': 'Nos Catalogues',
      'icon': Icons.menu_book_sharp,
      'index': 2,
    },
    {
      'title': 'Trouver nos magazins',
      'icon': Icons.location_on,
      'index': 3,
    },
    {
      'title': 'Espace fidelité',
      'icon': Icons.person,
      'index': 4,
    },
    {
      'title': 'Contactez-nous',
      'icon': Icons.contact_support,
      'index': 5,
    },
    {
      'title': 'T&Cs',
      'icon': Icons.document_scanner_sharp,
      'index': 6,
    },
    {
      'title': 'Politique de confidentialité',
      'icon': Icons.shield_moon_outlined,
      'index': 7,
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
      ),
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: size.height * 0.2,
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color(AppColors.orange_primary),
                  ),
                  child: Text(
                    widget.title,
                    style: GoogleFonts.lexend(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ..._menuItems.map((item) {
                return ListTile(
                  selectedColor: const Color(AppColors.orange_primary),
                  selected: _selectedIndex == item['index'],
                  onTap: () {
                    _onItemTapped(item['index']);
                    Navigator.pop(context);
                  },
                  title: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: Icon(item['icon'], size: 20),
                      ),
                      Text(
                        item['title'],
                        style: menuStyle,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            widget.title,
            style: GoogleFonts.lexend(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 0.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color(AppColors.orange_primary),
        ),
        body: size.width > 600
            ? NewBackground(
                child: Container(
                    alignment: Alignment.center,
                    child: Container(
                        alignment: Alignment.center,
                        width: size.width > 600 ? 600 : null,
                        constraints: BoxConstraints(maxWidth: 600),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red)),
                        child: _widgetOptions[_selectedIndex])),
              )
            : Container(child: _widgetOptions[_selectedIndex]),
      ),
    );
  }
}
