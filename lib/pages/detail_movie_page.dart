import 'package:flutter/material.dart';
import 'package:prueba_gbp2/blocs/home/home_page_bloc.dart';
import 'package:prueba_gbp2/models/actor_model.dart';
import 'package:prueba_gbp2/models/movie_model.dart';
import 'package:prueba_gbp2/utils/constants.dart';
import 'package:prueba_gbp2/utils/responsive.dart';


class DetailMoviePage extends StatefulWidget {

  final MovieModel movie;

  const DetailMoviePage({
    @required this.movie
  }) : assert( movie != null);

  @override
  _DetailMoviePageState createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {

  final _homeBloc = HomePageBloc();


  @override
  void initState() { 
    _homeBloc.getActors(this.widget.movie.id);
    super.initState();
  }


  @override
  void dispose() {
    _homeBloc.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final Responsive responsive = new Responsive.of(context);
    return Scaffold(
      backgroundColor: Color(0xff2C3848),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: responsive.hp(35),
                  width: double.infinity,
                  color: Colors.red,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/images/loading.gif'),
                    image: NetworkImage('${Constants.THE_MOVIE_DB_IMG_PATH}/${this.widget.movie.backdropPath}'),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: responsive.ip(4),),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: responsive.ip(3)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              '${this.widget.movie.originalTitle}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: responsive.ip(3)
                              ),
                            ),
                          ),
                          SizedBox(width: responsive.ip(2),),
                          Icon(Icons.movie, color: Colors.white,)
                        ],
                      ),
                      SizedBox(height: responsive.ip(2),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,  
                        children: [
                          FlatButton(
                            shape: StadiumBorder(),
                            color: Color(0xff6B737F),
                            onPressed: (){},
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'WATCH NOW',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Color(0xffFCD309),
                                size: responsive.ip(2),
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xffFCD309),
                                size: responsive.ip(2),
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xffFCD309),
                                size: responsive.ip(2),
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xffFCD309),
                                size: responsive.ip(2),
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xff56583B),
                                size: responsive.ip(2),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: responsive.ip(2),),
                      Text(
                        '${this.widget.movie.overview}',
                        style: TextStyle(
                          color: Color(0xff888F99)
                        ),
                      ),
                      SizedBox(height: responsive.ip(1),),
                      Container(
                        height: responsive.hp(20),
                        child: StreamBuilder(
                          stream: _homeBloc.actors,
                          builder: (BuildContext context, AsyncSnapshot<List<ActorModel>> snapshot){
                            if(snapshot.hasData){
                              return PageView.builder(
                                controller: PageController(
                                  viewportFraction: 0.35
                                ),
                                pageSnapping: false,
                                itemCount: snapshot.data.length,
                                itemBuilder: (_, index){
                                  final actor = snapshot.data[index];
                                  return Container(
                                    margin: EdgeInsets.only(right: responsive.ip(1)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: FadeInImage(
                                            width: responsive.hp(10),
                                            height: responsive.hp(12),
                                            placeholder: AssetImage('assets/images/no-image.jpg'),
                                            image: (actor.profilePath != null) 
                                            ? NetworkImage('${Constants.THE_MOVIE_DB_IMG_PATH}/${actor.profilePath}')
                                            : AssetImage('assets/images/no-image.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          '${actor.name}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: responsive.ip(1),),
                      Row(
                        children: [
                          Text(
                            'Release',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(width: responsive.ip(1.5),),
                          Text(
                            '${this.widget.movie.releaseDate.year.toString().padLeft(4, '0')}',
                            style: TextStyle(
                              color: Color(0xff6B737F),
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: responsive.ip(2),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: responsive.hp(5),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: responsive.ip(3)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    Icon(Icons.favorite_border, color: Colors.white,)
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}