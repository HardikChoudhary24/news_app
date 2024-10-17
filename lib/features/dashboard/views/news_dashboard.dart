import 'package:flutter/material.dart';
import 'package:junglee_news/features/dashboard/views/widgets/bottom_navbar/bottom_navbar.dart';
import 'package:junglee_news/resources/app_state_provider.dart';
import 'package:provider/provider.dart';

class NewsDashboard extends StatelessWidget {
  const NewsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Consumer<AppStateProvider>(
            builder: (context, appStateProvider, child) {
          return appStateProvider.getActiveDashboardView();
        }),
        bottomNavigationBar: const BottomNavbar(),
        backgroundColor: Colors.white,
      ),
    );
  }
}
