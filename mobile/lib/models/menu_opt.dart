import 'dart:convert';

List<MenuOpt> menuFromJson(String str) =>
    List<MenuOpt>.from(json.decode(str).map((x) => MenuOpt.fromJson(x)));

class MenuOpt {
  MenuOpt({
    required this.icon,
    required this.label,
    this.url,
    required this.subitems,
  });

  String icon;
  String label;
  String? url;
  List<Subitem> subitems;

  factory MenuOpt.fromJson(Map<String, dynamic> json) => MenuOpt(
        icon: json["icon"],
        label: json["label"],
        url: json["url"],
        subitems: List<Subitem>.from(
            json["subitems"].map((x) => Subitem.fromJson(x))),
      );
}

class Subitem {
  Subitem({
    required this.label,
    required this.url,
  });

  String label;
  String url;

  factory Subitem.fromJson(Map<String, dynamic> json) => Subitem(
        label: json["label"],
        url: json["url"],
      );
}
