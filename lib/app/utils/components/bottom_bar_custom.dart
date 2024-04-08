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
    '/home',
    '/fraseDia',
    '/profile',
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Modular.to.navigate(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    // return BottomSheet(
    //   onClosing: () {},
    //   builder: (context) {
    //     return ClipRRect(
    //       borderRadius: const BorderRadius.only(
    //         topLeft: Radius.circular(32),
    //         topRight: Radius.circular(32),
    //       ),
    //       child: Container(
    //         decoration: BoxDecoration(
    //           boxShadow: [
    //             BoxShadow(
    //               color: CustomColor.preto.withOpacity(0.2),
    //               spreadRadius: 15,
    //               blurRadius: 17,
    //               offset: const Offset(10, 9), // changes position of shadow
    //             ),
    //           ],
    //         ),
    return BottomNavigationBar(
      backgroundColor: CustomColor.backgroundColor,
      selectedItemColor: CustomColor.verde,
      unselectedItemColor: Colors.grey,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Frase do dia',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex, // Garanta que essa variável está definida em sua classe
      onTap: _onItemTapped, // E essa função também
      //   ),
      // ),
    );
    //   },
    // );
  }
}
  // return BottomNavigationBar(
  //     backgroundColor: CustomColor.backgroundColor,
  //     selectedItemColor: CustomColor.verde,
  //     items: const <BottomNavigationBarItem>[
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.home),
  //         label: 'Home',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.search),
  //         label: 'Search',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.account_circle),
  //         label: 'Profile',
  //       ),
  //     ],
  //     currentIndex: _selectedIndex,
  //     onTap: _onItemTapped,
  //   );