import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ContactUtils {
  static const List<IconData> contactIcon = [
    Iconsax.location,
    Iconsax.call,
    Iconsax.sms,
    Iconsax.messages_2,
  ];

  static const List<String> titles = [
    "Location",
    "Phone",
    "Email",
    "WhatsApp",
  ];

  static const List<String> details = [
    "Uttara, Dhaka, Bangladesh",
    "+8801787816047",
    "kabirhossenbd1971@gmail.com",
    "+8801787816047",
  ];

  static const List<String> links = [
    "https://maps.google.com/?q=Uttara,Dhaka",
    "tel:+8801787816047",
    "mailto:kabirhossenbd1971@gmail.com",
    "https://wa.me/+8801787816047",
  ];
}
