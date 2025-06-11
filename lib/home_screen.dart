import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/secrets.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
String apikey = Secrets.apikey;
String accesstoken = Secrets.accesstoken;
final TextEditingController  _controller = TextEditingController();
List<MovieListElements> movieList = [];
  @override
  void initState() {






    super.initState();
  }
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
onSubmited(String value)async{

  await searchMovie(value);
  print("movielistlength= ${movieList.length}");
  setState(() {

  });
}

  Future<void> searchMovie(String keyWord) async {
    print("searchMovie");
    final response = await http.get(

      Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=$apikey&query=$keyWord'),
     // Uri.parse('https://api.themoviedb.org/3/search/keyword?page=1'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accesstoken'
      },
    );

    if (response.statusCode == 200) {
      movieList=[];
      print("full:  ${response.body} vege");
      // movieList=

      Map<String, dynamic> jsonData = jsonDecode(response.body);
      for(int i=0;i<jsonData['results'].length;i++){
        print("number $i");
        MovieListElements movieListElements=MovieListElements(
          posterPath: jsonData['results'][i]['poster_path']??"",
          title: jsonData['results'][i]['title'],
          popularity: jsonData['results'][i]['popularity'],
          voteAverage: jsonData['results'][i]['vote_average'],
          originalLanguage: jsonData['results'][i]['original_language'],
          overview: jsonData['results'][i]['overview'],
          id: jsonData['results'][i]['id'],
        );
      movieList.add(movieListElements);

      }
      print("movie3overview:  ${movieList[2].overview}");
     print("json page ${jsonData['results'].length}");

      //Movie movie = Movie.fromJson());
      print("movieeeeeee");
   //   print(movie.overview);
    /*  print("full:  ${response.body}");
      print(jsonDecode(response.body));*/

    } else {
      print('Failed to fetch data');
    }
  }
  Future<void> searchMovies2(String query) async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=$apikey&query=$query'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data['results']); // List of movies
    } else {
      print('Failed to fetch movies');
    }
  }
  Future<void> searchMoviesByKeyword(String keyword) async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/search/keyword?api_key=$apikey&query=$keyword'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final keywordId = data['results'][0]['id']; // Get first keyword ID

      final movieResponse = await http.get(
        Uri.parse('https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&with_keywords=$keywordId'),
      );

      if (movieResponse.statusCode == 200) {
        print(jsonDecode(movieResponse.body)['results']); // List of movies
      } else {
        print('Failed to fetch movies');
      }
    } else {
      print('Failed to fetch keyword');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Movies"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              onSubmitted: (value) {
                onSubmited(value);
              },
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            )
          ),
          movieList.length!=0 ?listView(): Text("loading"),
        /*  ElevatedButton(onPressed: (){
            Navigator.pushNamed(context, 'second');
          }, child: Text("second")),
          ElevatedButton(onPressed: (){
            fetchData();
          }, child: Text("get data")),*/

    //Image.network("https://image.tmdb.org/t/p/w500/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg")
        ],
      ),
    );
  }
Widget listView(){
  return    Expanded(
    child: ListView.builder(
      itemCount: movieList.length, // Dynamic list length
      itemBuilder: (context, index) {
        return Card(
          child: Row(

            children: [
              Expanded(
                  flex: 1,
                  child: Image.network("https://image.tmdb.org/t/p/w500/${movieList[index].posterPath}")),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(movieList[index].title),
                      subtitle: Text(movieList[index].overview)
                      ,
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 30.0),
                    Text("${movieList[index].voteAverage}"),
                    Icon(Icons.favorite, color: Colors.red, size: 30.0),
                        Text("${movieList[index].popularity}"),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
}

class MovieListElements{
// poster_path,title,overview,popularity,vote_average
//original_language
//id
  final String posterPath;
  final String title;
  final double popularity;
  final double voteAverage;
  final String originalLanguage;
  final String overview;
  final int id;

  MovieListElements({
    required this.posterPath,
    required this.title,
    required this.popularity,
    required this.voteAverage,
    required this.originalLanguage,
    required this.overview,
    required this.id,
  });


}
