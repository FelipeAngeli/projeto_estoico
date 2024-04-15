import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_estoico/app/utils/custom_color.dart';

class BottomBarCustom extends StatefulWidget {
  const BottomBarCustom({super.key});

  @override
  State<BottomBarCustom> createState() => _BottomBarCustomState();
}

class _BottomBarCustomState extends State<BottomBarCustom> {
  int _selectedIndex = 0;

  final List<String> _routes = [
    '/search',
    '/fraseDia',
    '/profile',
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      // const Duration(milliseconds: 200);
      // Curves.easeInOut;
      Modular.to.navigate(_routes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: CustomColor.backgroundColor,
      selectedItemColor: CustomColor.verde,
      unselectedItemColor: Colors.grey,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Pesquisar Frases',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_outlined),
          label: 'Frase do dia',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Perfil',
        ),
      ],
    );
  }
}
