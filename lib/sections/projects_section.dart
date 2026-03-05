// lib/sections/projects_section.dart
// Simple carousel - compact cards with essential info only
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  late PageController _pageController;
  late Timer _autoPlayTimer;
  int _currentPage = 0;

  final List<Map<String, String>> projects = const [
    {
      "title": "Veerangana - Women Safety App",
      "description":
          "A responsive Flutter app that provides SOS alerts, location sharing, and AI-based assistance for women's safety.",
      "tech": "Flutter, Dart, Firebase, GPS, Gemini",
      "link": "https://play.google.com/store/apps/details?id=com.lucky.veerangana",
    },
    {
      "title": "Training & Placement Cell App",
      "description":
          "Campus T&P application with responsive UI components, API integration, and improved user experience.",
      "tech": "Flutter, REST APIs, UI/UX",
      "link": "",
    },
    {
      "title": "Supplify",
      "description":
          "Inventory management app with graph analytics, category filters, and low-stock alerts.",
      "tech": "Flutter, Analytics, Charts",
      "link": "https://github.com/rashimeena/supplify",
    },
    {
      "title": "Portfolio Website",
      "description":
          "Personal portfolio built with Flutter Web showcasing projects, skills, and experience.",
      "tech": "Flutter Web, Responsive Design",
      "link": "https://github.com/rashimeena/portfolio",
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _autoPlayTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        final nextPage = (_currentPage + 1) % projects.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final neonBlue = theme.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 28),
      color: theme.scaffoldBackgroundColor,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              // Section title
              _buildSectionTitle("Projects", neonBlue),
              const SizedBox(height: 60),

              // Carousel
              SizedBox(
                height: 320,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ProjectCard(
                        title: projects[index]["title"]!,
                        description: projects[index]["description"]!,
                        tech: projects[index]["tech"]!,
                        link: projects[index]["link"]!,
                        neonBlue: neonBlue,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 40),

              // Dot indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  projects.length,
                  (index) => GestureDetector(
                    onTap: () => _goToPage(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: _currentPage == index ? 32 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? neonBlue
                            : neonBlue.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Navigation arrows
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildArrowButton(
                    Icons.arrow_back,
                    () => _goToPage((_currentPage - 1) % projects.length),
                    neonBlue,
                  ),
                  const SizedBox(width: 20),
                  _buildArrowButton(
                    Icons.arrow_forward,
                    () => _goToPage((_currentPage + 1) % projects.length),
                    neonBlue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color glowColor) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2,
            shadows: [
              Shadow(
                color: glowColor.withValues(alpha: 0.6),
                blurRadius: 20,
              ),
              Shadow(
                color: glowColor.withValues(alpha: 0.3),
                blurRadius: 40,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 4,
          width: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                glowColor,
                glowColor.withValues(alpha: 0.0),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: glowColor.withValues(alpha: 0.5),
                blurRadius: 15,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildArrowButton(IconData icon, VoidCallback onTap, Color color) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: color.withValues(alpha: 0.4),
            width: 1.5,
          ),
        ),
        child: Icon(
          icon,
          color: color,
          size: 20,
        ),
      ),
    );
  }
}

/// Simple project card - compact with essential info
class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final String tech;
  final String link;
  final Color neonBlue;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.tech,
    required this.link,
    required this.neonBlue,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: neonBlue.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),

          // Description
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Color(0xFFB0BEC5),
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),

          // Tech stack
          Text(
            'Tech: $tech',
            style: TextStyle(
              fontSize: 13,
              color: neonBlue.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),

          // Link button
          if (link.isNotEmpty)
            GestureDetector(
              onTap: () => _launchURL(link),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: neonBlue.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.link,
                      color: neonBlue,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'View Project',
                      style: TextStyle(
                        fontSize: 14,
                        color: neonBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}