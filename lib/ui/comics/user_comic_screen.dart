import 'package:flutter/material.dart';
import 'package:comic/ui/comics/edit_comic_screen.dart';
import 'user_comic_list_tile.dart';
import 'comics_manager.dart';
import '../shared/app_drawer.dart';
import 'package:provider/provider.dart';
class UserComicsScreen extends StatelessWidget{
  static const routeName = '/user-comics';
  const UserComicsScreen ({super.key});

  @override
  Widget build(BuildContext context){
    final comicsManager = ComicsManager();
    return Scaffold(
      appBar: AppBar(
      title: const Text('Your Comics'),
      actions: <Widget>[
        buildAddButton(context),
      ],
      ),
    drawer: const AppDrawer(),
    body: RefreshIndicator(
      onRefresh: () async=> print('refresh Comics'),
       child: buildUserProductListView(),
    ),
    );
  }
  Widget buildAddButton(BuildContext context){
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditComicScreen.routeName,
        );
      },
    );
  }
  Widget buildUserProductListView() {
    return Consumer<ComicsManager>(
      builder: (ctx, productsManager, child) {
        return ListView.builder(
          itemCount: productsManager.comicCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserComicListTile(
                productsManager.comic[i],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}