import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ContactService {
  ContactService._();

  static const recipientEmail = 'info@aisasports.com';
  static const _endpoint = 'https://formsubmit.co/ajax/$recipientEmail';

  static Future<void> sendEnquiry({
    required String phone,
    required String query,
  }) async {
    final response = await http.post(
      Uri.parse(_endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        '_subject': 'ANFIELD Academy – New Enquiry',
        'phone': phone,
        'message': query,
        '_template': 'table',
        '_captcha': 'false',
      }),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ContactServiceException(
        'Unable to send your message. Please try again.',
      );
    }
  }

  static Future<bool> sendViaMailto({
    required String phone,
    required String query,
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: recipientEmail,
      query: _encodeQuery({
        'subject': 'ANFIELD Academy – New Enquiry',
        'body': 'Phone: $phone\n\nQuery:\n$query',
      }),
    );

    return launchUrl(uri);
  }

  static String _encodeQuery(Map<String, String> params) {
    return params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }
}

class ContactServiceException implements Exception {
  ContactServiceException(this.message);
  final String message;

  @override
  String toString() => message;
}
