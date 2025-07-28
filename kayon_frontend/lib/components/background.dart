/**
 * Background est un widget qui se charge de l'aspect de l'arrière-plan
 */
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kayon_frontend/classes/colors.dart';

class NewBackground extends StatelessWidget {
  final Widget child;
  final double? height;

  const NewBackground({Key? key, required this.child, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: double.infinity,
                // height: size.height*1.5,
                constraints: BoxConstraints.expand(
                  height: height?? MediaQuery.of(context).size.height
                  ), 
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
            
              Color(AppColors.orange_light),
              Color(AppColors.orange_primary),
              
            ],         ),
                ),
                child: Expanded(child: child)),
          ],
        ),
      ),
    );
  }
}
