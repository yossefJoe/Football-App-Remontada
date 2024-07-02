class Scorers {
  Scorer? player;
  Team? team;
  int? playedMatches;
  int? goals;
  int? assists;
  int? penalties;

  Scorers(
      {this.player,
      this.team,
      this.playedMatches,
      this.goals,
      this.assists,
      this.penalties});

  Scorers.fromJson(Map<String, dynamic> json) {
    player =
        json['player'] != null ? new Scorer.fromJson(json['player']) : null;
    team = json['team'] != null ? new Team.fromJson(json['team']) : null;
    playedMatches = json['playedMatches'];
    goals = json['goals'];
    assists = json['assists'];
    penalties = json['penalties'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.player != null) {
      data['player'] = this.player!.toJson();
    }
    if (this.team != null) {
      data['team'] = this.team!.toJson();
    }
    data['playedMatches'] = this.playedMatches;
    data['goals'] = this.goals;
    data['assists'] = this.assists;
    data['penalties'] = this.penalties;
    return data;
  }
}

class Scorer {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? nationality;
  String? section;
  String? lastUpdated;

  Scorer(
      {this.id,
      this.name,
      this.firstName,
      this.lastName,
      this.dateOfBirth,
      this.nationality,
      this.section,
      this.lastUpdated});

  Scorer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    dateOfBirth = json['dateOfBirth'];
    nationality = json['nationality'];
    section = json['section'];
    lastUpdated = json['lastUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['dateOfBirth'] = this.dateOfBirth;
    data['nationality'] = this.nationality;
    data['section'] = this.section;
    data['lastUpdated'] = this.lastUpdated;
    return data;
  }
}

class Team {
  int? id;
  String? name;
  String? shortName;
  String? tla;
  String? crest;
  String? address;
  String? website;
  int? founded;
  String? clubColors;
  String? venue;
  String? lastUpdated;

  Team(
      {this.id,
      this.name,
      this.shortName,
      this.tla,
      this.crest,
      this.address,
      this.website,
      this.founded,
      this.clubColors,
      this.venue,
      this.lastUpdated});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
    tla = json['tla'];
    crest = json['crest'];
    address = json['address'];
    website = json['website'];
    founded = json['founded'];
    clubColors = json['clubColors'];
    venue = json['venue'];
    lastUpdated = json['lastUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['tla'] = this.tla;
    data['crest'] = this.crest;
    data['address'] = this.address;
    data['website'] = this.website;
    data['founded'] = this.founded;
    data['clubColors'] = this.clubColors;
    data['venue'] = this.venue;
    data['lastUpdated'] = this.lastUpdated;
    return data;
  }
}
