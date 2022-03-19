import 'package:flutter/material.dart';
import 'package:laugh1/constants/constants.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;
  final List<IconData> iconList;

  CustomBottomNavigationBar(
      {required this.defaultSelectedIndex,
      required this.iconList,
      required this.onChange});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  List<IconData> _iconList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _selectedIndex = widget.defaultSelectedIndex;
    _iconList = widget.iconList;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _navBarItemList = [];

    for (var i = 0; i < _iconList.length; i++) {
      _navBarItemList.add(buildNavBarItem(_iconList[i], i));
    }

    return Row(
      children: _navBarItemList,
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        widget.onChange(index);
        setState(() {
          _selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 300),
        height: 60,
        width: MediaQuery.of(context).size.width / _iconList.length,
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width / _iconList.length,
          decoration: index == _selectedIndex
              ? BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 4, color: Constants.primaryColor),
                  ),

                  // color: index == _selectedItemIndex ? Colors.green : Colors.white,
                )
              : BoxDecoration(),
          child: Icon(
            icon,
            color:
                index == _selectedIndex ? Constants.primaryColor : Colors.grey,
          ),
        ),
      ),
    );
  }
}
