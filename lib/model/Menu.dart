
import 'package:recipify/model/Recipe.dart';

class Menu {
  int? id;
  DateTime day;
  Recipe? breakfast;
  Recipe? lunch;
  Recipe? dinner;

  Menu({this.id, required this.day, this.breakfast, this.lunch, this.dinner});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'day': _simpleDate(day),
      'breakfast_id' : breakfast != null ? breakfast!.id : 0,
      'lunch_id' : lunch != null ? lunch!.id : 0,
      'dinner_id' : dinner != null ? dinner!.id : 0
    };
  }


  factory Menu.fromMap(Map<String, dynamic> map) {
    return Menu(
      id: map['id'],
      day: fromSimpleDate(map['day']),
      breakfast : Recipe.fromMap(map, prefix: 'breakfast_'),
      lunch : Recipe.fromMap(map, prefix: 'lunch_'),
      dinner : Recipe.fromMap(map, prefix: 'dinner_'),
    );
  }

  String? getWeekday() {
    switch (day.weekday) {
      case 1: {return 'Monday';}
      case 2: {return 'Tuesday';}
      case 3: {return 'Wednesday';}
      case 4: {return 'Thursday';}
      case 5: {return 'Friday';}
      case 6: {return 'Saturday';}
      case 7: {return 'Sunday';}
      default: { return 'Wednesday';}
    }
  }

  String? getDisplayDate() {
    return _simpleDate(day).split("-").reversed.join(".");
  }

  @override
  String toString() {
    return 'Menu{\n\tid: \t$id, \n\tday: \t$day, \n\tbreakfast: \t$breakfast, \n\tlunch: \t\t$lunch, \n\tdinner: \t$dinner\n}';
  }

}

String _simpleDate(DateTime time) {
  return time.toIso8601String().substring(0, 10);
}


DateTime fromSimpleDate(String simpleDate) {
  return DateTime.parse(simpleDate);
}

