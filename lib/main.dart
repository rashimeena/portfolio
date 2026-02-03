// lib/main.dart
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/constants.dart';
import 'widgets/navbar.dart';
import 'sections/home_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${AppStrings.name} • Portfolio',
      theme: AppTheme.light(),
      debugShowCheckedModeBanner: false,
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  // Create GlobalKeys for each section so we can scroll to them
  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  final projectsKey = GlobalKey();
  final contactKey = GlobalKey();

  Future<void> scrollTo(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      alignment: 0.0, // aligns top of section to top of viewport
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(68),
        child: NavBar(
          onItemSelected: (id) {
            switch (id) {
              case 'home':
                scrollTo(homeKey);
                break;
              case 'about':
                scrollTo(aboutKey);
                break;
              case 'skills':
                scrollTo(skillsKey);
                break;
              case 'projects':
                scrollTo(projectsKey);
                break;
              case 'contact':
                scrollTo(contactKey);
                break;
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Wrap each section with a container that has the GlobalKey
            Container(
              key: homeKey,
              child: HomeSection(
                onContactTap: () => scrollTo(contactKey),
                onProjectsTap: () => scrollTo(projectsKey),
              ),
            ),

            Container(key: aboutKey, child: const AboutSection()),
            Container(key: skillsKey, child: const SkillsSection()),
            Container(key: projectsKey, child: const ProjectsSection()),
            Container(key: contactKey, child: const ContactSection()),
          ],
        ),
      ),
    );
  }
}
