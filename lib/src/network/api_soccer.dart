import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:soccer/src/models/statisticsdao.dart';
import 'package:soccer/src/models/teamdao.dart';

class ApiSoccer{
  final URL_BASE = "https://www.thesportsdb.com/api/v1/json/1";
  Client http = Client();

  Future<List<TeamDAO>> getAllTeams() async{
    //Hacer referencia al http, ocupar el get, y pide la url. Retorna future response, y al ser future debe ir con await
    final response = await http.get(URL_BASE+'/lookup_all_teams.php?id=4350');
    if(response.statusCode==200){ //Si la peticion fue correcta
      var teams = jsonDecode(response.body)['teams'] as List; //parsear el cuerpo de la respuesta: teams, y pasa a lista dinamica
      List<TeamDAO> listTeams =teams.map((element) => TeamDAO.fromJSON(element)).toList();
      return listTeams;
    }else{
      return null;
    }
  }

  Future<List<TeamDAO>> getTeamByName(teamName) async{
    final response = await http.get(URL_BASE+'/searchteams.php?t='+teamName);
    if(response.statusCode==200){ 
      var teams = jsonDecode(response.body)['teams'] as List; 
      List<TeamDAO> listTeams =teams.map((element) => TeamDAO.fromJSON(element)).toList();
      return listTeams;
    }else{
      return null;
    }
  }

  Future<List<StatisticsDAO>> getTeamStatistics(idTeam) async{
    final response = await http.get(URL_BASE+'/lookuptable.php?l=4350&s=2020-2021');
    if(response.statusCode==200){ 
      var teams = jsonDecode(response.body)['table'] as List; 
      List<StatisticsDAO> listTeams =teams.map((element) => StatisticsDAO.fromJSON(element)).toList();
      return listTeams;
    }else{
      return null;
    }
  }
}