import 'package:flutter/material.dart';
import 'package:prueba_gbp2/models/movie_model.dart';
import 'package:prueba_gbp2/pages/detail_movie_page.dart';
import 'package:prueba_gbp2/utils/constants.dart';
import 'package:prueba_gbp2/utils/responsive.dart';


class CardMovie extends StatelessWidget {

  final String type;
  final MovieModel movie;

  const CardMovie({@required this.type, @required this.movie});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = new Responsive.of(context);
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (_) => DetailMoviePage(movie: this.movie)
          )
        );
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: FadeInImage(
                  placeholder: AssetImage('assets/images/no-image.jpg'),
                  fit: BoxFit.cover,
                  image: (this.movie.posterPath != null) 
                  ? NetworkImage('${Constants.THE_MOVIE_DB_IMG_PATH}/${this.movie.posterPath}')
                  : AssetImage('assets/images/no-image.jpg'),
                ),
              ),
            ),
            SizedBox(
              height: responsive.ip(0.9),
            ),
            Text(
              '${this.movie.originalTitle}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
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
                  color: (this.type == "RECOMMENDED") ? Color(0xff56583B) : Color(0xffFCD309),
                  size: responsive.ip(2),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}