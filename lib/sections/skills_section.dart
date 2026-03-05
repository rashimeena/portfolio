// lib/sections/skills_section_enhanced.dart
// Enhanced Skills section with interactive scaling chips and neon effects
import 'package:flutter/material.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  String? _hoveredSkill;

  // Categorized skills for better organization
  final Map<String, List<String>> skillCategories = const {
    'Mobile Development': [
      'Flutter',
      'Dart',
      'Android Studio',
      'Jetpack Compose',
      'Kotlin',
    ],
    'State Management & Backend': [
      'Riverpod',
      'Provider',
      'Firebase',
      'REST APIs',
    ],
    'Programming Languages': [
      'Java',
      'CPP',
      'Dart',
    ],
    'Web & Design': [
      'HTML',
      'CSS',
      'Javascript',
      'UI/UX',
    ],
    'Tools & Other': [
      'Git & GitHub',
      'DSA',
    ],
  };

  // Flat list for simple display (use this if you prefer all skills together)
  final List<String> allSkills = const [
    'Flutter',
    'Dart',
    'Firebase',
    'Riverpod',
    'Provider',
    'REST APIs',
    'UI/UX',
    'Git & GitHub',
    'Java',
    'DSA',
    'CPP',
    'Android Studio',
    'Jetpack Compose',
    'Kotlin',
    'HTML',
    'CSS',
    'Javascript',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final neonBlue = theme.colorScheme.primary;
    final neonGreen = theme.colorScheme.secondary;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 28),
      color: theme.scaffoldBackgroundColor,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Section title with glow
              _buildSectionTitle('Skills', neonBlue),
              const SizedBox(height: 60),

              // All skills in one grid (simple version)
              _buildSkillsGrid(allSkills, neonBlue, neonGreen),
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

  /// Build skills grid with interactive chips
  Widget _buildSkillsGrid(
    List<String> skills,
    Color neonBlue,
    Color neonGreen,
  ) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: skills.asMap().entries.map((entry) {
        final index = entry.key;
        final skill = entry.value;
        // Alternate colors for variety
        final color = index % 2 == 0 ? neonBlue : neonGreen;
        return _buildSkillChip(skill, color);
      }).toList(),
    );
  }

  /// Interactive skill chip that scales on hover
  Widget _buildSkillChip(String skill, Color accentColor) {
    final isHovered = _hoveredSkill == skill;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredSkill = skill),
      onExit: (_) => setState(() => _hoveredSkill = null),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        // Transform scale on hover
        transform: Matrix4.identity()
          ..scale(isHovered ? 1.15 : 1.0), // 15% larger on hover
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            // Semi-transparent background
            color: accentColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(30), // Pill shape
            border: Border.all(
              color: accentColor.withValues(
                alpha: isHovered ? 0.8 : 0.4,
              ),
              width: isHovered ? 2 : 1.5,
            ),
            // Neon glow effect
            boxShadow: [
              BoxShadow(
                color: accentColor.withValues(
                  alpha: isHovered ? 0.6 : 0.2,
                ),
                blurRadius: isHovered ? 20 : 10,
                spreadRadius: isHovered ? 2 : 0,
              ),
            ],
          ),
          child: Text(
            skill,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isHovered ? accentColor : Colors.white70,
              letterSpacing: 0.5,
              // Text glow on hover
              shadows: isHovered
                  ? [
                      Shadow(
                        color: accentColor.withValues(alpha: 0.5),
                        blurRadius: 10,
                      ),
                    ]
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}