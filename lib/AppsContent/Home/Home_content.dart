import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeAAppsBAr extends StatefulWidget {
  const HomeAAppsBAr({super.key});

  @override
  State<HomeAAppsBAr> createState() => _HomeAAppsBArState();
}

class _HomeAAppsBArState extends State<HomeAAppsBAr> {
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       //IconButton(onPressed:(){}, icon:Icon(Icons.menu,color: Colors.white, size: 40.0,)),
        Text('DUSOME',style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
          color: Colors.white,
        ),),
        //
      ],
    );
  }
}
class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          SizedBox(width: 10.0,),
          Icon(Icons.search),
          Expanded(
            child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Search here ..',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),

          ),
          ),

        ],
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final String iconPath;
  final String btnName;
  const CategoryWidget(
      {super.key, required this.iconPath, required this.btnName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.background),
          child: Row(
            children: [
              SvgPicture.asset(iconPath),
              const SizedBox(width: 10),
              Text(btnName),
            ],
          ),
        ),
      ),
    );
  }
}