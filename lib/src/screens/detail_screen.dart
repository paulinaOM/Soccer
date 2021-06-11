import 'package:flutter/material.dart';
import 'package:soccer/src/screens/pageOne_detail.dart';
import 'package:soccer/src/screens/pageTwo_detail.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;
  
  @override
  void initState() { 
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
    void dispose() {
      _tabController.dispose();
      _scrollViewController.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    final team = ModalRoute.of(context).settings.arguments as Map<String,dynamic>; //Recuperar los argumentos
    
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('Team detail'),
              pinned: true,
              floating: true,
              expandedHeight: 200,
              forceElevated: boxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                background: appBarCover2(team['idTeam']),
              ),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.home),
                  ),
                  Tab(
                    icon: Icon(Icons.assessment),
                  )
                ],
                controller: _tabController,
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            PageOne(team: team),
            PageTwo(team: team)
          ],
        ),
      ),
    );
  }
}

Widget appBarCover(team, teamBadgeUrl){
  return(
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: 60,
            image: NetworkImage('$teamBadgeUrl'),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(team, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15, color: Colors.white),)
          )
        ],
      ),
    )
  );
}

Widget appBarCover2(String idTeam){
  String image;
  switch(idTeam){
    case '134195': //Atlas
      image = '134195.png';
    break;
    case '136856': //ASL
      image = '136856.png';
    break;
    case '134196': //CAZ
      image = '134196.png';
    break;
    case '136855': //Juarez
      image = '136855.png';
    break;
    case '134207': //Leon
      image = '134207.png';
    break;
    case '139995': //Mazatlan
      image = '139995.png';
    break;
    case '134198': //MTY
      image = '134198.png';
    break;
    case '135662': //Necaxa
      image = '135662.png';
    break;
    case '134191': //Pachuca
      image = '134191.png';
    break;
    case '134199': //Puebla
      image = '134199.png';
    break;
    case '134201'://Pumas
      image = '134201.png';
    break;
    case '134194': //Qro
      image = '134194.png';
    break;
    case '134192'://Santos
      image = '134192.png';
    break;
    case '134197': //Tigres
      image = '134197.png';
    break;
    case '134202': //Tijuana
      image = '134202.png';
    break;
    case '134204': //Toluca
      image = '134204.png';
    break;
    case '134206': //Chivas
      image = '134206.png';
    break;
    case '134193': //America
      image = '134193.png';
    break;
  }
  return Image(
    image: AssetImage(image),
    fit: BoxFit.fill,
  );
}