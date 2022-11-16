import 'package:flutter/material.dart';

import 'comics_grid.dart';
import 'package:provider/provider.dart';
import '../shared/app_drawer.dart';
enum FilterOptions { favorites , all }
class ComicsOverviewScreen extends StatefulWidget{
  const ComicsOverviewScreen({super.key});
  @override
  State<ComicsOverviewScreen> createState() => _ComicsOverviewScreenState();
}
class _ComicsOverviewScreenState extends State<ComicsOverviewScreen> {
  var _showOnlyFavorite = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('NET Comic'),
        actions: <Widget>[
          buildComicFilterMenu(),
        ],
      ),
      drawer: const AppDrawer(),
      body: ComicGrid(_showOnlyFavorite),

    );
  }
  Widget buildComicFilterMenu(){
    return PopupMenuButton(
      onSelected:(FilterOptions selectedValue){
        setState(() {
          if (selectedValue == FilterOptions.favorites){
            _showOnlyFavorite=true;
          }else{
            _showOnlyFavorite=false;
          }
        });
      },
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (ctx) =>[
        const PopupMenuItem(
          value: FilterOptions.favorites,
          child: Text('Only Favorites'),
        ),
        const PopupMenuItem(
          value: FilterOptions.all,
          child: Text('Show All'),
        ),
      ],
    );
  }
}