// To parse this JSON data, do
//
//     final policy = policyFromJson(jsonString);

import 'dart:convert';

Policy policyFromJson(String str) => Policy.fromJson(json.decode(str));

String policyToJson(Policy data) => json.encode(data.toJson());

class Policy {
  Policy({
    this.policyNumber,
    this.title,
    this.subtitle,
    this.type,
    this.imageUrl,
  });

  int policyNumber;
  String title;
  String subtitle;
  String type;
  String imageUrl;

  factory Policy.fromJson(Map<String, dynamic> json) => Policy(
        policyNumber: json["policy_number"],
        title: json["title"],
        subtitle: json["subtitle"],
        type: json["type"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "policy_number": policyNumber,
        "title": title,
        "subtitle": subtitle,
        "type": type,
        "image_url": imageUrl,
      };
}
