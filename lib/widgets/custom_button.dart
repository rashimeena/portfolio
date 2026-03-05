// lib/widgets/custom_button.dart
import 'package:flutter/material.dart';

/// Custom neon-styled button with glow effects
/// Matches the navbar aesthetic with hover animations
class CustomButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final bool isPrimary; // true = neon blue, false = neon green

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.padding,
    this.isPrimary = true,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  // Track hover state for interactive glow effect
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Choose color based on button type
    // Primary = neon blue (0xFF00E5FF)
    // Secondary = neon green (0xFF64FFDA)
    final buttonColor = widget.isPrimary 
        ? theme.colorScheme.primary 
        : theme.colorScheme.secondary;

    return MouseRegion(
      // Detect when mouse enters/exits button area
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click, // Show pointer cursor
      
      // AnimatedContainer smoothly transitions between hover states
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // Smooth 200ms transition
        curve: Curves.easeOut, // Smooth deceleration curve
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          
          // The NEON GLOW effect - created with box shadows
          boxShadow: [
            BoxShadow(
              color: buttonColor.withValues(
                // More opacity when hovered = brighter glow
                alpha: _isHovered ? 0.6 : 0.3,
              ),
              blurRadius: _isHovered ? 25 : 15, // Larger blur = softer glow
              spreadRadius: _isHovered ? 2 : 0,  // Expand glow on hover
            ),
          ],
        ),
        
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            // Semi-transparent background (glass effect)
            backgroundColor: buttonColor.withValues(alpha: 0.15),
            
            // Text color matches the glow color
            foregroundColor: buttonColor,
            
            padding: widget.padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            
            elevation: 0, // Remove default shadow (we use custom glow)
            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              
              // Add glowing border
              side: BorderSide(
                color: buttonColor.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
          ),
          
          child: Text(
            widget.label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2, // Wider spacing = modern look
              fontSize: 15,
              
              // Add subtle text glow
              shadows: [
                Shadow(
                  color: buttonColor.withValues(alpha: 0.5),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}