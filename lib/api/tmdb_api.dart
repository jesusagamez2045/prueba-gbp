
import 'package:dio/dio.dart';
import 'package:prueba_gbp2/models/actor_model.dart';
import 'package:prueba_gbp2/models/movie_model.dart';
import 'package:prueba_gbp2/utils/constants.dart';

class TmdbApi {
  

  final Dio _dio = new Dio(
    BaseOptions(
      baseUrl: "https://api.themoviedb.org/3"
    )
  );


  Future<List<MovieModel>> getTopRated(String query) async{
    try {
      var url = "/movie/top_rated";
      if(query.trim().length > 0){
        url = "/search/movie";
      }

      final resp = await this._dio.get(
        '$url',
        queryParameters: {
          "api_key" : Constants.THE_MOVIE_DB_API_KEY,
          "query" : query
        }
      );

      if(resp.statusCode != 200) {
        return [];
      }

      return (resp.data['results'] as List).map((e) => MovieModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<MovieModel>> getRecommended(String query) async{
    try {

      var url = "/movie/popular";
      if(query.trim().length > 0){
        url = "/search/movie";
      }

      final resp = await this._dio.get(
        '$url',
        queryParameters: {
          "api_key" : Constants.THE_MOVIE_DB_API_KEY,
          "query" : query
        }
      );

      if(resp.statusCode != 200) {
        return [];
      }

      return (resp.data['results'] as List).map((e) => MovieModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<ActorModel>> getActors(int idMovie) async{
    try {
      final resp = await this._dio.get(
        '/movie/$idMovie/credits',
        queryParameters: {
          "api_key" : Constants.THE_MOVIE_DB_API_KEY
        }
      );

      if(resp.statusCode != 200) {
        return [];
      }

      return (resp.data['cast'] as List).map((e) => ActorModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }



}