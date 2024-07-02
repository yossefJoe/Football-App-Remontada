class Teams {
  String? strTeam;
  String? strAlternate;
  String? intFormedYear;
  String? strSport;
  String? strLeague;
  String? strStadium;
  String? strStadiumLocation;
  String? intStadiumCapacity;
  String? strWebsite;
  String? strFacebook;
  String? strTwitter;
  String? strInstagram;
  String? strDescriptionEN;
  String? strGender;
  String? strCountry;
  String? strTeamBadge;
  String? strTeamLogo;
  String? strYoutube;

  Teams({
    this.strTeam,
    this.strAlternate,
    this.intFormedYear,
    this.strSport,
    this.strLeague,
    this.strStadium,
    this.strStadiumLocation,
    this.intStadiumCapacity,
    this.strWebsite,
    this.strFacebook,
    this.strTwitter,
    this.strInstagram,
    this.strDescriptionEN,
    this.strGender,
    this.strCountry,
    this.strTeamBadge,
    this.strTeamLogo,
    this.strYoutube,
  });

  Teams.fromJson(Map<String, dynamic> json) {
    strTeam = json['strTeam'];
    strAlternate = json['strAlternate'];
    intFormedYear = json['intFormedYear'];
    strSport = json['strSport'];
    strLeague = json['strLeague'];
    strStadium = json['strStadium'];
    strStadiumLocation = json['strStadiumLocation'];
    intStadiumCapacity = json['intStadiumCapacity'];
    strWebsite = json['strWebsite'];
    strFacebook = json['strFacebook'];
    strTwitter = json['strTwitter'];
    strInstagram = json['strInstagram'];
    strDescriptionEN = json['strDescriptionEN'];
    strGender = json['strGender'];
    strCountry = json['strCountry'];
    strTeamBadge = json['strTeamBadge'];
    strTeamLogo = json['strTeamLogo'];
    strYoutube = json['strYoutube'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strTeam'] = this.strTeam;
    data['strAlternate'] = this.strAlternate;
    data['intFormedYear'] = this.intFormedYear;
    data['strSport'] = this.strSport;
    data['strLeague'] = this.strLeague;
    data['strStadium'] = this.strStadium;
    data['strStadiumLocation'] = this.strStadiumLocation;
    data['intStadiumCapacity'] = this.intStadiumCapacity;
    data['strWebsite'] = this.strWebsite;
    data['strFacebook'] = this.strFacebook;
    data['strTwitter'] = this.strTwitter;
    data['strInstagram'] = this.strInstagram;
    data['strDescriptionEN'] = this.strDescriptionEN;
    data['strGender'] = this.strGender;
    data['strCountry'] = this.strCountry;
    data['strTeamBadge'] = this.strTeamBadge;
    data['strTeamLogo'] = this.strTeamLogo;
    data['strYoutube'] = this.strYoutube;
    return data;
  }
}
