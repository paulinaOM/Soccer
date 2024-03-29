// Generated by https://quicktype.io

class StatisticsDAO {
  String idStanding;
  String intRank;
  String idTeam;
  String strTeam;
  String strTeamBadge;
  String idLeague;
  String strLeague;
  String strSeason;
  String strForm;
  String strDescription;
  String intPlayed;
  String intWin;
  String intLoss;
  String intDraw;
  String intGoalsFor;
  String intGoalsAgainst;
  String intGoalDifference;
  String intPoints;
  String dateUpdated;

  StatisticsDAO({
    this.idStanding,
    this.intRank,
    this.idTeam,
    this.strTeam,
    this.strTeamBadge,
    this.idLeague,
    this.strLeague,
    this.strSeason,
    this.strForm,
    this.strDescription,
    this.intPlayed,
    this.intWin,
    this.intLoss,
    this.intDraw,
    this.intGoalsFor,
    this.intGoalsAgainst,
    this.intGoalDifference,
    this.intPoints,
    this.dateUpdated,
  });

  factory StatisticsDAO.fromJSON(Map<String, dynamic> map){ //Recibe json convertido a mapa
		return StatisticsDAO(
			idTeam: map['idTeam'],
      strTeam : map['strTeam'],
      intPlayed : map['intPlayed'],
      intWin : map['intWin'],
      intLoss : map['intLoss'],
      intDraw : map['intDraw'],
      intGoalsFor : map['intGoalsFor'],
      intGoalsAgainst : map['intGoalsAgainst'],
      intGoalDifference : map['intGoalDifference'],
      intPoints : map['intPoints'],
		);
	}
}
