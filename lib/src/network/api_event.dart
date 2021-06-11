import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:soccer/src/models/eventdao.dart';

class ApiEvent{
  final URL_BASE = "https://www.thesportsdb.com/api/v1/json/1/eventslast.php?id=";
  Client http = Client();

  Future<List<EventDAO>> getLastEvents(idTeam) async{
    //Hacer referencia al http, ocupar el get, y pide la url. Retorna future response, y al ser future debe ir con await
    final response = await http.get(URL_BASE+idTeam);
    if(response.statusCode==200){ //Si la peticion fue correcta
      var events = jsonDecode(response.body)['results'] as List; //parsear el cuerpo de la respuesta: events, y pasa a lista dinamica
      List<EventDAO> listEvents = events.map((element) => EventDAO.fromJSON(element)).toList();
      return listEvents;
    }else{
      return null;
    }
  }
}