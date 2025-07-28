import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kayon_frontend/classes/Global_variables.dart';
import 'package:kayon_frontend/classes/colors.dart';
import 'package:kayon_frontend/components/background.dart';

class DiscountPage extends StatefulWidget {
 final bool showAppbar;

  const DiscountPage({ super.key, required this.showAppbar});

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class Promo_image{
  int id;
  String image_link;
  int number;
  int sales_period;DateTime? createdAt;

  Promo_image({
    required this.id,
    required this.image_link,
    required this.number,
    required this.sales_period,required this.createdAt,
  });
  factory Promo_image.fromJson(Map<String, dynamic> json) {
    return Promo_image(
      id: json['id'],
      image_link: json['image_link'],
      number: json['number'] ?? '',
      sales_period: json['sales_period'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }
}

class _DiscountPageState extends State<DiscountPage> {
     List <Promo_image> promo_images_list = [
        Promo_image.fromJson({
          "id":1,
          "image_link":"https://picsum.photos/id/237/400/300",
          "number":1,
          "sales_period":1,
          "created_at":"2024-10-22 17:40:51.981164+02",
        }),
        Promo_image.fromJson({
          "id":2,
          "image_link":"https://picsum.photos/id/234/200/300",
          "number":2,
          "sales_period":1,
          "created_at":"2024-10-22 17:40:51.981164+02",
        }),
        Promo_image.fromJson({
          "id":3,
          "image_link":"https://picsum.photos/id/235/200/300",
          "number":3,
          "sales_period":1,
          "created_at":"2024-10-22 17:40:51.981164+02",
        }),
        Promo_image.fromJson({
          "id":3,
          "image_link":"https://picsum.photos/id/236/200/300",
          "number":3,
          "sales_period":1,
          "created_at":"2024-10-22 17:40:51.981164+02",
        }),
      ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: !widget.showAppbar?null: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            "Promotions",
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
                        child:
       NewBackground(
        child: SafeArea(
          child: Expanded(
            // height: size.height,
            child: Column(
              children: [
                // Row(
                //             children: [
                //               const Icon(Icons.Discount),
                //               Text('page principale',
                //               style: Global_variables.optionStyle,),
                //             ],
                //           ),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ListView.builder(
            itemCount: promo_images_list.length,
            itemBuilder: (context, index) {
          return Container(margin: EdgeInsets.only(bottom: 30),
          // decoration: BoxDecoration(border: Border.all(width: 3)),
            child: Image.asset(
              'images/page_16.jpg',
              width: size.width,
              fit: BoxFit.cover,
            ),
          );
            },
          ),
             SizedBox(height: 100,)       ],
                ),
              ),
            ],),
          ),
        )
      ),
    ))):NewBackground(
        child: SafeArea(
          child: Expanded(
            // height: size.height,
            child: Column(
              children: [
                // Row(
                //             children: [
                //               const Icon(Icons.Discount),
                //               Text('page principale',
                //               style: Global_variables.optionStyle,),
                //             ],
                //           ),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ListView.builder(
            itemCount: promo_images_list.length,
            itemBuilder: (context, index) {
          return Container(margin: EdgeInsets.only(bottom: 30),
          // decoration: BoxDecoration(border: Border.all(width: 3)),
            child: Image.asset(
              'images/page_16.jpg',
              width: size.width,
              fit: BoxFit.cover,
            ),
          );
            },
          ),
             SizedBox(height: 100,)       ],
                ),
              ),
            ],),
          ),
        )
      ),
    );
  }
}