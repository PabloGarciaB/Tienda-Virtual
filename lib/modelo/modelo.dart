class Modelo {
  String? first;
  String? last;
  String? email;
  String? address;
  String? created;
  String? balance;

  Modelo(
      {this.first,
      this.last,
      this.email,
      this.address,
      this.created,
      this.balance});

  factory Modelo.fromJson(Map<String, dynamic> json) {
    return Modelo(
        first: json['first'],
        last: json['last'],
        email: json['email'],
        address: json['address'],
        created: json['created'],
        balance: json['balance']);
  }
}
