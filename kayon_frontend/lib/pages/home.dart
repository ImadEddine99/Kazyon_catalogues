import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kayon_frontend/classes/Global_variables.dart';
import 'package:kayon_frontend/components/background.dart';
import 'package:kayon_frontend/pages/Terms_page.dart';
import 'package:kayon_frontend/pages/catalog_page.dart';
import 'package:kayon_frontend/pages/contact_page.dart';
import 'package:kayon_frontend/pages/customer_space_page_login.dart';
import 'package:kayon_frontend/pages/discounts.dart';
import 'package:kayon_frontend/pages/find_friends.dart';
import 'package:kayon_frontend/pages/map_page.dart';

import 'policy_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({ super.key });

  @override
  State<HomePage> createState() => _HomePageState();
}
class Direction {
  String Name;
  Icon ico;
  Widget dir;
  // int number;
  

  Direction({
    required this.Name,
    required this.ico,
    required this.dir,
    
  });

  // factory Direction.fromJson(Map<String, dynamic> json) {
  //   return Direction(
  //     Name: json['name'],
  //     ico: json['ico'],
  //     dir: json['dir'] , 
      
  //   );
  // }
}

class _HomePageState extends State<HomePage> {
      List <Direction> dir_list = [
        Direction(Name: 'Promotions', ico: const Icon(Icons.percent, size: 70, color: Colors.white,), dir: const DiscountPage(showAppbar:true)),
        Direction(Name: 'Catalogues', ico:const Icon(Icons.menu_book_sharp, size: 70, color: Colors.white), dir: const CatalogPage(showAppbar:true)),
        Direction(Name: 'Magazins', ico: const Icon(Icons.location_on, size: 70, color: Colors.white), dir:  AddressMap(showAppbar:true)),
        Direction(Name: 'Fidelité', ico: const Icon(Icons.person, size: 70, color: Colors.white), dir: const CustomerPage(showAppbar:true)),
        Direction(Name: 'Contact', ico: const Icon(Icons.contact_support, size: 70, color: Colors.white), dir: const ContactPage(showAppbar:true)),
        Direction(Name: 'T&Cs', ico: const Icon(Icons.document_scanner_sharp, size: 70, color: Colors.white), dir: const TermsPage(showAppbar:true)),
        Direction(Name: 'Politique de confidentialité', ico: const Icon(Icons.shield_moon_outlined, size: 70, color: Colors.white), dir: const PolicyPage(showAppbar:true)),
       
      ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return NewBackground(
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context,constraints) {
            return Column(
              children: [
               
                 Expanded(
            child: Stack(
              // fit: StackFit.expand,
              children: [
         GridView.builder(
  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
    mainAxisExtent: 150,
    crossAxisCount: 2, // Two items per row
    crossAxisSpacing: 5.0, // Space between columns
    mainAxisSpacing: 1.0, // Space between rows
    childAspectRatio: 0.8, // Adjust the aspect ratio to accommodate image and text
  ),
  itemCount: dir_list.length,
  itemBuilder: (context, index) {

    final item = dir_list[index]; // Get the current catalog item
    // if (index %3 != 0 || index==0){    
  return  Container(
    // decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 2),)  ,
      padding: EdgeInsets.all(0),
    child: GestureDetector(
        onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: ((context) {
          return dir_list[index].dir;
        })));
          print(index);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center image and text
          children: [
            Container(
              margin: const EdgeInsets.all(0), // Optional margin
              decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2), // Optional border
              ),
              child: Container(
              margin: const EdgeInsets.all(0),
              child: item.ico,
              )
            ),
            // const SizedBox(height: 5), // Add spacing between image and text
            Text(
              item.Name, // Display the date range
              style: const TextStyle(fontSize: 15, color: Colors.white), // Adjust text size
              textAlign: TextAlign.center, // Center align the text
            ),
          ],
        ),
      ),
  );
 
  },
  shrinkWrap: true, // Ensures GridView fits the content height
  // physics: NeverScrollableScrollPhysics(), // Disable scrolling if wrapped in another scrollable widget
),

        // SizedBox(height: 100,)  
             ],
            ),
            ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: size.width,
                    height: 40,
                    color: Colors.grey,
                    child: const Center(
                      child: Text("ADS"),
                    ),
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}