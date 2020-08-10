import 'package:flutter/material.dart';
import 'package:login/src/Models/peliculas_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageControl = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );
  @override
  Widget build(BuildContext context) {
    final _screemSize = MediaQuery.of(context).size;
    _pageControl.addListener(() {
      if (_pageControl.position.pixels >=
          _pageControl.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });

    return Container(
        height: _screemSize.height * 0.2,
        child: PageView.builder(
          pageSnapping: false,
          controller: _pageControl,
          itemCount: peliculas.length,
          itemBuilder: (context, i) => _tarjet(context, peliculas[i]),
          // children: _tarjetas(context),
        ));
  }

  Widget _tarjet(BuildContext context, Pelicula pelicula) {
    final peliculaTarjeta = Container(
        margin: EdgeInsets.only(right: 15.00),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterUrl()),
                fit: BoxFit.cover,
                height: 160.00,
              ),
            ),
            // Text(
            //   pelicula.title,
            //   overflow: TextOverflow.ellipsis,
            //   style: Theme.of(context).textTheme.caption,
            // )
          ],
        ));

    return GestureDetector(
      onTap: () {
        print('pelicula ${pelicula.title}');
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
      child: peliculaTarjeta,
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      // print(pelicula.title);
    }).toList();
  }
}
