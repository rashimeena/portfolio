import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

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
                "About Me",
                style: theme.textTheme.displayMedium!
                    .copyWith(color: Colors.teal.shade700),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 40,
                runSpacing: 20,
                children: [
                  SizedBox(
                    width: size.width < 800 ? double.infinity : 400,
                    child: const Text(
                      "I'm Rashi Meena, a passionate Flutter developer who loves turning ideas into interactive mobile and web experiences. I focus on creating clean, minimal UIs that feel natural and perform beautifully on every device.",
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ),
                  SizedBox(
                    width: size.width < 800 ? double.infinity : 400,
                    child: const Text(
                      "Currently pursuing my degree in Information Technology at RGPV, I’m also exploring backend technologies and UI/UX principles. My goal is to craft meaningful digital products that make people's lives easier.",
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
