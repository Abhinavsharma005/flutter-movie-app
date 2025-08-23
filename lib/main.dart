import 'package:flutter/material.dart';
import 'package:flutter_movie_app/utils/text.dart';
import 'package:flutter_movie_app/widgets/toprated.dart';
import 'package:flutter_movie_app/widgets/trending.dart';
import 'package:flutter_movie_app/widgets/tv.dart';
import 'package:flutter_movie_app/widgets/upcoming.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.green),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String apikey = '946ea54c3769c9b40f406bbfcf3c574b';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NDZlYTU0YzM3NjljOWI0MGY0MDZiYmZjZjNjNTc0YiIsIm5iZiI6MTc1NTc3ODQ2Ny45ODMsInN1YiI6IjY4YTcwZGEzZDUyYjZjYzA3ODVkZGE1MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.xPD-vUV2zpn2vv0h1I1faA5ypQA9uG98xHC3PG4RfhE';
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];
  List upcoming = [];
  List searchmovies = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadmovies();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPopular();
    Map upcomingresult = await tmdbWithCustomLogs.v3.movies.getUpcoming();
    print((trendingresult));
    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
      upcoming = upcomingresult['results'];
    });
  }

  /// 🔎 Search function
  searchMovie(String query) async {
    if (query.isEmpty) {
      setState(() => searchmovies = []);
      return;
    }

    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apikey, readaccesstoken));

    Map searchresult =
    await tmdbWithCustomLogs.v3.search.queryMovies(query);

    setState(() {
      searchmovies = searchresult['results'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF020315), //0xFF141A2CFF
        appBar: AppBar(
          title: modified_text(text: 'Flutter Movie App ❤️', color: Colors.white, size: 24),
          backgroundColor: Color(0xFF05092C), //0xFF1A223AFF
        ),
        body: ListView(
          children: [
            // 🔹 Search Box
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => searchMovie(value),
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search movies...",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      "assets/search_icon.png",
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                  ),
                  filled: true,
                  fillColor: Color(0xFF1A223A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // 🔹 Show search results if available
            if (searchmovies.isNotEmpty)
              Container(
                height: 270,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: searchmovies.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 140,
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500${searchmovies[index]['poster_path']}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            searchmovies[index]['title'] ?? 'No Title',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            TV(tv: tv),
            TrendingMovies(
              trending: trendingmovies,
            ),
            TopRatedMovies(
              toprated: topratedmovies,
            ),
            UpcomingMovies(upcoming: upcoming),
          ],
        ));
  }
}