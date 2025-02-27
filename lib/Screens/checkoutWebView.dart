import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:luxuria_rentl_app/Widget/custom_bottom_nav_bar.dart';


class CheckoutPage extends StatelessWidget {
  final String checkoutUrl;

  CheckoutPage({required this.checkoutUrl});

  @override
  Widget build(BuildContext context) {
    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(checkoutUrl));

    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: WebViewWidget(controller: controller),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 2, // Update the index as needed
        onTap: (index) {
          // Handle navigation based on the selected index
          // For example, you can navigate to a different page
          if (index == 0) {
            // Navigate to home
          } else if (index == 1) {
            // Navigate to another page
          } else if (index == 2) {
            // Stay on the current page (Checkout)
          }
        },
      ),
    );
  }
}
