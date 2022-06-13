import 'package:clientapp/Home.dart';
import 'package:clientapp/Page.dart';
import 'package:clientapp/classe1.dart';
import 'package:clientapp/pageRestau.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Panier extends StatefulWidget {
  const Panier({Key? key}) : super(key: key);

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          SizedBox(height: 17.h,),
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                Classe1.classe=Accueil();
                Main_Page.currentindex=0;
              },
              child: Icon(
                Icons.arrow_back,
                size: 28,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Container(
              height: 209.h,
              width: 300.w,
              margin: EdgeInsets.symmetric(horizontal: 57.w),
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage('images/cart.png')))),
          SizedBox(height: 59.h),
          Center(
            child: AutoSizeText(
              '''Oops ! Votre liste est vide 
  Découvrir plus de repas !''',
              style: TextStyle(
                fontSize: 22.sp,
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 81.h),
          SizedBox(
            width: 200.w,
            height: 60.h,
            child: ElevatedButton(
              onPressed: () {
                Classe1.classe=Home();
                Main_Page.currentindex=0;
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Main_Page()));
              },
              child: AutoSizeText(
                'Découvrir !',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  shadowColor: Colors.grey,
                  primary: Color(0xffffda82),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          )
        ],
      ),
    ));
  }
}
