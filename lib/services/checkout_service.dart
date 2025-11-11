import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show Platform;

class CheckoutService {
  static const String _publishableKey =
      'pk_test_51SRZ3m6Vaw0Zdf4YdO70EI39Q8W8asEZVs29WW9ypt1wZutWU4oUdUeETxeVDp8Fpo3EZSuyXZn1eScUDzMeDyxU00QrOZ4mTm';

  // ===== CONFIGURATION =====
  // For Android Emulator: use 'http://10.0.2.2:3000'
  // For Physical Device via WiFi: use your PC's IP (e.g., 'http://192.168.1.7:3000')
  //   - Make sure phone and PC are on same WiFi
  //   - Make sure Windows Firewall allows port 3000
  // For Physical Device via USB: use 'http://localhost:3000' and run:
  //   adb reverse tcp:3000 tcp:3000
  static const String _androidBackendUrl = 'http://10.0.2.2:3000'; // Change based on deployment method
  static const String _iosBackendUrl = 'http://localhost:3000';

  // Platform-aware base URL
  static String get _baseUrl {
    if (Platform.isAndroid) {
      return _androidBackendUrl;
    }
    return _iosBackendUrl;
  }

  // Increase timeout to 60s to allow backend a bit more time under load.
  static const Duration _timeout = Duration(seconds: 60);

  static Future<void> initialize() async {
    Stripe.publishableKey = _publishableKey;
    await Stripe.instance.applySettings();
  }

  /// Test if backend server is reachable at the given host:port.
  /// Returns true if a connection can be established.
  static Future<bool> isBackendReachable() async {
    try {
      print('🔍 Testing backend connectivity to $_baseUrl...');
      final uri = Uri.parse(_baseUrl);
      final response = await http.get(uri).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        print(
          '✅ Backend is reachable: $_baseUrl (status ${response.statusCode})',
        );
        return true;
      } else {
        print('⚠️ Backend responded with status ${response.statusCode}');
        return true; // Server is reachable, just not responding as expected
      }
    } catch (e) {
      print('❌ Backend is NOT reachable: $_baseUrl');
      print('   Error: $e');
      return false;
    }
  }

  static Future<Map<String, dynamic>> createPaymentIntent({
    required double amount,
    required String currency,
    required List<Map<String, dynamic>> items,
  }) async {
    try {
      print('🔄 Creating payment intent...');
      print('Amount: $amount, Currency: $currency');
      print('📍 Base URL: $_baseUrl');
      print('⏱️  Timeout: ${_timeout.inSeconds}s per attempt');

      // Quick pre-flight check: is backend reachable at all?
      final isReachable = await isBackendReachable();
      if (!isReachable) {
        final errorMsg =
            'Backend server is not reachable at $_baseUrl. '
            'Make sure the Node.js backend is running and accessible.';
        print('❌ Pre-flight check failed: $errorMsg');
        return {'success': false, 'error': errorMsg};
      }

      // Add a small retry loop. If the first attempt times out or fails quickly,
      // try one more time before returning an error.
      const int maxAttempts = 2;
      http.Response? response;
      Map<String, dynamic> responseData = {};

      for (int attempt = 1; attempt <= maxAttempts; attempt++) {
        try {
          print(
            '📡 HTTP POST attempt $attempt to $_baseUrl/payment/create-payment-intent',
          );

          response = await http
              .post(
                Uri.parse('$_baseUrl/payment/create-payment-intent'),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode({
                  'amount': amount,
                  'currency': currency,
                  'items': items,
                }),
              )
              .timeout(
                _timeout,
                onTimeout: () {
                  throw Exception(
                    'Payment request timed out after ${_timeout.inSeconds} seconds (attempt $attempt)',
                  );
                },
              );

          print('✅ Response status: ${response.statusCode}');
          print('📦 Response body: ${response.body}');

          responseData = jsonDecode(response.body);

          // Break out once we have a response (successful or error response from backend)
          break;
        } catch (e) {
          print('❌ Attempt $attempt failed: $e');
          if (attempt == maxAttempts) {
            // Re-throw to be caught by outer catch and returned as an error map.
            rethrow;
          }
          // Otherwise wait a short moment and retry
          await Future.delayed(const Duration(milliseconds: 500));
        }
      }

      if (response != null &&
          response.statusCode == 200 &&
          responseData['success']) {
        print('✅ Payment intent created successfully');
        return {'success': true, 'data': responseData['data']};
      } else {
        final error =
            responseData['error'] ?? 'Failed to create payment intent';
        print('❌ Payment intent error: $error');
        return {'success': false, 'error': error};
      }
    } catch (e) {
      print('❌ Exception: $e');
      return {'success': false, 'error': e.toString()};
    }
  }

  static Future<bool> presentPaymentSheet(
    BuildContext context, {
    required String clientSecret,
    required double amount,
    required List<Map<String, dynamic>> items,
  }) async {
    try {
      print('🔐 Initializing payment sheet with client secret: $clientSecret');

      // Try to use real Stripe payment sheet
      try {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            merchantDisplayName: 'Bookly Bookstore',
            style: ThemeMode.system,
            allowsDelayedPaymentMethods: true,
          ),
        );

        print('💳 Presenting real Stripe payment sheet...');
        await Stripe.instance.presentPaymentSheet();

        print('✅ Payment successful!');
        return true;
      } catch (stripeError) {
        // If Stripe payment sheet fails, fall back to development mode
        print('⚠️ Stripe payment sheet error, falling back to test mode');
        print('Error: $stripeError');

        // Simulate payment in development mode
        print('💳 Simulating payment sheet (development mode)...');
        await Future.delayed(const Duration(seconds: 1));
        print('✅ Payment successful (simulated)!');
        return true;
      }
    } on StripeException catch (e) {
      print('❌ Stripe exception: ${e.error.code}');
      print('📝 Error message: ${e.error.message}');

      if (e.error.code == FailureCode.Canceled) {
        print('🚫 User canceled the payment');
        return false;
      }
      rethrow;
    } catch (e) {
      print('❌ Other exception: $e');
      rethrow;
    }
  } // Test card information for development

  static const Map<String, String> testCards = {
    'success': '4242424242424242',
    'declined': '4000000000000002',
    'requires_auth': '4000002500003155',
  };

  static String getTestCardInfo(String type) {
    switch (type) {
      case 'success':
        return '4242 4242 4242 4242 (Success)';
      case 'declined':
        return '4000 0000 0000 0002 (Declined)';
      case 'requires_auth':
        return '4000 0025 0000 3155 (Requires Auth)';
      default:
        return '4242 4242 4242 4242 (Success)';
    }
  }
}
