import 'package:flutter/material.dart';
import 'package:flutter_movie_app/utils/text.dart';
import 'package:google_fonts/google_fonts.dart';
import '../description.dart'; // ✅ import Description page

class TV extends StatelessWidget {
  final List tv;

  const TV({Key? key, required this.tv}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular TV Shows',
            style: GoogleFonts.cabin(
              fontSize: 26,
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 10),

          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tv.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Description(
                          name: tv[index]['original_name'] ?? 'No Title',
                          bannerurl:
                          'https://image.tmdb.org/t/p/w500${tv[index]['backdrop_path']}',
                          posterurl:
                          'https://image.tmdb.org/t/p/w500${tv[index]['poster_path']}',
                          description: tv[index]['overview'] ?? '',
                          vote: tv[index]['vote_average']?.toString() ?? '0',
                          launch_on: tv[index]['first_air_date'] ?? 'Unknown',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    width: 250,
                    child: Column(
                      children: [
                        Container(
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${tv[index]['backdrop_path']}',
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
                            text: tv[index]['original_name'] ?? 'Loading',
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

