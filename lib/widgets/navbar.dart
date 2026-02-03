// lib/widgets/navbar.dart
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final void Function(String id) onItemSelected;

  const NavBar({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isSmall = constraints.maxWidth < 800;
      return AppBar(
        title: const Text('Portfolio'),
        actions: isSmall
            ? null
            : [
                TextButton(
                  onPressed: () => onItemSelected('home'),
                  child: const Text('Home'),
                ),
                TextButton(
                  onPressed: () => onItemSelected('about'),
                  child: const Text('About'),
                ),
                TextButton(
                  onPressed: () => onItemSelected('skills'),
                  child: const Text('Skills'),
                ),
                TextButton(
                  onPressed: () => onItemSelected('projects'),
                  child: const Text('Projects'),
                ),
                TextButton(
                  onPressed: () => onItemSelected('contact'),
                  child: const Text('Contact'),
                ),
                const SizedBox(width: 12),
              ],
        // For small screens show a Drawer icon
        automaticallyImplyLeading: isSmall,
      );
    });
  }
}
