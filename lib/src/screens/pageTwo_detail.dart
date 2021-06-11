import 'package:flutter/material.dart';
import 'package:soccer/src/models/eventdao.dart';
import 'package:soccer/src/models/statisticsdao.dart';
import 'package:soccer/src/models/teamdao.dart';
import 'package:soccer/src/network/api_event.dart';
import 'package:soccer/src/network/api_soccer.dart';
import 'package:soccer/src/utils/chart.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({
    Key key,
    @required this.team,
  }) : super(key: key);

  final team;
  
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: CustomScrollView ( 
        slivers: <Widget> [ 
          SliverList(
            delegate: SliverChildListDelegate ( 
              [ 
                _titles('Statistics'),
                Container(child: _statistics(team['idTeam'])),
                _titles('Latest results'),
                Container(height: 300, padding: EdgeInsets.symmetric(horizontal: 15), child: _lastEvents(team['idTeam'], team['strTeamBadge'])),
              ], 
            ), 
          ), 
        ], 
      ),
    );
  }
}

Widget _titles(title){
  return Padding(
    padding: EdgeInsets.symmetric(horizontal:15, vertical: 10), 
    child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
  );
}

Widget _lastEvents(idTeam, homeTeamBadge){
  ApiEvent apiEvent = ApiEvent();
  return FutureBuilder( //Future builder siempre retorna un widget
    future: apiEvent.getLastEvents(idTeam),
    builder: (BuildContext context, AsyncSnapshot<List<EventDAO>> snapshot){
      if(snapshot.hasError){
        return Center(
          child: Text("Has error in this cast request ${snapshot.error}"),
        );
      }else if(snapshot.connectionState == ConnectionState.done){
        return _eventList(snapshot.data, homeTeamBadge); 
      }else{ //Si tarda mucho el consumo mostrará una barra de progreso
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    }
  );
}

Widget _eventList(List<EventDAO> events, homeTeamBadge) {
  return ListView.builder(
    itemBuilder: (context, index){
      EventDAO event = events[index];
      return _eventRow(event, homeTeamBadge);
    },
    itemCount: events.length,
  ); 
}

Widget _eventRow(EventDAO event, homeTeamBadge){
  return Container(
    padding: EdgeInsets.symmetric(horizontal:5, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:[
        Text(event.dateEventLocal),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(child: Text('${event.strHomeTeam}', overflow: TextOverflow.clip,)),
              Image(image: NetworkImage('$homeTeamBadge/tiny'), height: 30,),
              Text('${event.intHomeScore} : ${event.intAwayScore}' ),
              _awayTeamBadge(event.strAwayTeam),
              Flexible(child: Text('${event.strAwayTeam}', overflow: TextOverflow.clip,))
            ],
          ),
        ),
        Flexible(child: Text(event.strVenue, overflow: TextOverflow.clip,)),
      ]
    ),
  );
}

Widget _awayTeamBadge(awayTeam){
  ApiSoccer apiSoccer = ApiSoccer();
  return FutureBuilder( //Future builder siempre retorna un widget
    future: apiSoccer.getTeamByName(awayTeam),
    builder: (BuildContext context, AsyncSnapshot<List<TeamDAO>> snapshot){
      if(snapshot.hasError){
        return Center(
          child: Text("Has error in this cast request ${snapshot.error}"),
        );
      }else if(snapshot.connectionState == ConnectionState.done){
        List<TeamDAO> teams = snapshot.data;
        return Image(image: NetworkImage('${teams[0].strTeamBadge}/tiny'), height: 30,); 
      }else{ //Si tarda mucho el consumo mostrará una barra de progreso
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    }
  );
}

Widget _statistics(idTeam){
  ApiSoccer apiSoccer = ApiSoccer();
  return FutureBuilder( 
    future: apiSoccer.getTeamStatistics(idTeam),
    builder: (BuildContext context, AsyncSnapshot<List<StatisticsDAO>> snapshot){
      if(snapshot.hasError){
        return Center(
          child: Text("Has error in this cast request ${snapshot.error}"),
        );
      }else if(snapshot.connectionState == ConnectionState.done){
        int indexTeam=-1;
        snapshot.data.asMap().forEach((index, element) => { 
          (element.idTeam == idTeam)? indexTeam = index : null
        });
        return PieChartSample2(team: snapshot.data[indexTeam]); 
      }else{ //Si tarda mucho el consumo mostrará una barra de progreso
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    }
  );
}

