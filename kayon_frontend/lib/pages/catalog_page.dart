import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kayon_frontend/classes/Global_variables.dart';
import 'package:kayon_frontend/classes/colors.dart';
import 'package:kayon_frontend/components/background.dart';
import 'package:intl/intl.dart';
import 'package:kayon_frontend/pages/catalog_view_page.dart';


class CatalogPage extends StatefulWidget {final bool showAppbar;
  const CatalogPage({super.key, required this.showAppbar});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}
class Catalog {
  int id;
  String imageLink;
  // int number;
  int salesPeriod;
  String? startDate;
  String? endDate;
  DateTime? createdAt;

  Catalog({
    required this.id,
    required this.imageLink,
    // required this.number,
    required this.startDate,
    required this.endDate,
    required this.salesPeriod,
    this.createdAt,
  });

  factory Catalog.fromJson(Map<String, dynamic> json) {
    return Catalog(
      id: json['id'],
      imageLink: json['image_link'],
      // number: json['number'] ?? 0, 
      salesPeriod: json['sales_period'] ?? 0, 
     startDate: json['startDate'] != null
          ?DateFormat('dd/MM/yyyy').format(DateTime.parse(json['startDate'])).toString()
          : null,
      endDate: json['endDate'] != null
          ? DateFormat('dd/MM/yyyy').format(DateTime.parse(json['endDate'])).toString()
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }
}

class _CatalogPageState extends State<CatalogPage> {
   List <Catalog> Catalog_images_list = [
        Catalog.fromJson({
          "id":1,
          "image_link":"https://picsum.photos/id/237/400/300",
          "startDate":"2024-10-22 17:40:51.981164+02",
          "endDate":"2024-10-22 17:40:51.981164+02",
          "sales_period":1,
          "created_at":"2024-10-22 17:40:51.981164+02",
        }),
        Catalog.fromJson({
          "id":2,
          "image_link":"https://picsum.photos/id/234/200/300",
          "startDate":"2024-10-22 17:40:51.981164+02",
          "endDate":"2024-10-22 17:40:51.981164+02",
          "sales_period":1,
          "created_at":"2024-10-22 17:40:51.981164+02",
        }),
        Catalog.fromJson({
          "id":3,
          "image_link":"https://picsum.photos/id/235/200/300",
          "startDate":"2024-10-22 17:40:51.981164+02",
          "endDate":"2024-10-22 17:40:51.981164+02",
          "sales_period":1,
          "created_at":"2024-10-22 17:40:51.981164+02",
        }),
        Catalog.fromJson({
          "id":3,
          "image_link":"https://picsum.photos/id/236/200/300",
          "startDate":"2024-10-22 17:40:51.981164+02",
          "endDate":"2024-10-22 17:40:51.981164+02",
          "sales_period":1,
          "created_at":"2024-10-22 17:40:51.981164+02",
        }),
      ];

