// import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:movieflix/services/api_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:movieflix/models/movie_detail_model.dart';
// import 'package:movieflix/models/webtoon_episode_model.dart';
// import 'package:movieflix/services/api_service.dart';
// import 'package:movieflix/widgets/episode_widget.dart';

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
                  fit: BoxFit.fitHeight,
                  opacity: 0.7,
                  image: NetworkImage(
                      "$movieImageUrl/${snapshot.data!.backdropPath}"),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 50,
                  ),
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: movie,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image.network(
                                //   "$movieImageUrl/${snapshot.data!.posterPath}}",
                                // ),
                                // Tagline
                                Text(
                                  "${snapshot.data!.tagline}\n",
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
                                Text(
                                  snapshot.data!.adult
                                      ? "Age: Adult"
                                      : "Age: General",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
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
                                  )
                              ],
                            );
                          }
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

                      // FutureBuilder(
                      //   future: episodes,
                      //   builder: (context, snapshot) {
                      //     if (snapshot.hasData) {
                      //       return Column(
                      //         children: [
                      //           // for (var episode in snapshot.data!) Text(episode.title)
                      //           for (var episode in snapshot.data!)
                      //             Episode(episode: episode, webtoonId: widget.id)
                      //         ],
                      //       );
                      //     }
                      //     return Container();
                      //   },
                      // )
                    ],
                  ),
                ),
              ),
            );
          }
          return const Text('...');
        },
      ),
    );
  }
}
