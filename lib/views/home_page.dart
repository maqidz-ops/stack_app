import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import '../utils/local_storage.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => 
      const HomePage(),
    ),
  );
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String role = '';
  @override
  void initState() {
    super.initState();
    loadRole();
  }

  Future<void> loadRole() async {
    final result = await storage.read(key: 'role');
    setState(() {
      role = result ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        height: 72,
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
        ),
        // Bottom Navigation Bar Items
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "lib/asset/home.png",
              width: 24,
              height: 24,
            ),
            Image.asset(
              "lib/asset/calendar.png",
              width: 24,
              height: 24,
            ),
            Container(
              width: 52,
              height: 36,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(36),
                  topLeft: Radius.circular(36),
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.black,
                size: 28,
              ),
            ),
            Image.asset(
              "lib/asset/progress.png",
              width: 24,
              height: 24,
            ),
            Image.asset(
              "lib/asset/profile.png",
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
      // Body Content
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "lib/asset/logo_stack.png",
                    width: 28,
                    height: 28,
                  ),
                  Image.asset(
                    "lib/asset/notification.png",
                    width: 24,
                    height: 24,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Greeting Section

              const SizedBox(height: 20,),

              // Upcoming Subscriptions Section
              const Text(
                "UPCOMING NEXT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    UpcomingCard(
                      title: "Technologies",
                      price: "\$1,745",
                    ),
                    SizedBox(width: 14),
                    UpcomingCard(
                      title: "Platform",
                      price: "\$1,745",
                    ),
                    SizedBox(width: 14),
                    UpcomingCard(
                      title: "Services",
                      price: "\$1,745",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Subscriptions
              const Text(
                "ALL SUBSCRIPTIONS",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 16),

              SubscriptionCard(
                logoAsset: "lib/asset/logo_paper.png",
                color: const Color(0xFF81ACEC),
                title: "Paper Pro",
                date: "17 Aug 2024",
                price: "\$25/m",
              ),

              const SizedBox(height: 16),

              SubscriptionCard(
                logoAsset: "lib/asset/logo_claude.png",
                color: const Color(0xFFDA7757),
                title: "Claude Pro",
                date: "17 Aug 2024",
                price: "\$25/m",
              ),

              const SizedBox(height: 20),

              Align(
                alignment: AlignmentGeometry.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    "Role : $role",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

class UpcomingCard extends StatelessWidget {
  final String title;
  final String price;

  const UpcomingCard({
    super.key,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF17181A),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const Spacer(),
          Text(
            price,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final Color color;
  final String title;
  final String date;
  final String price;
  final String? logoAsset;

  const SubscriptionCard({
    super.key,
    required this.color,
    required this.title,
    required this.date,
    required this.price,
    this.logoAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF17181A),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: logoAsset != null
                ? Image.asset(
                    logoAsset!,
                    width: 32,
                    height: 32,
                  )
                : null,
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Image.asset(
                      "lib/asset/calendar-2.png",
                      width: 16,
                      height: 16,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Text(
            price,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}