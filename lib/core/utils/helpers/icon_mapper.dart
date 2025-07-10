import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/widgets.dart';

class IconMapper {
  static const Map<String, IconData> iconMap = {
    // EXPENSE CATEGORIES
    'shopping': FontAwesomeIcons.bagShopping,
    'food': FontAwesomeIcons.utensils,
    'transport': FontAwesomeIcons.bus,
    'health': FontAwesomeIcons.heartPulse,
    'entertainment': FontAwesomeIcons.film,
    'bills': FontAwesomeIcons.fileInvoiceDollar,
    'education': FontAwesomeIcons.graduationCap,
    'clothing': FontAwesomeIcons.shirt,
    'home': FontAwesomeIcons.house,
    'travel': FontAwesomeIcons.plane,
    'gift': FontAwesomeIcons.gift,
    'subscriptions': FontAwesomeIcons.spotify,
    'pets': FontAwesomeIcons.dog,
    'charity': FontAwesomeIcons.handHoldingHeart,
    'others_expense': FontAwesomeIcons.circleQuestion,

    // INCOME CATEGORIES
    'salary': FontAwesomeIcons.moneyBill,
    'bonus': FontAwesomeIcons.handHoldingDollar,
    'freelance': FontAwesomeIcons.laptopCode,
    'investment': FontAwesomeIcons.chartLine,
    'rental': FontAwesomeIcons.building,
    'sale': FontAwesomeIcons.tags,
    'refund': FontAwesomeIcons.rotateLeft,
    'others_income': FontAwesomeIcons.circleQuestion,
  };

  static IconData getIcon(String key) {
    return iconMap[key] ?? FontAwesomeIcons.circleQuestion;
  }
}
