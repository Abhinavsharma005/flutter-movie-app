import 'package:flutter/material.dart';
import 'package:flutter_movie_app/utils/text.dart';
import 'package:google_fonts/google_fonts.dart';
import '../description.dart';

class UpcomingMovies extends StatelessWidget {
  final List upcoming;

  const UpcomingMovies({Key? key, required this.upcoming}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upcoming Movies',
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
              itemCount: upcoming.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Description(
                          name: upcoming[index]['title'] ?? 'No Title',
                          bannerurl:
                          'https://image.tmdb.org/t/p/w500${upcoming[index]['backdrop_path']}',
                          posterurl:
                          'https://image.tmdb.org/t/p/w500${upcoming[index]['poster_path']}',
                          description: upcoming[index]['overview'] ?? '',
                          vote: upcoming[index]['vote_average']?.toString() ?? '0',
                          launch_on: upcoming[index]['release_date'] ?? 'Unknown',
                          // cast: upcoming[index]['cast'] ?? [],
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
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${upcoming[index]['poster_path']}',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          child: modified_text(
                            size: 15,
                            color: Colors.white,
                            text: upcoming[index]['title'] ?? 'Loading',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
