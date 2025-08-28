class BottomNavigationbarEntety {
  final String activimag;
  final String inactivimag;
  final String name;

  BottomNavigationbarEntety({
    required this.activimag,
    required this.inactivimag,
    required this.name,
  });
}

List<BottomNavigationbarEntety> get bottomNavigationbarEntetie => [
  BottomNavigationbarEntety(
    activimag: "assets/fillters.svg",
    inactivimag: "assets/fillters.svg",
    name: "الرئيسيه",
  ),
  BottomNavigationbarEntety(
    activimag: "assets/fillters.svg",
    inactivimag: "assets/fillters.svg",
    name: "المنتجات",
  ),
  BottomNavigationbarEntety(
    activimag: "assets/fillters.svg",
    inactivimag: "assets/fillters.svg",
    name: "سلة التسوق",
  ),
  BottomNavigationbarEntety(
    activimag: "assets/fillters.svg",
    inactivimag: "assets/fillters.svg",
    name: "الشخصيه",
  ),
];
