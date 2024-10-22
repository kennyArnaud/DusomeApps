import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../composent/backbouton.dart';
class HeaderWidget extends StatelessWidget {
    final String imageUrl;
    final String title;
    final String description;
    final String page;
    final String language;
    final String category;

  const HeaderWidget({super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.page,
    required this.language,
    required this.category,
    });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50,),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              backBouton(),
              InkWell(
                  onTap: (){

                  },
                  child: SvgPicture.asset('assets/Icons/heart.svg',color: Colors.white,)
              ),
            ]
        ),
        SizedBox(height: 40,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(imageUrl,
                width: 180,
              ),
            ),
          ],
        ),
        SizedBox(height: 20,),
        Text(title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
        ),
        SizedBox(height: 10,),
        Text(description,
          textAlign: TextAlign.center,
          style:
          Theme.of(context).
          textTheme.labelSmall?.
          copyWith(color: Theme.of(context).
          colorScheme.
          background),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text('pages',style:
                Theme.of(context).
                textTheme.labelSmall?.
                copyWith(color: Theme.of(context).
                colorScheme.
                background),),
                Text(page,style:
                Theme.of(context).
                textTheme.bodyMedium?.
                copyWith(color: Theme.of(context).
                colorScheme.
                background),),
              ],
            ),
            Column(
              children: [
                Text('Language',style:
                Theme.of(context).
                textTheme.labelSmall?.
                copyWith(color: Theme.of(context).
                colorScheme.
                background),),
                Text(language,style:
                Theme.of(context).
                textTheme.bodyMedium?.
                copyWith(color: Theme.of(context).
                colorScheme.
                background),),
              ],
            ),
            Column(
              children: [
                Text('Categorie',style:
                Theme.of(context).
                textTheme.labelSmall?.
                copyWith(color: Theme.of(context).
                colorScheme.
                background),),
                Text(category,style:
                Theme.of(context).
                textTheme.bodyMedium?.
                copyWith(color: Theme.of(context).
                colorScheme.
                background),),
              ],
            ),
          ],
        )
      ],
    );
  }
}
