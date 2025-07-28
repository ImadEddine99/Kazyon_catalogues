import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kayon_frontend/classes/Global_variables.dart';
import 'package:kayon_frontend/classes/colors.dart';
import 'package:kayon_frontend/components/background.dart';

class ContactPage extends StatefulWidget {final bool showAppbar;
  const ContactPage({ super.key , required this.showAppbar});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
    
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:!widget.showAppbar?null: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            "Contacts",
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
                        child:  Container(
        //   color: const Color(0xFFFFE306),
        // width: size.width,
        // height: size.height,
        child: Row(
                    children: [
                      const Icon(Icons.contact_support),
                      Text('Contacts',
                      style: Global_variables.optionStyle,),
                    ],
                  ),
        ),
      ),
    )):NewBackground(
                child: Container(
                    alignment: Alignment.center,
                    child: Container(
                        alignment: Alignment.center,
                        width: size.width > 600 ? 600 : null,
                        constraints: BoxConstraints(maxWidth: 600),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red)),
                        child:  Container(
        //   color: const Color(0xFFFFE306),
        // width: size.width,
        // height: size.height,
        child: Row(
                    children: [
                      const Icon(Icons.contact_support),
                      Text('Contacts',
                      style: Global_variables.optionStyle,),
                    ],
                  ),
        ),
      ),
    )));
  }
}