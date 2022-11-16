import 'package:flutter/foundation.dart';
import '../../models/comic.dart';

class ComicsManager with ChangeNotifier {
  final List<Comic> _comic = [ Comic(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      isFavorite: true,
    ),
    Comic(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Comic(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Comic(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
      isFavorite: true,
    ),
    ];
    int get comicCount {
      return _comic.length;
    }

    List<Comic> get comic{
      return [..._comic];
    }

    List<Comic> get favoritecomic{
      return _comic.where((comItem) => comItem.isFavorite).toList();
    }
    Comic findById(String id) {
    return _comic.firstWhere((com) => com.id == id);  
    }  
    void addComic(Comic comic){
      _comic.add(
        comic.copyWith(
          id: 'p${DateTime.now().toIso8601String()}',
        ),
      );
      notifyListeners();
    } 
    void updateComic(Comic comic){
      final index = _comic.indexWhere((comic) => comic.id==comic.id);
      if (index >= 0 ){
        _comic[index] = comic;
        notifyListeners();
      }
    }
    void toggleFavoriteStatus(Comic comic){
      final savedStatus = comic.isFavorite;
      comic.isFavorite = !savedStatus;
    }
    void deleteComic(String id){
      final index = _comic.indexWhere((comic) => comic.id==id);
      _comic.removeAt(index);
      notifyListeners();
    }
}