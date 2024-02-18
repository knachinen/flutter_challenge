import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/screens/detail_screen.dart';
import 'package:movieflix/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MovieModel>> popularMovies = ApiService.getPopularMovies();
  final Future<List<MovieModel>> nowMovies = ApiService.getNowMovies();
  final Future<List<MovieModel>> comingSoonMovies =
      ApiService.getComingSoonMovies();

  final String movieThumbUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 50,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              // ----------------
              // Popular Movies
              // ----------------
              sectionView(
                height: 460,
                text: "Popular Movies",
                future: popularMovies,
              ),
              // ----------------
              // Now in Cinemas
              // ----------------
              sectionView(
                height: 270,
                text: "Now in Cinemas",
                future: nowMovies,
              ),
              // ----------------
              // Coming soon
              // ----------------
              sectionView(
                height: 270,
                text: "Coming soon",
                future: comingSoonMovies,
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox sectionView({
    required double? height,
    required String text,
    required Future<List<MovieModel>> future,
  }) {
    return SizedBox(
      height: height,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  text,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: makeMovieList(
                    snapshot,
                    height: (height! - 90),
                  ),
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

  ListView makeMovieList(AsyncSnapshot<List<MovieModel>> snapshot,
      {double? height = 180}) {
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
            children: [
              Container(
                height: height,
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
