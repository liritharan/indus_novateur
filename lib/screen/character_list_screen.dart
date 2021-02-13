import 'package:indus_task/widget/character_list_view.dart';
import 'package:indus_task/widget/employee_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CharacterListScreen extends StatefulWidget {
  @override
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  int _selectedBottomNavigationIndex = 0;

  final List<_BottomNavigationItem> _bottomNavigationItems = [
    _BottomNavigationItem(
      label: 'Pull to Refresh',
      iconData: Icons.refresh,
      widgetBuilder: (context) => CharacterListView(),
    ),
    _BottomNavigationItem(
      label: 'ListView',
      iconData: Icons.format_list_bulleted_outlined,
      widgetBuilder: (context) => EmployeeScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Pagination Listview'),
        ),
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedBottomNavigationIndex,
          items: _bottomNavigationItems
              .map(
                (item) => BottomNavigationBarItem(
                  icon: Icon(item.iconData),
                  label: item.label,
                ),
              )
              .toList(),
          onTap: (newIndex) => setState(
            () => _selectedBottomNavigationIndex = newIndex,
          ),
        ),
        body: IndexedStack(
          index: _selectedBottomNavigationIndex,
          children: _bottomNavigationItems
              .map(
                (item) => item.widgetBuilder(context),
              )
              .toList(),
        ),
      );
}

class _BottomNavigationItem {
  const _BottomNavigationItem({
    @required this.label,
    @required this.iconData,
    @required this.widgetBuilder,
  })  : assert(label != null),
        assert(iconData != null),
        assert(widgetBuilder != null);

  final String label;
  final IconData iconData;
  final WidgetBuilder widgetBuilder;
}
