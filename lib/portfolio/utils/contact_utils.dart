import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/models/portfolio_models.dart';

class ContactUtils {
  static const List<ContactItem> items = [
    ContactItem(
      title: "Location",
      detail: "Uttara, Dhaka, Bangladesh",
      link: "https://maps.google.com/?q=Uttara,Dhaka",
      icon: Icons.location_on_outlined,
    ),
    ContactItem(
      title: "Phone",
      detail: "+8801787816047",
      link: "tel:+8801787816047",
      icon: Icons.call_outlined,
    ),
    ContactItem(
      title: "Email",
      detail: "kabirhossenbd1971@gmail.com",
      link: "mailto:kabirhossenbd1971@gmail.com",
      icon: Icons.mail_outline_rounded,
    ),
    ContactItem(
      title: "WhatsApp",
      detail: "+8801787816047",
      link: "https://wa.me/8801787816047",
      icon: Icons.chat_bubble_outline_rounded,
    ),
  ];

  static List<IconData> get contactIcon => items.map((i) => i.icon).toList();
  static List<String> get titles => items.map((i) => i.title).toList();
  static List<String> get details => items.map((i) => i.detail).toList();
  static List<String> get links => items.map((i) => i.link).toList();
}
