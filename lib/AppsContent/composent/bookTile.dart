
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

List<String> favoriteBooks = [];

class BookTile extends StatelessWidget {
  final String ? pushkey;
  final String title;
  final String imageUrl;
  final String page;
  final String language;
  final String category;
  final VoidCallback ontap;
  const BookTile({super.key,
        this.pushkey,
       required this.title,
       required this.imageUrl,
       required this.page,
       required this.language,
       required this.ontap,
    required this.category,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap:ontap,
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(2, 2),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    width: 90,
                    height: 120,
                    // loadingBuilder: (){
                    //   return CircularProgressIndicator();
                    // },
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( title,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 10.0,),
                    Text( 'Page: $page',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(height: 4,),
                    Text('Langue: $language',style: Theme.of(context).
                    textTheme.bodyMedium?.
                    copyWith(color:
                    Theme.of(context).
                    colorScheme.
                    secondary,
                    ),
                    ),
                    SizedBox(height: 10.0,),
                    Text('Categorie: $category',style: Theme.of(context).
                    textTheme.bodyMedium?.
                    copyWith(color:
                    Theme.of(context).
                    colorScheme.
                    secondary,
                    ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SvgPicture.asset('assets/Icons/star.svg'),
                        SvgPicture.asset('assets/Icons/star.svg'),
                        SvgPicture.asset('assets/Icons/star.svg'),
                      ],
                    )
                  ],
                ),
              ),
              IconButton(
                  onPressed: () async {
                    if (favoriteBooks.contains(imageUrl)) {
                      //favoriteBooks.remove(imageUrl);
                      var key = FirebaseAuth.instance.currentUser?.uid;

                      // DatabaseReference ref = FirebaseDatabase.instance.ref("favoritebooks").child(key!).push();
                      // await ref.set({
                      //   "title": title,
                      //   "language": language,
                      //   "page": page,
                      //   "imageUrl": imageUrl, // Save the image URL
                      // });

                    } else {
                      var uidkey = FirebaseAuth.instance.currentUser?.uid;

                      DatabaseReference ref = FirebaseDatabase.instance.ref("favoritebooks").child(uidkey!);
                      String ? key = ref.push().key;
                      await ref.child(key!).set({
                        "pushkey": key,
                        "title": title,
                        "language": language,
                        "page": page,
                        "imageUrl": imageUrl, // Save the image URL
                      });
                      favoriteBooks.add(imageUrl);
                    }
                    // Optionnel : Afficher un message de confirmation
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(favoriteBooks.contains(imageUrl)
                            ? 'Ajouté aux favoris'
                            : 'Retiré des favoris'),
                      ),
                    );

                  },
                  icon: Icon(
                    favoriteBooks.contains(imageUrl)
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
