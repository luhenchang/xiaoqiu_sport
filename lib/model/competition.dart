class Competition {
  int type;
  String hostTeam;
  String hostTeamLogo;
  String guestTeam;
  String guestTeamLogo;
  int hostGoal;
  int guestGoal;
  int state;

  Competition.fromJson(Map json) {
    type = json['type'];
    hostTeam = json['hostteam'];
    hostTeamLogo = json['hostteamlogo'];
    guestTeam = json['guestteam'];
    guestTeamLogo = json['guestteamlogo'];
    hostGoal = json['hostgoal'];
    guestGoal = json['guestgoal'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'hostteam': hostTeam,
      'hostteamlogo': hostTeamLogo,
      'guestteam': guestTeam,
      'guestteamlogo': guestTeamLogo,
      'hostgoal': hostGoal,
      'guestgoal': guestGoal,
      'state': state
    };
  }
}
