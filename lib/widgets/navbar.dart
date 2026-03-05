// lib/widgets/navbar.dart
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final void Function(String id) onItemSelected;
  final String? currentSection; // Track which section is active

  const NavBar({
    super.key,
    required this.onItemSelected,
    this.currentSection,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String? _hoveredItem;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final neonBlue = theme.colorScheme.primary;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 800;
        
        return Container(
          // Add subtle glow to entire navbar
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            border: Border(
              bottom: BorderSide(
                color: neonBlue.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: neonBlue.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 80, // Make navbar taller
            title: _buildLogo(neonBlue),
            actions: isSmall
                ? null
                : [
                    ...['home', 'about', 'skills', 'projects', 'contact']
                        .map((id) => _buildNavItem(id, neonBlue)),
                    const SizedBox(width: 20),
                  ],
            automaticallyImplyLeading: isSmall,
          ),
        );
      },
    );
  }

  /// Build the logo/brand name with neon effect
  Widget _buildLogo(Color neonBlue) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredItem = 'logo'),
      onExit: (_) => setState(() => _hoveredItem = null),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onItemSelected('home'),
        child: Text(
          'Portfolio', // Replace with your name/brand
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: neonBlue,
            shadows: _hoveredItem == 'logo'
                ? [
                    Shadow(
                      color: neonBlue.withValues(alpha: 0.8),
                      blurRadius: 20,
                    ),
                    Shadow(
                      color: neonBlue.withValues(alpha: 0.4),
                      blurRadius: 40,
                    ),
                  ]
                : [
                    Shadow(
                      color: neonBlue.withValues(alpha: 0.5),
                      blurRadius: 15,
                    ),
                  ],
          ),
        ),
      ),
    );
  }

  /// Build each navigation item with hover effect
  Widget _buildNavItem(String id, Color neonBlue) {
    final isActive = widget.currentSection == id;
    final isHovered = _hoveredItem == id;
    final shouldGlow = isActive || isHovered;

    // Capitalize first letter
    final label = id[0].toUpperCase() + id.substring(1);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hoveredItem = id),
        onExit: (_) => setState(() => _hoveredItem = null),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => widget.onItemSelected(id),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              // Background glow when active/hovered
              color: shouldGlow 
                  ? neonBlue.withValues(alpha: 0.1) 
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              // Border glow effect
              border: Border.all(
                color: shouldGlow
                    ? neonBlue.withValues(alpha: 0.4)
                    : Colors.transparent,
                width: 1,
              ),
              // Outer glow
              boxShadow: shouldGlow
                  ? [
                      BoxShadow(
                        color: neonBlue.withValues(alpha: 0.3),
                        blurRadius: isHovered ? 15 : 10,
                        spreadRadius: 0,
                      ),
                    ]
                  : null,
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16, // Larger font size
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: 1.2,
                color: shouldGlow ? neonBlue : Colors.white70,
                // Text glow effect
                shadows: shouldGlow
                    ? [
                        Shadow(
                          color: neonBlue.withValues(alpha: 0.6),
                          blurRadius: isHovered ? 12 : 8,
                        ),
                      ]
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}