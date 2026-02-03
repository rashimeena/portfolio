import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  final List<String> skills = const [
    "Flutter",
    "Dart",
    "Firebase",
    "Riverpod",
    "Provider",
    "REST APIs",
    "UI/UX",
    "Git & GitHub",
    "",
    "",
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 28),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Skills",
                style: theme.textTheme.displayMedium!
                    .copyWith(color: Colors.teal.shade700),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: skills
                    .map((skill) => Chip(
                          label: Text(skill),
                          backgroundColor: Colors.teal.shade50,
                          labelStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
