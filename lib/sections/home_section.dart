// lib/sections/home_section.dart
//A stateless, responsive hero layout(landing section) that adapts to screen size,
// uses theme-based styling, and follows a clean “max-width centered content” pattern.
import 'package:flutter/material.dart';
import '../core/utils/constants.dart';
import '../widgets/custom_button.dart';

class HomeSection extends StatelessWidget {
  final VoidCallback onContactTap;
  final VoidCallback onProjectsTap;

  const HomeSection({
    super.key,
    required this.onContactTap,
    required this.onProjectsTap,
  });

  //stateless (for now) - no animations, no internal state, purely ui

  @override
  Widget build(BuildContext context) {
    //to follow global, responsive and consistence things
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 28),
      constraints: BoxConstraints(minHeight: size.height * 0.8),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // LEFT: Text column
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(AppStrings.name, style: theme.textTheme.displayLarge),
                    const SizedBox(height: 8),
                    Text(AppStrings.role, style: theme.textTheme.displayMedium),
                    const SizedBox(height: 18),
                    Text(
                      AppStrings.heroSubtitle,
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        CustomButton(
                          label: 'Contact me',
                          onPressed: onContactTap, // ✅ ACTIVE,
                        ),
                        const SizedBox(width: 12),
                        TextButton(
                          onPressed: onProjectsTap, // ✅ ACTIVE
                          child: const Text('View projects'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // RIGHT: Placeholder for image/illustration
              if (size.width > 900)
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 28),
                    child: AspectRatio(
                      aspectRatio: 4 / 5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            'assets/images/profile.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
