// ignore_for_file: unnecessary_this

class Transaction {

  final String? name;
  final String? amount;
  final bool? isUp;
  final String? comment;
  final int? icon;
  final String? date;
  final String? id;

Transaction({
       required this.name,
       required this.amount,
       required this.isUp,
       required this.comment,
       required this.icon,
       required this.date,
       required this.id
});  

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    name: json["name"],
    amount : json["amount"],
    isUp : json["isUp"],
    comment : json["comment"],
    icon : json["icon"],
    date : json["date"],
    id : json["id"]
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['isUp'] = this.isUp;
    data['comment'] = this.comment;
    data['icon'] = this.icon;
    data['date'] = this.date;
    data['id'] = this.id;
    return data;
  }
}
