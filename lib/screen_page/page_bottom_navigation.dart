import 'package:flutter/material.dart';
import 'package:project_latihan_kampus/screen_page/page_home.dart';
import 'package:project_latihan_kampus/screen_page/page_maps.dart';
import '../../utils/session_manager.dart';

class PageBottomNavigationBar extends StatefulWidget {
  const PageBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<PageBottomNavigationBar> createState() =>
      _PageBottomNavigationBarState();
}

class _PageBottomNavigationBarState extends State<PageBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late SessionManager sessionManager;

  @override
  void initState() {
    super.initState();
    sessionManager = SessionManager();
    sessionManager.getSession();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: [
          HomeScreen(),
          MapsFlutter(latitude: 0.0, longitude: 0.0, namaKampus: 'Kampus'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabController.index,
        onTap: (index) {
          tabController.animateTo(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Ikon untuk Berita
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map), // Ikon untuk Profil
            label: 'Maps',
          ),
        ],
      ),
    );
  }
}
