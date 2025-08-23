import 'package:flutter/material.dart';
import 'package:flutter_movie_app/utils/text.dart';
import 'package:google_fonts/google_fonts.dart';
import '../description.dart';

class TopRatedMovies extends StatelessWidget {
  final List toprated;

  const TopRatedMovies({Key? key, required this.toprated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // modified_text(
          //   text: 'Top Rated Movies',
          //   size: 26,
          //   color: Colors.white,
          // ),
          Text(
            'Top Rated Movies',
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
              itemCount: toprated.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Description(
                          name: toprated[index]['title'] ?? 'No Title',
                          bannerurl:
                          'https://image.tmdb.org/t/p/w500${toprated[index]['backdrop_path']}',
                          posterurl:
                          'https://image.tmdb.org/t/p/w500${toprated[index]['poster_path']}',
                          description: toprated[index]['overview'] ?? '',
                          vote: toprated[index]['vote_average']?.toString() ?? '0',
                          launch_on: toprated[index]['release_date'] ?? 'Unknown',
                          // cast: toprated[index]['cast'] ?? [],
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
                                'https://image.tmdb.org/t/p/w500${toprated[index]['poster_path']}',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          child: modified_text(
                            size: 15,
                            color: Colors.white,
                            text: toprated[index]['title'] ?? 'Loading',
                          ),
                        ),
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

