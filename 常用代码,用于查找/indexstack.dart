class Tabbar extends StatefulWidget {
  Tabbar({this.screens});

  static const Tag = "Tabbar";
  final List<Widget> screens;
  @override
  State<StatefulWidget> createState() {
    return _TabbarState();
  }
}

class _TabbarState extends State<Tabbar> {
  int _currentIndex = 0;
  Widget currentScreen;

  @override
  Widget build(BuildContext context) {
    var _l10n = PackedLocalizations.of(context);

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: widget.screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.format_list_bulleted),
            title: new Text(_l10n.tripsTitle),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.settings),
            title: new Text(_l10n.settingsTitle),
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}