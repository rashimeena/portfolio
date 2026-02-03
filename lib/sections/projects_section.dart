import 'package:flutter/material.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  final List<Map<String, String>> projects = const [
    {
      "title": "Women Safety App",
      "description":
          "A responsive Flutter app that provides SOS alerts, location sharing, and AI-based assistance for women’s safety.",
      "link": "https://github.com/"
    },
    {
      "title": "StorageHub",
      "description":
          "Inventory management app for TNP assets with graph analytics, category filters, and low-stock alerts.",
      "link": "https://github.com/"
    },
    {
      "title": "Portfolio Website",
      "description":
          "A personal portfolio website built using Flutter Web showcasing projects, skills, and experience.",
      "link": "https://github.com/"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 28),
      color: Colors.grey.shade50,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Projects",
                style: theme.textTheme.displayMedium!
                    .copyWith(color: Colors.teal.shade700),
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: projects
                    .map((p) => ProjectCard(
                          title: p["title"]!,
                          description: p["description"]!,
                          link: p["link"]!,
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

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final String link;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(fontSize: 14, height: 1.5)),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {},
              child: const Text("View on GitHub"),
            )
          ],
        ),
      ),
    );
  }
}
