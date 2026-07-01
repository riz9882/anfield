import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import '../data/club_data.dart';
import '../services/contact_service.dart';
import '../utils/responsive.dart';
import '../widgets/animations/app_animations.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  static Future<void> open(BuildContext context) {
    return Navigator.of(context).push(
      fadeSlideRoute(const ContactPage()),
    );
  }

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _queryController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _queryController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final phone = _phoneController.text.trim();
    final query = _queryController.text.trim();

    setState(() => _isSubmitting = true);

    try {
      await ContactService.sendEnquiry(phone: phone, query: query);
      if (!mounted) return;

      _phoneController.clear();
      _queryController.clear();

      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          icon: const Icon(Icons.check_circle, color: AppColors.primary, size: 48),
          title: const Text('Message Sent'),
          content: const Text(
            'Thank you! Your enquiry has been sent. We will get back to you soon.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } on ContactServiceException catch (e) {
      if (!mounted) return;
      _showError(e.message);
    } catch (_) {
      if (!mounted) return;
      _showError('Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Email instead',
          onPressed: () {
            ContactService.sendViaMailto(
              phone: _phoneController.text.trim(),
              query: _queryController.text.trim(),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      appBar: AppBar(
        title: const Text(
          'Get in Touch',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.sectionPadding),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'We\'d love to hear from you',
                    style: TextStyle(
                      fontSize: context.isMobile ? 22 : 26,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Send us your contact number and query. '
                    'We\'ll respond within 1–2 business days.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 28),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9+\s\-()]+')),
                    ],
                    decoration: _inputDecoration(
                      label: 'Contact Number',
                      hint: 'e.g. 55123456 or +974 5512 3456',
                      icon: Icons.phone_outlined,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your contact number';
                      }
                      final digits = value.replaceAll(RegExp(r'\D'), '');
                      final isLocal = digits.length == 8;
                      final isWithCode =
                          digits.length == 11 && digits.startsWith('974');
                      if (!isLocal && !isWithCode) {
                        return 'Enter a valid Qatar mobile number (8 digits)';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _queryController,
                    maxLines: 5,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: _inputDecoration(
                      label: 'Your Query',
                      hint: 'Tell us about enrollment, programs, or any questions...',
                      icon: Icons.message_outlined,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your query';
                      }
                      if (value.trim().length < 10) {
                        return 'Query must be at least 10 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _isSubmitting ? null : _submit,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: _isSubmitting
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: AppColors.white,
                              ),
                            )
                          : const Text(
                              'Submit Enquiry',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _InfoCard(
                    icon: Icons.email_outlined,
                    title: 'Email',
                    value: ContactService.recipientEmail,
                  ),
                  const SizedBox(height: 12),
                  _InfoCard(
                    icon: Icons.access_time,
                    title: 'Office Hours',
                    value: ClubData.openHours,
                  ),
                  const SizedBox(height: 12),
                  _InfoCard(
                    icon: Icons.location_on_outlined,
                    title: 'Club Office',
                    value: ClubData.address.trim(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: AppColors.primary),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
