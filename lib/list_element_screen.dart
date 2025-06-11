import 'package:flutter/material.dart';
import 'package:movie_app/movie_list_element.dart';

class ListElementScreen extends StatelessWidget {
  MovieListElement movieListElement;
  int index=0;
   ListElementScreen({super.key,required this.movieListElement });




   releaseOrComing(){
     DateTime now = DateTime.now();
     DateTime date=DateTime.parse(movieListElement.releaseDate);
     if(date.isBefore(now)){
       return "Released";
     }else{
       return "Coming";
     }
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

      Column(
    children: [
   /*   Expanded(
        flex: 3,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://image.tmdb.org/t/p/w500/${movieListElement.posterPath}"),
              fit: BoxFit.cover, // Ensures the image fills the space
            ),
          ),
        ),
      ),*/
      Expanded(
        flex: 3,
        child: Stack(
          children: [
           // Image.network("https://image.tmdb.org/t/p/w500/${movieListElement.posterPath}"),
             Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://image.tmdb.org/t/p/w500/${movieListElement.posterPath}"),
                  fit: BoxFit.cover, // Ensures the image fills the space
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 35,
              child: Row(children: [
                Icon(Icons.star, color: Colors.yellow, size: 40.0),
                Text("${movieListElement.voteAverage}",style: TextStyle(color: Colors.yellow,fontSize: 30),),
              ],),
            ),
        
            Positioned(
                left: 35,
                bottom: 50,
        
                child: Text(movieListElement.title,style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold,color: Colors.white),)),
            Positioned(
              top: 30,
              left: 20,
              child: IconButton(
                color: Colors.white,
                icon: Icon(Icons.arrow_back),
                iconSize: 35,
                onPressed: () {
                  Navigator.pop(context); // Goes back to the previous screen
                },
              ),
            ),
        
        
        
        
        
        
          ],
        ),
      ),
    Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                child: Column(
                  children: [

                  Text("Status",style: TextStyle(color: Colors.grey),),
                  Text(releaseOrComing(),style: TextStyle(fontSize: 18),),

                ],),
              ),
              Container(
                width: 1, // Thin vertical line
                height: 30, // Adjust height as needed
                color: Colors.grey, // Line color
              ),
              Expanded(
                child: Column(children: [
                  Text("Popularity",style: TextStyle(color: Colors.grey),),
                  Text(movieListElement.popularity.toString(),style: TextStyle(fontSize: 18),),

                ],),
              ),
              Container(
                width: 1, // Thin vertical line
                height: 30, // Adjust height as needed
                color: Colors.grey, // Line color
              ),
              Expanded(
                child: Column(children: [
                  Text("Language",style: TextStyle(color: Colors.grey),),
                  Text(movieListElement.originalLanguage.toUpperCase(),style: TextStyle(fontSize: 18),),

                ],),
              ),

            ],),
            Padding(padding: EdgeInsets.all(10),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(movieListElement.overview, style: TextStyle(fontSize: 17,color: Colors.grey),),
            ),
          ],
        ),
      ),
    )









     /* Container(

        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://image.tmdb.org/t/p/w500/${movieListElement.posterPath}"),
            fit: BoxFit.cover,
          ),
        ),
        child: Text(movieListElement.title),),*/


      ]

    )

    );

  }
}
