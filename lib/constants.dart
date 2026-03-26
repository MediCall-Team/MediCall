import 'package:flutter/material.dart';
import 'package:grad_project/patient/features/home/data/models/category_model.dart';

Color priColor = Color(0xff35AAD5);
Color secColor = Color(0xff1F3E6C);

const kPrimaryColorA = Color(0xfff5f5f5);
const kPrimaryColorB = Color(0xff35aad5);
const kPrimaryColorC = Color(0xff1F3E6C);
const kPrimaryColorD = Color(0xffE1F2F8);
const kPrimaryColorE = Color(0xff6E6565);

const List<String> specialtiesConstList = [
  'جلدية',
  'أطفال',
  'عظام',
  "أمراض باطنه"
      "علاج طبيعي"
      "تمريض منزلي",
  'قلب',
  'أسنان',
];

List<CategoryModel> categoriesList = [
  CategoryModel(
    name: "أمراض باطنه",
    icon: "assets/images/internal_medicin.png",
  ),
  CategoryModel(name: "علاج طبيعي", icon: "assets/images/physical.png"),
  CategoryModel(name: 'عظام', icon: "assets/images/bones.png"),
  CategoryModel(name: 'جلدية', icon: "assets/images/skin.png"),
  CategoryModel(name: "تمريض منزلي", icon: "assets/images/nursing.png"),
  CategoryModel(name: "المزيد", icon: "assets/images/Plus.png"),

  //
];
List<String> sohagCenters = [
  "سوهاج",
  "أخميم",
  "البلينا",
  "جرجا",
  "دار السلام",
  "جهينة",
  "ساقلته",
  "طما",
  "طهطا",
  "المراغة",
  "المنشأة",
  "العسيرات",
];
