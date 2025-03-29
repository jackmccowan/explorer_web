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
      appBar: AppBar(
        leadingWidth: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 80.0),
              child: Image.asset(
                explorerLogo,
                height: 50,
              ),
            ),
            const SizedBox(width: 20),
            Container(
              height: 50,
              child: const VerticalDivider(
                color: Colors.black,
                thickness: 4,
                width: 1,
              ),
            ),
            const SizedBox(width: 32),
            Flexible(
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                indicatorColor: Colors.black,
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: 'Dashboard',),
                  Tab(text: 'Loans'),
                  Tab(text: 'Documents'),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: explorerBlue,
        toolbarHeight: 80,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              // Profile button action
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () => signOut(context),
              icon: const Icon(Icons.logout, color: Colors.white),
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }
}
