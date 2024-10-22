import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class backBouton extends StatelessWidget {
  const backBouton({super.key});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        Get.back();
      },
      child: Row(
        children: [
          SvgPicture.asset('assets/Icons/back.svg'),
          SizedBox(width: 5,),
          Text('Back',style:Theme.of(context).textTheme.bodyMedium?.
          copyWith
            (color: Theme.
          of(context).
          colorScheme.
          background),
          ),
        ],
      ),
    );
  }
}