 @override
  void initState() {
   initializeDateFormatting('fr_FR', null);
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:!widget.showAppbar?null: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            "Catalogues",
            style: GoogleFonts.lexend(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 0.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color(AppColors.orange_primary),
        ),
      body: 
       size.width > 600
            ? NewBackground(
                child: Container(
                    alignment: Alignment.center,
                    child: Container(
                        alignment: Alignment.center,
                        width: size.width > 600 ? 600 : null,
                        constraints: BoxConstraints(maxWidth: 600),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red)),
                        child:NewBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context,constraints) {
              return Expanded(
                child: Column(
                  children: [
                    // Row(
                    //   children: [
                    //     const Icon(Icons.menu_book_sharp),
                    //     Text(
                    //       'Catalogs',
                    //       style: Global_variables.optionStyle,
                    //     ),
                    //   ],
                    // ),
                     Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
           GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, // Two items per row
      crossAxisSpacing: 10.0, // Space between columns
      mainAxisSpacing: 10.0, // Space between rows
      childAspectRatio: 0.8, // Adjust the aspect ratio to accommodate image and text
      ),
      itemCount: Catalog_images_list.length,
      itemBuilder: (context, index) {
    
      final item = Catalog_images_list[index]; // Get the current catalog item
      if (index %3 != 0 || index==0)
    {    return  GestureDetector(
        onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: ((context) {
          return CatalogCarouselPage(id:index);
        })));
          print(index);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center image and text
          children: [
            Container(
              margin: const EdgeInsets.all(5), // Optional margin
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2), // Optional border
              ),
              child:  Image.asset(
                'images/page_16.jpg',
                // width: double.infinity, // Let it take full width of the container
                // height: 120, // Adjust height as needed
                fit: BoxFit.fill, // Fit image within its container
              ),
            ),
            const SizedBox(height: 5), // Add spacing between image and text
            Text(
              "Du ${item.startDate} au ${item.endDate}", // Display the date range
              style: const TextStyle(fontSize: 12), // Adjust text size
              textAlign: TextAlign.center, // Center align the text
            ),
          ],
        ),
      );
      }
      else{
      return GestureDetector(
        onTap: () {
          print("ads: ${index %3}");
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center image and text
            children: [
              Container(alignment: Alignment.center,
                margin: const EdgeInsets.all(5), // Optional margin
                height: 218,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2), // Optional border
                  color: Color(AppColors.orange_light)
                ),
               child:const Text(
              "ADS",textAlign: TextAlign.center,
            ),
              ),
            ],
          ),
      );
      }
      },
      shrinkWrap: true, // Ensures GridView fits the content height
      // physics: NeverScrollableScrollPhysics(), // Disable scrolling if wrapped in another scrollable widget
    ),
    
          SizedBox(height: 100,)       ],
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
                ),
              );
            }
          ),
        ),
      ),)
    )): NewBackground(
                child: Container(
                    alignment: Alignment.center,
                    child: Container(
                        alignment: Alignment.center,
                        width: size.width > 600 ? 600 : null,
                        constraints: BoxConstraints(maxWidth: 600),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red)),
                        child:NewBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context,constraints) {
              return Expanded(
                child: Column(
                  children: [
                     Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
           GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, // Two items per row
      crossAxisSpacing: 10.0, // Space between columns
      mainAxisSpacing: 10.0, // Space between rows
      childAspectRatio: 0.8, // Adjust the aspect ratio to accommodate image and text
      ),
      itemCount: Catalog_images_list.length,
      itemBuilder: (context, index) {
    
      final item = Catalog_images_list[index]; // Get the current catalog item
      if (index %3 != 0 || index==0)
    {    return  GestureDetector(
        onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: ((context) {
          return CatalogCarouselPage(id:index);
        })));
          print(index);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center image and text
          children: [
            Container(
              margin: const EdgeInsets.all(5), // Optional margin
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2), // Optional border
              ),
              child:  Image.asset(
                'images/page_16.jpg',
                // width: double.infinity, // Let it take full width of the container
                // height: 120, // Adjust height as needed
                fit: BoxFit.fill, // Fit image within its container
              ),
            ),
            const SizedBox(height: 5), // Add spacing between image and text
            Text(
              "Du ${item.startDate} au ${item.endDate}", // Display the date range
              style: const TextStyle(fontSize: 12), // Adjust text size
              textAlign: TextAlign.center, // Center align the text
            ),
          ],
        ),
      );
      }
      else{
      return GestureDetector(
        onTap: () {
          print("ads: ${index %3}");
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center image and text
            children: [
              Container(alignment: Alignment.center,
                margin: const EdgeInsets.all(5), // Optional margin
                height: 218,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2), // Optional border
                  color: Color(AppColors.orange_light)
                ),
               child:const Text(
              "ADS",textAlign: TextAlign.center,
            ),
              ),
            ],
          ),
      );
      }
      },
      shrinkWrap: true, // Ensures GridView fits the content height
      // physics: NeverScrollableScrollPhysics(), // Disable scrolling if wrapped in another scrollable widget
    ),
    
          SizedBox(height: 100,)       ],
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
                ),
              );
            }
          ),
        ),
      ),)
    )));
  }

}