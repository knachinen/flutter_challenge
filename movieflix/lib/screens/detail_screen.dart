import 'package:flutter/material.dart';
import 'package:movieflix/services/api_service.dart';
import 'package:movieflix/models/movie_detail_model.dart';

class DetailScreen extends StatelessWidget {
  final String title, thumb;
  final num id;

  final String movieImageUrl = 'https://image.tmdb.org/t/p/w500';

  DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  late final Future<MovieDetailModel> movie = ApiService.getMovieById(id);

  // late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: FutureBuilder(
        future: movie,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              constraints: const BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                  opacity: 0.6,
                  image: NetworkImage(
                      "$movieImageUrl/${snapshot.data!.backdropPath}"),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 275,
                  ),
                  SizedBox(
                    height: 500,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                          children: [
                            FutureBuilder(
                              future: movie,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Tagline
                                      Text(
                                        "${snapshot.data!.title}\n",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      // Overview
                                      Text(
                                        "${snapshot.data!.overview}\n",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      // Age
                                      const Text(
                                        "Age:",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.adult
                                            ? "Adult"
                                            : "General",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      // Genres
                                      const Text(
                                        "\nGenres: ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      for (Map<String, dynamic> item
                                          in snapshot.data!.genres)
                                        Text(
                                          "- ${item["name"]}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      // Spoken Language
                                      const Text(
                                        "\nSpoken Language:",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      for (Map<String, dynamic> item
                                          in snapshot.data!.language)
                                        Text(
                                          item["english_name"].toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      // Runtime
                                      const Text(
                                        "\nRuntime:",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${snapshot.data!.runtime} minutes",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                // No Data
                                return const Text(
                                  "...",
                                  style: TextStyle(
                                    color: Colors.amber,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Text('...');
        },
      ),
    );
  }
}
