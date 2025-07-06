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
    'gifts': FontAwesomeIcons.gift,
    'subscription': FontAwesomeIcons.spotify,
    'pets': FontAwesomeIcons.dog,
    'others_expense': FontAwesomeIcons.ellipsis,

    // INCOME CATEGORIES
    'salary': FontAwesomeIcons.moneyBill,
    'bonus': FontAwesomeIcons.handHoldingDollar,
    'freelance': FontAwesomeIcons.laptopCode,
    'investment': FontAwesomeIcons.chartLine,
    'rental_income': FontAwesomeIcons.building,
    'gift_received': FontAwesomeIcons.gift,
    'sale': FontAwesomeIcons.tags,
    'refund': FontAwesomeIcons.rotateLeft,
    'others_income': FontAwesomeIcons.coins,
  };

  static IconData getIcon(String key) {
    return iconMap[key] ?? FontAwesomeIcons.circleQuestion;
  }
}
