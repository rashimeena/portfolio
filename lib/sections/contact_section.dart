import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controllerName = TextEditingController();
    final controllerEmail = TextEditingController();
    final controllerMessage = TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 28),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Contact",
                style: theme.textTheme.displayMedium!
                    .copyWith(color: Colors.teal.shade700),
              ),
              const SizedBox(height: 20),
              const Text(
                "Have a project or collaboration in mind? Send me a message!",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 30),

              // Contact form
              TextField(
                controller: controllerName,
                decoration: const InputDecoration(
                  labelText: "Your Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controllerEmail,
                decoration: const InputDecoration(
                  labelText: "Your Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controllerMessage,
                minLines: 4,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: "Message",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                label: "Send Message",
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Message sent (mock)!')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
