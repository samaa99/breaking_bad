class Characters {
  late int actorId;
  late String actorSeriesName;
  late List actorJobs;
  late String actorImage;
  late String actorStatus;
  late String actorNickName;
  late List actorApperanceBreacking;
  late String actorName;
  late String categoryForTwoSeries;
  late List actorApperanceBetterCall;

  Characters.fromJson(Map<String, dynamic> json) {
    this.actorId = json['char_id'];
    this.actorSeriesName = json['name'];
    this.actorJobs = json['occupation'];
    this.actorImage = json['img'];
    this.actorStatus = json['status'];
    this.actorNickName = json['nickname'];
    this.actorApperanceBreacking = json['appearance'];
    this.actorName = json['portrayed'];
    this.categoryForTwoSeries = json['category'];
    this.actorApperanceBetterCall = json['better_call_saul_appearance'];
  }
}
