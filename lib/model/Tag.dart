
import 'package:flutter/foundation.dart';

class Tag {
  final String name;
  final Type type;

  Tag({required this.name, required this.type});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type' : type.index,
    };
  }

  factory Tag.fromJson(json) {
    return Tag(
      name: json['name'],
      type: Type.values.elementAt(json['type']),
    );
  }

  @override
  String toString() {
    return 'Tag{ name: $name, type: $type }';
  }
}

enum Type { TAG, PLANNING_TAG }
