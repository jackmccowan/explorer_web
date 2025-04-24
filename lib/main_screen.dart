import 'package:explorer_web/components/nav_card.dart';
import 'package:flutter/material.dart';
import 'package:explorer_web/utils.dart';
import 'package:explorer_web/colors.dart';
import 'package:explorer_web/pages/dashboard_page.dart';
import 'package:explorer_web/pages/loans_page.dart';
import 'package:explorer_web/pages/documents_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const LoansPage(),
    const DocumentsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
          child: AppBar(
            backgroundColor: Colors.white,
            shadowColor: Colors.black,
            elevation: 5,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Image.asset(
                    explorerLogo,
                    height: 30,
                  ),
                ),
                Flexible(
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    tabs: const [
                      Tab(text: 'EXPLORER 500',),
                      Tab(text: 'TRAVEL LOANS'),
                      Tab(text: 'PLANNING YOUR TRIP'),
                      Tab(text: 'AMBASSADORS'),
                      Tab(text: 'INVESTORS'),
                      Tab(text: 'GET TRAVELLING'),
                    ],
                  ),
                ),
              ],
            ),
            toolbarHeight: 60,
            actions: [
              IconButton(
                icon: const Icon(Icons.person, color: explorerBlue),
                onPressed: () {
                  // Profile button action
                },
              ),
              SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.only(right: 60.0),
                child: IconButton(
                  onPressed: () => signOut(context),
                  icon: const Icon(Icons.logout, color: explorerBlue),
                ),
              ),
            ],
          ),
        ),
      ),

     body: Row(
        children: [
          Container(
            width: 142,
            child: Padding(
              padding: const EdgeInsets.only(left: 22.0, top: 32),
              child: Column(
                children: [
                  NavCard(
                    logo: homeLogo,
                    text: 'Home',
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                    selected: _selectedIndex == 0,
                  ),
                  NavCard(
                    logo: homeLogo,
                    text: 'Loans',
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    selected: _selectedIndex == 1,
                  ),
                  NavCard(
                    logo: homeLogo, 
                    text: 'Documents',
                    onTap: () {
                      setState(() {
                        _selectedIndex = 2; 
                      });
                    },
                    selected: _selectedIndex == 2,
                  ),
                  NavCard(
                    logo: homeLogo, 
                    text: 'Settings',
                    onTap: () {
                    },
                    selected: _selectedIndex == 3,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _pages[_selectedIndex],
          ),
    ]));
  }
}
