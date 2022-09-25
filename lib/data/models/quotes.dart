class Quote {
  late String quote;

  Quote.fromJson(Map<String, dynamic> json) {
    this.quote = json['quote'];
  }
}
