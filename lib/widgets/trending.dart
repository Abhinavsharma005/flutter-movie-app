import 'package:flutter/material.dart';
import 'package:flutter_movie_app/utils/text.dart';
import 'package:google_fonts/google_fonts.dart';
import '../description.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;

  // ✅ Null safety fix
  const TrendingMovies({Key? key, required this.trending}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // modified_text(
          //   text: 'Trending Movies',
          //   color: Colors.white,
          //   size: 26,
          // ),
          Text(
            'Trending Movies',
            style: GoogleFonts.cabin(
              fontSize: 26,
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: trending.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Description(
                          name: trending[index]['title'] ?? 'No Title',
                          bannerurl:
                          'https://image.tmdb.org/t/p/w500${trending[index]['backdrop_path']}',
                          posterurl:
                          'https://image.tmdb.org/t/p/w500${trending[index]['poster_path']}',
                          description: trending[index]['overview'] ?? '',
                          vote: trending[index]['vote_average']?.toString() ?? '0',
                          launch_on: trending[index]['release_date'] ?? 'Unknown',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 140,
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${trending[index]['poster_path']}',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          child: modified_text(
                            size: 15,
                            color: Colors.white,
                            text: trending[index]['title'] ?? 'Loading',
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
