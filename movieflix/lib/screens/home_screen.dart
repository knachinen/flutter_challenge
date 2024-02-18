import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_model.dart';
// import 'package:movieflix/models/webtoon_model.dart';
import 'package:movieflix/screens/detail_screen.dart';
import 'package:movieflix/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();
  final Future<List<MovieModel>> popularMovies = ApiService.getPopularMovies();
  final Future<List<MovieModel>> nowMovies = ApiService.getNowMovies();
  final Future<List<MovieModel>> comingSoonMovies =
      ApiService.getComingSoonMovies();

  final String movieThumbUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 60,
          ),
          // ----------------
          // Popular Movies
          // ----------------
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Popular Movies",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: popularMovies,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Flexible(
                  child: makeMovieList(snapshot),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          // ----------------
          // Now in Cinemas
          // ----------------
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Now in Cinemas",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: nowMovies,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: makeMovieList(snapshot),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          // ----------------
          // Coming soon
          // ----------------
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Coming soon",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: comingSoonMovies,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: makeMovieList(snapshot),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }

  ListView makeMovieList(AsyncSnapshot<List<MovieModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var movie = snapshot.data![index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  title: movie.title,
                  thumb: movie.backdropPath,
                  id: movie.id,
                ),
                // fullscreenDialog: true,
              ),
            );
          },
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                // width: 120,
                height: 200,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      offset: const Offset(1, 1),
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
                child: Image.network(
                  "$movieThumbUrl${movie.posterPath}",
                ),
              ),
              Text(
                movie.title.length > 14
                    ? "${movie.title.substring(0, 14)}..."
                    : movie.title,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
