import 'package:flutter/material.dart';
import '../utils/local_storage.dart';

class HomePage extends StatefulWidget {
  final String email;

  const HomePage({super.key, required this.email});

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

  String get displayName {
    final email = widget.email.trim();
    if (email.isEmpty) return 'Guest';

    final localPart = email.split('@').first;
    if (localPart.isEmpty) return 'Guest';

    final nameSegment = localPart.split(RegExp(r'[._-]')).first;
    if (nameSegment.isEmpty) return 'Guest';

    return nameSegment[0].toUpperCase() + nameSegment.substring(1);
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
              Text(
                'Good Morning, ${displayName}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Card(
                color: const Color(0xFF17181A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '\$248.00',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 0),
                          Text(
                            'Monthly Spend',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            '5 active',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 0),
                          Text(
                            'Subscriptions',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Upcoming Subscriptions Section
              const Text(
                "UPCOMING NEXT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    UpcomingCard(
                      logoAsset: "lib/asset/logo_paper.png",
                      date: "29 Jun 2026",
                      price: "\$25",
                    ),
                    SizedBox(width: 12),
                    UpcomingCard(
                      logoAsset: "lib/asset/logo_manus.png",
                      date: "29 Jun 2026",
                      price: "\$20",
                    ),
                    SizedBox(width: 12),
                    UpcomingCard(
                      logoAsset: "lib/asset/logo_claude.png",
                      date: "29 Jun 2026",
                      price: "\$20",
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

              const SizedBox(height: 12),

              SubscriptionCard(
                logoAsset: "lib/asset/logo_paper.png",
                color: const Color(0xFF81ACEC),
                title: "Paper Pro",
                date: "29 Jun 2026",
                price: "\$25/m",
                onTap: () => showSubscriptionDetails(
                  context,
                  imagePath: 'lib/asset/logo_paper.png',
                  title: 'Paper Pro',
                  price: '\$25/month',
                  billing: 'Monthly',
                  nextPayment: '29 Jun 2026',
                  totalSpent: '\$25',
                  subscribed: '3 days',
                  category: 'Tools',
                ),
              ),

              const SizedBox(height: 12),

              SubscriptionCard(
                logoAsset: "lib/asset/logo_claude.png",
                color: const Color(0xFFDA7757),
                title: "Claude Pro",
                date: "29 Jun 2026",
                price: "\$20/m",
                onTap: () => showSubscriptionDetails(
                  context,
                  imagePath: 'lib/asset/logo_claude.png',
                  title: 'Claude Pro',
                  price: '\$20/month',
                  billing: 'Monthly',
                  nextPayment: '29 Jun 2026',
                  totalSpent: '\$20',
                  subscribed: '3 days',
                  category: 'Tools',
                ),
              ),

              const SizedBox(height: 12),

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
  final String price;
  final String date;
  final String? logoAsset;

  const UpcomingCard({
    super.key,
    required this.price,
    required this.date,
    this.logoAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 124,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF17181A),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF17181A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: logoAsset != null
                ? Image.asset(
                    logoAsset!,
                    width: 32,
                    height: 32,
                  )
                : null,
          ),
          const Spacer(),

          Text(
            price,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            date,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 14,
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
  final VoidCallback? onTap;

  const SubscriptionCard({
    super.key,
    required this.color,
    required this.title,
    required this.date,
    required this.price,
    this.logoAsset,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                color: const Color(0xFF17181A),
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
      ),
    );
  }
}

void showSubscriptionDetails(
  BuildContext context, {
  required String title,
  required String price,
  required String billing,
  required String nextPayment,
  required String totalSpent,
  required String subscribed,
  required String category,
  required String? imagePath,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (c) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (_, controller) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFF17181A),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: ListView(
              controller: controller,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 72,
                      height: 72,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          imagePath!,
                          fit: BoxFit.cover,
                        ),
                      )
                      
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            price,
                            style: TextStyle(color: Colors.grey.shade400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2124),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  child: Column(
                    children: [
                      _detailRow('Billing', billing),
                      const SizedBox(height: 24),
                      _detailRow('Next payment', nextPayment),
                      const SizedBox(height: 24),
                      _detailRow('Total spent', totalSpent),
                      const SizedBox(height: 24),
                      _detailRow('Subscribed', subscribed),
                      const SizedBox(height: 24),
                      _detailRow('Category', category),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _detailRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      Text(
        value,
        style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
      ),
    ],
  );
}