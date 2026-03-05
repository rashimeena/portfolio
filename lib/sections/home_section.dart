// lib/sections/home_section.dart
// Enhanced hero section with neon glow effects and theme-consistent styling
import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/animated_background.dart';
import '../core/utils/constants.dart';
import '../widgets/custom_button.dart';

class HomeSection extends StatefulWidget {
  final VoidCallback onContactTap;
  final VoidCallback onProjectsTap;

  const HomeSection({
    super.key,
    required this.onContactTap,
    required this.onProjectsTap,
  });

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  bool _isImageHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final neonBlue = theme.colorScheme.primary;

    return Stack(
      children: [
        const Positioned.fill(child: AnimatedBackground()),
       Container(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 28),
        constraints: BoxConstraints(minHeight: size.height * 0.8),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // LEFT: Text column with enhanced styling
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Name with neon glow
                      _buildGlowingText(
                        AppStrings.name,
                        theme.textTheme.displayLarge!,
                        neonBlue,
                        isTitle: true,
                      ),
                      const SizedBox(height: 8),
                      
                      // Role with animated underline
                      _buildRoleText(
                        AppStrings.role,
                        theme.textTheme.displayMedium!,
                        neonBlue,
                      ),
                      const SizedBox(height: 18),
                      
                      // Description text
                      Text(
                        AppStrings.heroSubtitle,
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 32),
                      
                      // Buttons row
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          CustomButton(
                            label: 'Contact Me',
                            onPressed: widget.onContactTap,
                          ),
                          CustomButton(
                            label: 'View Projects',
                            onPressed: widget.onProjectsTap,
                            isPrimary: false, // Green glow
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
      
                // RIGHT: Profile image with neon glow
                if (size.width > 900)
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 28),
                      child: _buildProfileImage(neonBlue),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      ],
    );
  }

  /// Build name text with glowing effect
  Widget _buildGlowingText(
    String text,
    TextStyle baseStyle,
    Color glowColor, {
    bool isTitle = false,
  }) {
    return Text(
      text,
      style: baseStyle.copyWith(
        shadows: [
          // Inner glow
          Shadow(
            color: glowColor.withValues(alpha: 0.6),
            blurRadius: isTitle ? 20 : 15,
          ),
          // Outer glow (softer, wider)
          Shadow(
            color: glowColor.withValues(alpha: 0.3),
            blurRadius: isTitle ? 40 : 30,
          ),
        ],
      ),
    );
  }

  /// Build role text with neon underline
  Widget _buildRoleText(
    String text,
    TextStyle baseStyle,
    Color accentColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: baseStyle.copyWith(
            color: accentColor,
            shadows: [
              Shadow(
                color: accentColor.withValues(alpha: 0.5),
                blurRadius: 15,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Animated neon underline
        Container(
          height: 3,
          width: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                accentColor,
                accentColor.withValues(alpha: 0.0),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: accentColor.withValues(alpha: 0.5),
                blurRadius: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build profile image with interactive neon glow
  Widget _buildProfileImage(Color neonBlue) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isImageHovered = true),
      onExit: (_) => setState(() => _isImageHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          // Outer neon glow
          boxShadow: [
            BoxShadow(
              color: neonBlue.withValues(
                alpha: _isImageHovered ? 0.6 : 0.3,
              ),
              blurRadius: _isImageHovered ? 40 : 25,
              spreadRadius: _isImageHovered ? 5 : 0,
            ),
            // Secondary glow for depth
            BoxShadow(
              color: neonBlue.withValues(alpha: 0.2),
              blurRadius: _isImageHovered ? 60 : 45,
              spreadRadius: _isImageHovered ? 10 : 5,
            ),
          ],
        ),
        child: AspectRatio(
          aspectRatio: 4 / 5,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              // Neon border
              border: Border.all(
                color: neonBlue.withValues(
                  alpha: _isImageHovered ? 0.8 : 0.5,
                ),
                width: _isImageHovered ? 3 : 2,
              ),
              // Subtle inner glow
              boxShadow: [
                BoxShadow(
                  color: neonBlue.withValues(alpha: 0.1),
                  blurRadius: 20,
                  spreadRadius: -5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14), // Slightly smaller for border
              child: Image.asset(
                'assets/images/profile.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}