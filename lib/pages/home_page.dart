import 'package:flutter/material.dart';
import 'package:prueba_gbp2/models/movie_model.dart';
import 'package:prueba_gbp2/utils/responsive.dart';
import 'package:prueba_gbp2/widgets/card_movie.dart';
import 'package:prueba_gbp2/blocs/home/home_page_bloc.dart';
import 'package:prueba_gbp2/blocs/home/home_page_event.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _homeBloc = HomePageBloc();

  @override
  void initState() {
    _homeBloc.homeEventControllerSink.add(GetInitialInformation());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = new Responsive.of(context);
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xff5CA0D3),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: responsive.hp(10),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: responsive.ip(4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, what do you \n want to watch ?',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.ip(3.5)
                      ),
                    ),
                    SizedBox(
                      height: responsive.hp(4),
                    ),
                    _searchInput()
                  ],
                ),
              ),
              SizedBox(
                height: responsive.hp(4),
              ),
              _box()
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchInput() {
    return Material(
      color: Color(0xff8DBCE0),
      elevation: 0,
      shape: StadiumBorder(),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(
            color: Colors.white
          ),
          filled: false,
          isDense: false,
          prefixIcon: Icon(Icons.search, color: Colors.white,),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        onChanged: _homeBloc.searchMovie,
      ),
    );
  }

  Widget _box(){
    final Responsive responsive = new Responsive.of(context);
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff2C3848),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30)
          )
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: responsive.ip(4), 
            left: responsive.ip(3.5),
            bottom: responsive.ip(3)
          ),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _boxRecommended(constraints, responsive),
                  _boxTopRated(constraints, responsive),
                ],
              );
            },
          ),
        ),
      ),
    );
  }


  Widget _boxRecommended(BoxConstraints constraints, Responsive responsive) {
    return Container(
      height: constraints.maxHeight * 0.48,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RECOMMENDED FOR YOU',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500
                )
              ),
              Padding(
                padding: EdgeInsets.only(right: responsive.ip(3.5)),
                child: Text(
                  'See all', 
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints size) {
                return Column(
                  children: [
                    SizedBox(height: size.maxHeight * 0.10,),
                    Container(
                      height: size.maxHeight * 0.90,
                      child: StreamBuilder(
                        stream: _homeBloc.topRecommended,
                        builder: (BuildContext context, AsyncSnapshot<List<MovieModel>> snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                final movie = snapshot.data[index];
                                return Container(
                                  margin: EdgeInsets.only(right: 20),
                                  width: responsive.wp(33),
                                  child: CardMovie(type: 'RECOMMENDED', movie: movie,),
                                );
                              },
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _boxTopRated(BoxConstraints constraints, Responsive responsive) {
    return Container(
      height: constraints.maxHeight * 0.48,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TOP RATED',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500
                )
              ),
              Padding(
                padding: EdgeInsets.only(right: responsive.ip(3.5)),
                child: Text(
                  'See all', 
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints size) {
                return Column(
                  children: [
                    SizedBox(height: size.maxHeight * 0.10,),
                    Container(
                      height: size.maxHeight * 0.90,
                      child: StreamBuilder(
                        stream: _homeBloc.topRated,
                        builder: (BuildContext context, AsyncSnapshot<List<MovieModel>> snapshot){
                          if(snapshot.hasData){
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                final movie = snapshot.data[index];
                                return Container(
                                  margin: EdgeInsets.only(right: 20),
                                  width: responsive.wp(33),
                                  child: CardMovie(type: 'TOP', movie: movie,),
                                );
                              },
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}