import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kayon_frontend/classes/Global_variables.dart';
import 'package:kayon_frontend/classes/colors.dart';
import 'package:kayon_frontend/components/background.dart';

class CustomerPage extends StatefulWidget {
  final bool showAppbar;
  const CustomerPage({super.key, required this.showAppbar});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  String emailField = '';
  String passwordField = '';
  bool loading = false;
  bool showNewPassword = false;
  void toggleNewPasswordVisibility() {
    setState(() {
      showNewPassword = !showNewPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: !widget.showAppbar
            ? null
            : AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                title: Text(
                  "Espace fidélité",
                  style: GoogleFonts.lexend(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: const Color(AppColors.orange_primary),
              ),
        body: GestureDetector(
            behavior:
                HitTestBehavior.translucent, // Ensures all taps outside work
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus(); // Hides keyboard
            },
            child: size.width > 600
                ? NewBackground(
                    child: Container(
                    alignment: Alignment.center,
                    child: Container(
                      alignment: size.width > 600 ?Alignment.center:null,
                      width: size.width > 600 ? 600 : null,
                      constraints:size.width > 600 ? const BoxConstraints(maxWidth: 600):null,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.red)),
                      child: Container(
                          //   color: const Color(0xFFFFE306),
                          // width: size.width,
                          // height: size.height,
                          // child: Row(
                          //             children: [
                          //               const Icon(Icons.person),
                          //               Text('Espace fidelité',
                          //               style: Global_variables.optionStyle,),
                          //             ],
                          //           ),

                     child: Container(margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.white), borderRadius: BorderRadius.all(Radius.circular(10))),
                        height: 300,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            LayoutBuilder(builder: (ctx, constraints) {
                              return Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 0),
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  child: Focus(
                                    onFocusChange: (hasFocus) {
                                      if (!hasFocus) {
                                        FocusScope.of(context).unfocus();
                                      }
                                    },
                                    child: TextField(
                                    
                                      cursorColor: const Color(AppColors.orange_primary),
                                      style: GoogleFonts.lexend(
                                        color: const Color(AppColors.orange_primary),
                                      ),
                                      onChanged: (value) => emailField = value,
                                      decoration: InputDecoration(
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:  Color(AppColors.orange_primary),
                                            ),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:  Color(AppColors.orange_primary),
                                            ),
                                          ),
                                          labelStyle: GoogleFonts.lexend(
                                            color:  Color(AppColors.orange_primary),
                                          ), //
                                          labelText:
                                              "Email ou numéro de téléphone"),
                                    ),
                                  ));
                            }),
                            SizedBox(height: size.height * 0.02),
                            // champs password
                            LayoutBuilder(builder: (ctx, constraints) {
                              return Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  child: Focus(
                                    onFocusChange: (hasFocus) {
                                      if (!hasFocus) {
                                        FocusScope.of(context).unfocus();
                                      }
                                    },
                                    child: TextField(   obscureText: !showNewPassword,
                                      cursorColor: const Color(AppColors.orange_primary),
                                      style: GoogleFonts.lexend(
                                        color: const Color(AppColors.orange_primary),
                                      ),
                                      onChanged: (value) =>
                                          passwordField = value,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                                  icon: Icon(
                                                    showNewPassword
                                                        ? Icons.visibility_off
                                                        : Icons.visibility,
                                                    color: const Color(AppColors.orange_primary),
                                                  ),
                                                  onPressed:
                                                      toggleNewPasswordVisibility,
                                                ),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:  Color(AppColors.orange_primary),
                                            ),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:  Color(AppColors.orange_primary),
                                            ),
                                          ),
                                          labelStyle: GoogleFonts.lexend(
                                            color: const Color(AppColors.orange_primary),
                                          ),
                                          labelText: "Mot de passe"),
                                      // obscureText: true,
                                    ),
                                  ));
                            }),
                            // SizedBox(
                            //   height: size.height * 0.02,
                            // ),
                            SizedBox(height: size.width < 600 ? 20 : 40),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  constraints:
                                      const BoxConstraints(minWidth: 170),
                                  width: size.width * 0.15,
                                  child: TextButton(
                                      onPressed: () {
                                        // print("Mot de passe oublié ?");
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           ForgotPasswordScreen()),
                                        // );
                                      },
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "Mot de passe oublié ?",
                                          style: GoogleFonts.lexend(
                                            color: const Color(AppColors.orange_primary),
                                          ),
                                        ),
                                      ))),
                            ),

                            const SizedBox(height: 10),
                            // bouton connexion
                            Container(
                              padding: const EdgeInsets.all(0),
                              margin: const EdgeInsets.only(bottom: 10),
                              height: 50,
                              width: size.width,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (emailField.isNotEmpty &&
                                      passwordField.isNotEmpty) {
                                        setState(() {
                                          loading=!loading;
                                        });
                                      }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(AppColors.orange_primary),
                                  foregroundColor: Colors.black,
                                ),
                                child: loading
                                    ? Transform.scale(
                                        scale: 0.5,
                                        child: const CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                           Color(AppColors.orange_primary),
                                        )),
                                      )
                                    : Text(
                                        'CONNEXION',
                                        style: GoogleFonts.lexend(
                                            color: Colors.white,
                                            fontSize: 17,
                                            letterSpacing: 3,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ),
                  ))
                :   NewBackground(
                  child:Container(
                      alignment: Alignment.center,
                      width: size.width > 600 ? 600 : null,
                      constraints: const BoxConstraints(maxWidth: 600),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.red)),
                      child: Container(
                          //   color: const Color(0xFFFFE306),
                          // width: size.width,
                          // height: size.height,
                          // child: Row(
                          //             children: [
                          //               const Icon(Icons.person),
                          //               Text('Espace fidelité',
                          //               style: Global_variables.optionStyle,),
                          //             ],
                          //           ),

                          child: Container(
                        height: 300,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            LayoutBuilder(builder: (ctx, constraints) {
                              return Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 0),
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  child: Focus(
                                    onFocusChange: (hasFocus) {
                                      if (!hasFocus) {
                                        FocusScope.of(context).unfocus();
                                      }
                                    },
                                    child: TextField(
                                    
                                      cursorColor: Colors.white,
                                      style: GoogleFonts.lexend(
                                        color: Colors.white,
                                      ),
                                      onChanged: (value) => emailField = value,
                                      decoration: InputDecoration(
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          labelStyle: GoogleFonts.lexend(
                                            color: Colors.white,
                                          ), //
                                          labelText:
                                              "Email ou numéro de téléphone"),
                                    ),
                                  ));
                            }),
                            SizedBox(height: size.height * 0.02),
                            // champs password
                            LayoutBuilder(builder: (ctx, constraints) {
                              return Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  child: Focus(
                                    onFocusChange: (hasFocus) {
                                      if (!hasFocus) {
                                        FocusScope.of(context).unfocus();
                                      }
                                    },
                                    child: TextField(   obscureText: !showNewPassword,
                                      cursorColor: Colors.white,
                                      style: GoogleFonts.lexend(
                                        color: Colors.white,
                                      ),
                                      onChanged: (value) =>
                                          passwordField = value,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                                  icon: Icon(
                                                    showNewPassword
                                                        ? Icons.visibility_off
                                                        : Icons.visibility,
                                                    color: Colors.white
                                                  ),
                                                  onPressed:
                                                      toggleNewPasswordVisibility,
                                                ),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          labelStyle: GoogleFonts.lexend(
                                            color: Colors.white,
                                          ),
                                          labelText: "Mot de passe"),
                                      // obscureText: true,
                                    ),
                                  ));
                            }),
                            // SizedBox(
                            //   height: size.height * 0.02,
                            // ),
                            SizedBox(height: size.width < 600 ? 20 : 40),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  constraints:
                                      const BoxConstraints(minWidth: 170),
                                  width: size.width * 0.45,
                                  child: TextButton(
                                      onPressed: () {
                                        // print("Mot de passe oublié ?");
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           ForgotPasswordScreen()),
                                        // );
                                      },
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "Mot de passe oublié ?",
                                          style: GoogleFonts.lexend(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ))),
                            ),

                            const SizedBox(height: 10),
                            // bouton connexion
                            Container(
                              padding: const EdgeInsets.all(0),
                              margin: const EdgeInsets.only(bottom: 10),
                              height: 50,
                              width: size.width,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (emailField.isNotEmpty &&
                                      passwordField.isNotEmpty) {
                                        setState(() {
                                          loading=!loading;
                                        });
                                      }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                ),
                                child: loading
                                    ? Transform.scale(
                                        scale: 0.5,
                                        child: const CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                          Colors.white,
                                        )),
                                      )
                                    : Text(
                                        'CONNEXION',
                                        style: GoogleFonts.lexend(
                                            color: const Color(
                                                AppColors.orange_primary),
                                            fontSize: 17,
                                            letterSpacing: 3,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      )))))
                );
  }
}
