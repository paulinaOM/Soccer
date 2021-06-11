import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  const PageOne({
    Key key,
    @required this.team
  }) : super(key: key);

  final team;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            _teamDetails(team['intFormedYear'], team['strStadium'], team['intStadiumCapacity'], team['strStadiumLocation'],team['strTeamJersey']),
            _titles('Description'),
            _teamDescription(team['strDescriptionEn'], team['idTeam']),
            _titles('Stadium'),
            _stadiumImage(team['strStadiumThumb'], team['idTeam']),
            _stadiumDescription(team['strStadiumDescription']),
          ])
        )
      ],
    );
  }
}

Widget _titles(title){
  return Padding(
    padding: EdgeInsets.symmetric(horizontal:15), 
    child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
  );
}

Widget _teamDetails(year, stadium, capacity, location, url){
  return Container(
    padding: EdgeInsets.fromLTRB(0, 10, 15, 10),//.symmetric(horizontal: 15, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Image(
            //height: 200,
            width: 150,
            image: NetworkImage(url),
            fit: BoxFit.fill,
          ),
        ),
        Expanded(
          child: Column( //Details
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(children: [ Icon(Icons.calendar_today, color: Colors.white54), Text('Formed year: $year')],),
              Row(children: [ Icon(Icons.sports_soccer, color: Colors.white54), Text('$stadium', overflow: TextOverflow.clip,)],),
              Row(children: [ Icon(Icons.person, color: Colors.white54), Text('Capacity: $capacity')],),
              Row(children: [ Icon(Icons.location_on, color: Colors.white54), Text('$location', overflow: TextOverflow.clip,)],)
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _teamDescription(strDescriptionEn, idTeam){
  String description;
  if(strDescriptionEn != null){
    description =strDescriptionEn;
  }
  else{
    switch(idTeam){
      case '134195':
        description = 'The Atlas Fútbol Club is a soccer team from Guadalajara that plays in the First Division of Mexico. \nFounded on August 15, 1916, the team receives its name in honor of the titan of Greek mythology Atlas, since according to one of the founders, Juan José "Lico" Cortina, "we felt the support of the world".\nThe colors that identify it are black and red by Saint Lawrence martyr, patron of Ampleforth College, site where some of its founders studied. The black symbolizes the martyr and the red, the blood shed by him. The famous A on the Atlas shield was designed by the Austrian painter and draftsman Carlos Stahl, who suggested the white A as a background.';
      break;
      case '134204':
        description = 'Deportivo Toluca Fútbol Club S.A. de C.V., 1 also known as Club Deportivo Toluca, is a professional soccer team that currently participates in the First Division of Mexico. It was officially founded on February 12, 1917 by a board of trustees headed by Manuel Henkel Bross and Román Ferrat Alday. Its headquarters are located in the city of Toluca, State of Mexico, in the Nemesio Díez Stadium, also known as "La Bombonera."\nThroughout the history of Mexican soccer, Deportivo Toluca has become the third soccer team with the most championships won in the Mexican First Division with a total of 10 titles, being behind Club América with 13 and Club Deportivo Guadalajara that has 12.';
      break;
      default:
        description = 'Ya tenia descripcion';
      break;
    }
  }
  return Container(padding: EdgeInsets.all(15), child: Text(description, style: TextStyle(height: 1.5),),);
}

Widget _stadiumDescription(stadiumDescription){
  (stadiumDescription!=null)? null : stadiumDescription = "";
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15),
    child: Text(stadiumDescription, style: TextStyle(height: 1.5),),
  );
}

Widget _stadiumImage(stadiumImage, idTeam){
  if(stadiumImage != null){
    return Container(
      padding: EdgeInsets.all(15),
      height: 250,
      child: Image(image: NetworkImage(stadiumImage), fit: BoxFit.fill,),
    );
  }
  else{
    String image;
    switch(idTeam){
      case '134195': //Atlas
        image = 'atlas.jpg';
      break;
      case '136856': //ASL
        image = 'asl.jpg';
      break;
      case '134196': //CAZ
        image = 'caz.jpg';
      break;
      case '136855': //Juarez
        image = 'juarez.webp';
      break;
      case '134207': //Leon
        image = 'leon.jpg';
      break;
      case '139995': //Mazatlan
        image = 'mazatlan.png';
      break;
      case '134198': //MTY
        image = 'mty.jpg';
      break;
      case '135662': //Necaxa
        image = 'necaxa.png';
      break;
      case '134191': //Pachuca
        image = 'pachuca.jpg';
      break;
      case '134199': //Puebla
        image = 'puebla.webp';
      break;
      case '134201'://Pumas
        image = 'pumas.jpg';
      break;
      case '134194': //Qro
        image = 'qro.jpg';
      break;
      case '134192'://Santos
        image = 'santos.jpg';
      break;
      case '134197': //Tigres
        image = 'trigres.webp';
      break;
      case '134202': //Tijuana
        image = 'tijuana.jpg';
      break;
      case '134204': //Toluca
        image = 'toluca.jpg';
      break;
    }
    String url = '$image';
    print(url);
    return Container(
        padding: EdgeInsets.all(15),
        height: 250,
        child: Image(image: AssetImage(url), fit: BoxFit.fill,),
    );
  }
}

