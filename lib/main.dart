import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/movie_model.dart';
import 'package:movie_app/presentation/custom_textfield.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF1E1F27),
        body: 
        FutureBuilder<MovieModel>(
          future: fetchMovieData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final movie = snapshot.data!;
              return 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomTextField(),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 390,
                    height: 578,
                    child: Stack(
                      children: [
                        Image.network(
                          movie.poster!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                const Color(0xFF1E1F27).withOpacity(1),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 180,
                          left: 20,
                          child: Text(
                            movie.genre?? '',
                            style: GoogleFonts.poppins(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Positioned(
                          bottom: 140,
                          left: 20,
                          child: Text(
                            movie.title?? '',
                            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: SizedBox(
                            width: 350,
                            child: Text(
                              movie.plot??'',
                              style: GoogleFonts.poppins(color: Colors.white),
                              maxLines: 6,
                              softWrap: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding:  EdgeInsets.all(20.0),
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "KC",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Add a comment...",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                            color: Color.fromRGBO(144, 144, 144, 1.0),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Text('No data');
            }
          },
        ),
      ),
    );
  }

  Future<MovieModel> fetchMovieData() async {
    final dio = Dio();
    try {
      final response =
          await dio.get('https://www.omdbapi.com/?i=tt3896198&apikey=e7a0ec87');
      if (response.statusCode == 200) {
        return MovieModel.fromJson(response.data);
      } else {
        throw Exception({response.statusCode});
      }
    } catch (e) {
      print(e);
      throw Exception('');
    }
  }
}
