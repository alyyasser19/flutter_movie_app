import 'package:flutter/material.dart';

import '../models/Movie.dart';

class MovieDisplay extends StatelessWidget {
 final Movie movie;

  const MovieDisplay(this.movie, {Key?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 2/10: MediaQuery.of(context).size.height * 1/3;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: height,
        child: Card(
          elevation: 10,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                movie.imageUrl,
                height: height,
                errorBuilder: (context, url, error) {
                  return const Icon(Icons.error);
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            movie.year,
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.4,
                        child: SingleChildScrollView(
                          child: Text(
                            movie.description,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ),
      ),
    );
  }
}
