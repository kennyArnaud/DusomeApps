import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class BookFavoris extends StatefulWidget {
  final String ? pushkey;
  final String title;
  final String imageUrl;
  final String page;
  final String language;
  final String category;
  final VoidCallback ontap;

  const BookFavoris({super.key,
    this.pushkey,
    required this.title,
    required this.imageUrl,
    required this.page,
    required this.language,
    required this.ontap,
    required this.category,
  });

  @override
  _BookFavorisState createState() => _BookFavorisState();
}

class _BookFavorisState extends State<BookFavoris> {
  Future<void> _deleteFromFavorites(String title) async {
    try {
      await FirebaseDatabase.instance.ref("favoritebooks")
          .child(FirebaseAuth.instance.currentUser?.uid ?? '')
          .child(title)
          .remove();

      // Mettre à jour l'état de l'appui après la suppression
      setState(() {
        widget.ontap();
      });
    } catch (e) {
      print('Erreur lors de la suppression : $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la suppression')),
      );
    }
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmer la suppression'),
          content: Text('Voulez-vous vraiment supprimer ce livre des favoris ?'),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Supprimer'),
              onPressed: () {
                Navigator.of(context).pop();
                if (widget.title != null) {
                  _deleteFromFavorites(widget.title!);
                } else {
                  print("Erreur: pushkey est nul.");
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: widget.ontap,
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
                    widget.imageUrl,
                    width: 90,
                    height: 120,
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      'Page: ${widget.page}',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(height: 4,),
                    Text(
                      'Langue: ${widget.language}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      'Categorie: ${widget.category}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),

                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _showDeleteConfirmationDialog();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
