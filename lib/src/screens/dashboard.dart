import 'package:flutter/material.dart';
import 'package:soccer/src/models/teamdao.dart';
import 'package:soccer/src/network/api_soccer.dart';


class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  _DashboardState createState()=> _DashboardState();
}

class _DashboardState extends State<Dashboard>{
    
    @override
    void initState(){
      super.initState();
    }

    @override
    Widget build(BuildContext context){
      return Material(
        type: MaterialType.card,
        color: Colors.black87,
        child: CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              pinned: true,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Teams'),
                background: Center(
                  child: Image(
                    image: AssetImage('logo_liga_mx.png'), //https://www.thesportsdb.com/images/media/league/banner/o34vth1570281270.jpg
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( 
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10, 
              ), 
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _futureTeams(index, context);
                },
                childCount: 18,
              ),
            ),
          ]
        ),
      );
    }
  }


  Widget _futureTeams(index, context){
    ApiSoccer apiSoccer = ApiSoccer();
    return FutureBuilder( //Future builder siempre retorna un widget
      future: apiSoccer.getAllTeams(),
      builder: (BuildContext context, AsyncSnapshot<List<TeamDAO>> snapshot){
        if(snapshot.hasError){
          return Center(
            child: Text("Has error in this request"),
          );
        }else if(snapshot.connectionState == ConnectionState.done){
          return _teamCard(snapshot.data[index], context); 
        }else{ //Si tarda mucho el consumo mostrará una barra de progreso
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }

  Widget _teamCard(TeamDAO team, context) {
    return Card(
      elevation: 10,
      child: InkWell(
        splashColor: Colors.indigo.withAlpha(30),
        onTap: (){
          
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Opacity(
                opacity: 0.2,
                child: Image(image: NetworkImage('https://www.thesportsdb.com/images/media/league/badge/vsussv1422037333.png')),
              ),
              Column(
                children: <Widget>[
                  Image(image: NetworkImage(team.strTeamBadge), height: 80,),
                  Text(team.strTeam, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  Text(team.strStadium, style: TextStyle(fontSize: 12),),
                ],
              ),
              Positioned(
                bottom: 0,
                right: -30,
                child: FlatButton(
                  child: Icon(Icons.chevron_right, size: 30,),
                  onPressed: (){
                    print(team.idTeam);
                    Navigator.pushNamed(context, '/detail', arguments: {
                      'idTeam': team.idTeam,
                      'strTeam': team.strTeam,
                      'strTeamBadge': team.strTeamBadge,
                      'intFormedYear': team.intFormedYear,
                      'strAlternate': team.strAlternate,
                      'strDescriptionEn': team.strDescriptionEn,
                      'strDescriptionEs': team.strDescriptionEs,
                      'strStadium': team.strStadium,
                      'strStadiumThumb': team.strStadiumThumb,
                      'strStadiumLocation': team.strStadiumLocation,
                      'strStadiumDescription': team.strStadiumDescription,
                      'intStadiumCapacity': team.intStadiumCapacity,
                      'strWebsite': team.strWebsite,
                      'strFacebook': team.strFacebook,
                      'strTwitter': team.strTwitter,
                      'strInstagram': team.strInstagram,
                      'strTeamJersey': team.strTeamJersey
                    });
                  },
                )
              ),
            ],
          ),
        ),
      ),
    );
  } 

