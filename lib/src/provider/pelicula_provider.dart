import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login/src/Models/peliculas_model.dart';

class PeliculasProvider {
  String _apiKey = '66db8929cc45cabf3562b94573563ad5';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  bool _cargando = false;

  int _popularesPage = 0;

  List<Pelicula> _populares = new List();

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disponseStream() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> getEnCine() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];

    _cargando = true;

    print("cargando...");

    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });
    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);

    popularesSink(_populares);
    _cargando = false;

    return resp;
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final respuesta = await http.get(url);

    final decodedata = json.decode(respuesta.body);

    final peliculas = new Peliculas.fromJsonList(decodedata['results']);

    return peliculas.items;
  }
}
