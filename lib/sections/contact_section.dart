// lib/sections/contact_section.dart
// Enhanced contact section with themed styling
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../core/utils/contact_service.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    final success = await ContactService.sendMessage(
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      message: _messageCtrl.text.trim(),
    );

    setState(() => _loading = false);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? 'Message sent successfully! 🚀' : 'Failed to send message',
        ),
        backgroundColor: success ? Colors.green.shade700 : Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

    if (success) {
      _nameCtrl.clear();
      _emailCtrl.clear();
      _messageCtrl.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final neonBlue = theme.colorScheme.primary;
    final neonGreen = theme.colorScheme.secondary;
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 28),
      color: theme.scaffoldBackgroundColor,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            children: [
              // Section title
              _buildSectionTitle("Get in Touch", neonBlue),
              const SizedBox(height: 24),
              Text(
                "Have a project in mind? Let's talk!",
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white60,
                ),
              ),
              const SizedBox(height: 60),

              // Contact form card
              Container(
                padding: EdgeInsets.all(size.width > 600 ? 48 : 32),
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: neonBlue.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Name field
                      _buildTextField(
                        controller: _nameCtrl,
                        label: 'Name',
                        hint: 'Your name',
                        icon: Icons.person_outline,
                        neonBlue: neonBlue,
                        validator: (v) =>
                            v == null || v.isEmpty ? "Please enter your name" : null,
                      ),
                      const SizedBox(height: 24),

                      // Email field
                      _buildTextField(
                        controller: _emailCtrl,
                        label: 'Email',
                        hint: 'your.email@example.com',
                        icon: Icons.email_outlined,
                        neonBlue: neonBlue,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) => v == null || !v.contains('@')
                            ? "Please enter a valid email"
                            : null,
                      ),
                      const SizedBox(height: 24),

                      // Message field
                      _buildTextField(
                        controller: _messageCtrl,
                        label: 'Message',
                        hint: 'Tell me about your project...',
                        icon: Icons.message_outlined,
                        neonBlue: neonBlue,
                        maxLines: 5,
                        validator: (v) => v == null || v.isEmpty
                            ? "Please enter your message"
                            : null,
                      ),
                      const SizedBox(height: 32),

                      // Submit button
                      CustomButton(
                        label: _loading ? 'Sending...' : 'Send Message',
                        onPressed: _loading ? () {} : _submit,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required Color neonBlue,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: neonBlue.withValues(alpha: 0.7),
          size: 20,
        ),
        labelStyle: TextStyle(
          color: neonBlue.withValues(alpha: 0.8),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.3),
          fontSize: 14,
        ),
        
        // Enabled border (default state)
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: neonBlue.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        
        // Focused border (when typing)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: neonBlue.withValues(alpha: 0.6),
            width: 2,
          ),
        ),
        
        // Error border (validation failed)
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red.withValues(alpha: 0.6),
            width: 1.5,
          ),
        ),
        
        // Focused error border
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red.withValues(alpha: 0.8),
            width: 2,
          ),
        ),
        
        filled: true,
        fillColor: neonBlue.withValues(alpha: 0.05),
        
        errorStyle: const TextStyle(
          color: Colors.redAccent,
          fontSize: 12,
        ),
        
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}