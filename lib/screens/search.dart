import 'package:flutter/material.dart';
import 'package:flutter_movie_app/API/MovieAPI.dart';
import 'package:flutter_movie_app/API/user_preferences%20.dart';
import 'package:flutter_movie_app/screens/splash.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import '../widgets/search_results.dart';



class Search extends StatefulWidget {
  static const routeName = '/search';

  const Search({Key? key}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isSearching = false;
  static const historyLength = 10;
  List<String> _searchHistory = [];
  late List<String> filteredSearchHistory;
  late String selectedTerm='';
  late var movies =[];
  bool loaded = false;
  bool isEmpty = false;
  bool searchCache = false;

  List<String> filterSearchTerms({
    required String filter,
  }) {
    if (filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void find() async{

    var movieList = await MovieApi.findMovie(selectedTerm);

    setState(() {
      loaded = true;
      movies = movieList["results"];
      isEmpty = movieList["total_results"] == 0;
    });

    if(isEmpty){
      deleteSearchTerm(selectedTerm);
    }

  }

  void addSearchTerm(String term)async {
    term.trim();

    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }

    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filteredSearchHistory = _searchHistory.reversed.toList();
    UserPreferences.setSearchResults(_searchHistory);
  }

  void deleteSearchTerm(String term) {
    term.trim();
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = _searchHistory.reversed.toList();
    UserPreferences.setSearchResults(_searchHistory);
  }

  void putSearchTermFirst(String term) {
    term.trim();
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  void fetchSearchHistory()async{
    try{
    _searchHistory = await UserPreferences.getSearchResults();
    filteredSearchHistory = _searchHistory.reversed.toList();
    }catch(e){
      setState(() {
        _searchHistory = [];
        filteredSearchHistory = [];
      });
    }
    setState(() {
      searchCache = true;
    });
  }

  late FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: "null");
    fetchSearchHistory();

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return searchCache ? (Scaffold(
      body: FloatingSearchBar(
        controller: controller,
        body: FloatingSearchBarScrollNotifier(
          child: SearchResults(selectedTerm: selectedTerm,  isSearching: isSearching,  movies: movies, loaded: loaded, isEmpty: isEmpty),
        ),
        transition: CircularFloatingSearchBarTransition(),
        physics: const BouncingScrollPhysics(),
        title:  Text(
          selectedTerm=='' ? "Search" : selectedTerm,
        ),
        hint: 'Search and find your favorite movies...',
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onQueryChanged: (query) {
          setState(() {
            filteredSearchHistory = filterSearchTerms(filter: query);
          });
        },
        onSubmitted: (query) {
          setState(() {
            addSearchTerm(query);
            selectedTerm = query;
            isSearching = true;
            find();
          });
          controller.close();
        },
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              elevation: 4,
              child: Builder(
                builder: (context) {
                  if (filteredSearchHistory.isEmpty && controller.query.isEmpty) {
                    return Container(
                      height: 56,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Start searching',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  }
                  else if (filteredSearchHistory.isEmpty ) {
                    return ListTile(
                      title: Text(controller.query),
                      leading: const Icon(Icons.search),
                      onTap: () {
                        setState(() {
                          addSearchTerm(controller.query);
                          selectedTerm = controller.query;
                        });
                        controller.close();
                      },
                    );
                  }
                  else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: filteredSearchHistory
                          .map(
                            (term)
                            {
                              return term=='' ? Container() : ListTile(
                                        title: Text(
                                          term,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        leading: const Icon(Icons.history),
                                        trailing: IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () {
                                            setState(() {
                                              deleteSearchTerm(term);
                                              selectedTerm = '';
                                            });
                                          },
                                        ),
                                        onTap: () {
                                          setState(() {
                                            putSearchTermFirst(term);
                                            setState(() {
                                              isSearching = true;
                                              selectedTerm = term;
                                            });
                                            find();
                                          });
                                          controller.close();
                                        },
                                      );
                                    })
                          .toList(),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    )) : const Splash();
  }
}
