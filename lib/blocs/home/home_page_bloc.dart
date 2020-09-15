
import 'dart:async';
import 'package:prueba_gbp2/models/actor_model.dart';
import 'package:prueba_gbp2/models/movie_model.dart';

import 'home_page_event.dart';
import 'package:prueba_gbp2/api/tmdb_api.dart';

class HomePageBloc {

  HomePageBloc._internal();
  static HomePageBloc _instance = HomePageBloc._internal();
  static HomePageBloc get instance => _instance;

  final TmdbApi _tmdbApi = new TmdbApi();
  
  
  final _homeEventController = StreamController<HomePageEvent>();
  Sink<HomePageEvent> get homeEventControllerSink => _homeEventController.sink;

  final _topRatedStateController = StreamController<List<MovieModel>>();
  StreamSink<List<MovieModel>> get _inTopRated => _topRatedStateController.sink;
  Stream<List<MovieModel>> get topRated => _topRatedStateController.stream;


  final _topRecommendedStateController = StreamController<List<MovieModel>>();
  StreamSink<List<MovieModel>> get _inTopRecommended => _topRecommendedStateController.sink;
  Stream<List<MovieModel>> get topRecommended => _topRecommendedStateController.stream;

  final _actorsStreamController = StreamController<List<ActorModel>>();
  StreamSink<List<ActorModel>> get _actors => _actorsStreamController.sink;
  Stream<List<ActorModel>> get actors => _actorsStreamController.stream;

  HomePageBloc(){
    _homeEventController.stream.listen(_mapEventToState);
  }


  void _mapEventToState(HomePageEvent event) async{
    if(event is GetInitialInformation){
      _getTopRated("");
      _getRecommended("");
    }
  }

  void _getTopRated(String query) async {
    final movies = await _tmdbApi.getTopRated(query);
    _inTopRated.add(movies);
  }

  void _getRecommended(String query) async {
    final movies = await _tmdbApi.getRecommended(query);
    _inTopRecommended.add(movies);
  }

  void getActors(int id) async {
    final actors = await _tmdbApi.getActors(id);
    _actors.add(actors);
  }

  void searchMovie(String query){
    _getTopRated(query);
    _getRecommended(query);
  }


  void dispose(){
    _topRatedStateController?.close();
    _homeEventController?.close();
    _topRecommendedStateController?.close();
    _actorsStreamController?.close();
  }
}