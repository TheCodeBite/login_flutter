import 'package:flutter/material.dart';
import 'package:login/src/Models/peliculas_model.dart';

class PeliculaDetalle extends StatelessWidget {
  // final Pelicula pelicula;

  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[_crearAppbar(pelicula)],
    ));
  }

  _crearAppbar(Pelicula pelicula) {
    print("id: ${pelicula.id}");

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.00,
      floating: false,
      pinned: true, //mantiene el nav aunque se haga scroll
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
            placeholder: AssetImage('assets/img/loading.gif'),
            image: NetworkImage(pelicula.getBackrgroundImg()),
            fadeInDuration: Duration(milliseconds: 150),
            fit: BoxFit.cover),
      ),
    );
  }
}
