// lib/sections/about_section_enhanced.dart
// Enhanced About section with neon theme and interactive elements
import 'package:flutter/material.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  int? _hoveredCardIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final neonBlue = theme.colorScheme.primary;
    final neonGreen = theme.colorScheme.secondary;
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 28),
      color: theme.scaffoldBackgroundColor, // Dark background
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Section title with glow
              _buildSectionTitle("About Me", neonBlue),
              const SizedBox(height: 60),

              // Main content layout
              size.width > 900
                  ? _buildDesktopLayout(theme, neonBlue, neonGreen)
                  : _buildMobileLayout(theme, neonBlue, neonGreen),
            ],
          ),
        ),
      ),
    );
  }

  /// Section title with neon glow effect
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
        // Decorative underline
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

  /// Desktop layout (side by side)
  Widget _buildDesktopLayout(
    ThemeData theme,
    Color neonBlue,
    Color neonGreen,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: Main description card
        Expanded(
          flex: 6,
          child: _buildDescriptionCard(theme, neonBlue),
        ),
        const SizedBox(width: 40),
        // Right: Info cards
        Expanded(
          flex: 4,
          child: _buildInfoCards(neonBlue, neonGreen),
        ),
      ],
    );
  }

  /// Mobile layout (stacked)
  Widget _buildMobileLayout(
    ThemeData theme,
    Color neonBlue,
    Color neonGreen,
  ) {
    return Column(
      children: [
        _buildDescriptionCard(theme, neonBlue),
        const SizedBox(height: 40),
        _buildInfoCards(neonBlue, neonGreen),
      ],
    );
  }

  /// Main description card with neon border
  Widget _buildDescriptionCard(ThemeData theme, Color neonBlue) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: neonBlue.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: neonBlue.withValues(alpha: 0.15),
            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting with icon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: neonBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: neonBlue.withValues(alpha: 0.3),
                  ),
                ),
                child: Icon(
                  Icons.waving_hand,
                  color: neonBlue,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  "Hi, I'm Rashi Meena",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: neonBlue,
                    shadows: [
                      Shadow(
                        color: neonBlue.withValues(alpha: 0.4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Description text
          Text(
            "I'm a third-year Computer Science student at RGPV who loves building meaningful digital products through code. I enjoy creating mobile and web applications that feel simple, intuitive, and reliable, focusing on both the user experience and the logic behind it.",
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 16,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Curious by nature and driven by constant learning, I like exploring how ideas turn into real-world applications, improving performance, refining design, and solving problems along the way. My goal is to build digital experiences that are not just functional, but genuinely useful and impactful.",
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 16,
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }

  /// Info cards (education, interests, etc.)
  Widget _buildInfoCards(Color neonBlue, Color neonGreen) {
    final cards = [
      {
        'icon': Icons.school_outlined,
        'title': 'Education',
        'content': 'B.Tech in CSBS\nRGPV University\n2023 - 2027',
        'color': neonBlue,
      },
      {
        'icon': Icons.location_on_outlined,
        'title': 'Location',
        'content': 'Bhopal, India',
        'color': neonGreen,
      },
      {
        'icon': Icons.interests_outlined,
        'title': 'Interests',
        'content': 'Mobile Dev, UI/UX\nProblem Solving',
        'color': neonBlue,
      },
    ];

    return Column(
      children: List.generate(
        cards.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: _buildInfoCard(
            icon: cards[index]['icon'] as IconData,
            title: cards[index]['title'] as String,
            content: cards[index]['content'] as String,
            color: cards[index]['color'] as Color,
            index: index,
          ),
        ),
      ),
    );
  }

  /// Individual info card with hover effect
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
    required Color color,
    required int index,
  }) {
    final isHovered = _hoveredCardIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredCardIndex = index),
      onExit: (_) => setState(() => _hoveredCardIndex = null),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Color(0xFF11182F), // Card color from theme
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(
              alpha: isHovered ? 0.6 : 0.3,
            ),
            width: isHovered ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(
                alpha: isHovered ? 0.4 : 0.15,
              ),
              blurRadius: isHovered ? 25 : 15,
              spreadRadius: isHovered ? 2 : 0,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon with glow
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: color.withValues(alpha: 0.3),
                ),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: color,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Color(0xFFB0BEC5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}