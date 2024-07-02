class Player {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? nationality;
  String? section;
  String? position;
  int? shirtNumber;
  String? lastUpdated;
  CurrentTeam? currentTeam;

  Player(
      {this.id,
      this.name,
      this.firstName,
      this.lastName,
      this.dateOfBirth,
      this.nationality,
      this.section,
      this.position,
      this.shirtNumber,
      this.lastUpdated,
      this.currentTeam});

  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    dateOfBirth = json['dateOfBirth'];
    nationality = json['nationality'];
    section = json['section'];
    position = json['position'];
    shirtNumber = json['shirtNumber'];
    lastUpdated = json['lastUpdated'];
    currentTeam = json['currentTeam'] != null
        ? new CurrentTeam.fromJson(json['currentTeam'])
        : null;
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
    data['position'] = this.position;
    data['shirtNumber'] = this.shirtNumber;
    data['lastUpdated'] = this.lastUpdated;
    if (this.currentTeam != null) {
      data['currentTeam'] = this.currentTeam!.toJson();
    }
    return data;
  }
}

class CurrentTeam {
  Area? area;
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
  List<RunningCompetitions>? runningCompetitions;
  Contract? contract;

  CurrentTeam(
      {this.area,
      this.id,
      this.name,
      this.shortName,
      this.tla,
      this.crest,
      this.address,
      this.website,
      this.founded,
      this.clubColors,
      this.venue,
      this.runningCompetitions,
      this.contract});

  CurrentTeam.fromJson(Map<String, dynamic> json) {
    area = json['area'] != null ? new Area.fromJson(json['area']) : null;
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
    if (json['runningCompetitions'] != null) {
      runningCompetitions = <RunningCompetitions>[];
      json['runningCompetitions'].forEach((v) {
        runningCompetitions!.add(new RunningCompetitions.fromJson(v));
      });
    }
    contract = json['contract'] != null
        ? new Contract.fromJson(json['contract'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.area != null) {
      data['area'] = this.area!.toJson();
    }
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
    if (this.runningCompetitions != null) {
      data['runningCompetitions'] =
          this.runningCompetitions!.map((v) => v.toJson()).toList();
    }
    if (this.contract != null) {
      data['contract'] = this.contract!.toJson();
    }
    return data;
  }
}

class Area {
  int? id;
  String? name;
  String? code;
  String? flag;

  Area({this.id, this.name, this.code, this.flag});

  Area.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['flag'] = this.flag;
    return data;
  }
}

class RunningCompetitions {
  int? id;
  String? name;
  String? code;
  String? type;
  String? emblem;

  RunningCompetitions({this.id, this.name, this.code, this.type, this.emblem});

  RunningCompetitions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    type = json['type'];
    emblem = json['emblem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['type'] = this.type;
    data['emblem'] = this.emblem;
    return data;
  }
}

class Contract {
  String? start;
  String? until;

  Contract({this.start, this.until});

  Contract.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    until = json['until'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['until'] = this.until;
    return data;
  }
}
