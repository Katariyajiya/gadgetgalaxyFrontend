import 'package:flutter/material.dart';
import 'package:gadgetgalaxyfe/utils/flash_sale_timer.dart';
import '../../core/theme/app_colors.dart';
import '../../core/models/product_model.dart';
import '../../core/data/mock_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'all';

  List<Product> get filteredProducts {
    if (selectedCategory == 'all') return MockData.products;
    return MockData.products.where((p) => p.category == selectedCategory).toList();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(child: _buildCategoryNav()),

          // Breadcrumb
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 24, top: 16),
              child: Text('Home  >  All Products', style: TextStyle(color: AppColors.text3, fontSize: 12)),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildResponsiveHero()),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // New Sections added here:
          SliverToBoxAdapter(child: _buildTrustBar()),
          const SliverToBoxAdapter(child: SizedBox(height: 36)),
          SliverToBoxAdapter(child: _buildFlashSale()),
          const SliverToBoxAdapter(child: SizedBox(height: 36)),

          SliverToBoxAdapter(child: _buildSectionHeader('Featured Products')),
          _buildResponsiveProductGrid(),
          const SliverToBoxAdapter(child: SizedBox(height: 44)),

          // More new sections:
          SliverToBoxAdapter(child: _buildBanners()),
          const SliverToBoxAdapter(child: SizedBox(height: 44)),
          SliverToBoxAdapter(child: _buildSectionHeader('What Our Customers Say')),
          SliverToBoxAdapter(child: _buildReviews()),
          const SliverToBoxAdapter(child: SizedBox(height: 44)),
          SliverToBoxAdapter(child: _buildNewsletter()),
          SliverToBoxAdapter(child: _buildFooter()),
        ],
      ),
    );
  }

  // --- TRUST BAR ---
  Widget _buildTrustBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border.symmetric(horizontal: BorderSide(color: AppColors.border1)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        spacing: 16,
        runSpacing: 12,
        children: [
          _trustItem('🚚', 'Free Shipping over ₹999'),
          _trustItem('↩️', '30-Day Easy Returns'),
          _trustItem('🔒', 'Secure Payment'),
          _trustItem('🛡️', '1-Year Warranty'),
          _trustItem('💬', '24/7 Support'),
        ],
      ),
    );
  }

  Widget _trustItem(String icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(icon, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.text2)),
      ],
    );
  }

  // --- FLASH SALE ---
  Widget _buildFlashSale() {
    final flashItems = [
      {'name': 'Smart Watch', 'emoji': '⌚', 'price': '₹4,999', 'old': '₹9,999', 'sold': 0.72},
      {'name': 'Earbuds Pro', 'emoji': '🎧', 'price': '₹2,499', 'old': '₹5,999', 'sold': 0.85},
      {'name': 'Power Bank', 'emoji': '🔋', 'price': '₹1,299', 'old': '₹2,999', 'sold': 0.60},
      {'name': 'USB Hub', 'emoji': '🔌', 'price': '₹999', 'old': '₹2,499', 'sold': 0.90},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFE3F2FD), Color(0xFFEEF5FF)]),
          border: Border.all(color: const Color(0xFFBBDEFB)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('⚡', style: TextStyle(fontSize: 20)),
                    const SizedBox(width: 8),
                    const Text('Flash Sale', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: AppColors.red, borderRadius: BorderRadius.circular(6)),
                      child: const Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)),
                    )
                  ],
                ),
                const FlashSaleTimer()
              ],
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: flashItems.length,
                itemBuilder: (context, index) {
                  final item = flashItems[index];
                  return Container(
                    width: 140,
                    margin: const EdgeInsets.only(right: 14),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFBBDEFB)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(item['emoji'].toString(), style: const TextStyle(fontSize: 40)),
                        const Spacer(),
                        Text(item['name'].toString(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(item['price'].toString(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.red)),
                            const SizedBox(width: 6),
                            Text(item['old'].toString(), style: const TextStyle(fontSize: 10, color: AppColors.text3, decoration: TextDecoration.lineThrough)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: item['sold'] as double,
                          backgroundColor: const Color(0xFFBBDEFB),
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(5),
                          minHeight: 5,
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // --- PROMO BANNERS ---
  Widget _buildBanners() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 700;
          final widgets = [
            Expanded(child: _buildPromoCard('Best Sellers', 'Power Up Your Workflow', 'Top-spec laptops for creators', '💻', const [Color(0xFF01305A), Color(0xFF023A7A)], true)),
            SizedBox(width: isMobile ? 0 : 18, height: isMobile ? 18 : 0),
            Expanded(child: _buildPromoCard('Gaming Zone', 'Level Up Your Setup', 'Consoles & gaming accessories', '🎮', const [Color(0xFFE0F7FA), Color(0xFFB2EBF2)], false)),
          ];

          if (isMobile) {
            return Column(children: widgets);
          }
          return Row(children: widgets);
        },
      ),
    );
  }

  Widget _buildPromoCard(String tag, String title, String sub, String emoji, List<Color> colors, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(right: -10, top: 0, bottom: 0, child: Center(child: Text(emoji, style: TextStyle(fontSize: 80, color: Colors.white.withOpacity(0.1))))),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tag.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: isDark ? const Color(0xFF90CAF9) : const Color(0xFF00838F))),
              const SizedBox(height: 8),
              Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: isDark ? Colors.white : const Color(0xFF004D5A))),
              const SizedBox(height: 6),
              Text(sub, style: TextStyle(fontSize: 13, color: isDark ? const Color(0xFF90CAF9) : const Color(0xFF006064))),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: isDark ? Colors.white : AppColors.teal, borderRadius: BorderRadius.circular(50)),
                child: Text('Shop Now →', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: isDark ? AppColors.primary : Colors.white)),
              )
            ],
          ),
        ],
      ),
    );
  }

  // --- REVIEWS ---
  Widget _buildReviews() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _reviewCard('RS', 'Rahul Sharma', 'Absolutely love my new phone! Fast delivery and great packaging.', '📱 Galaxy S25 Ultra', const Color(0xFF0277BD)),
            const SizedBox(width: 16),
            _reviewCard('PG', 'Priya Gupta', 'Best online electronics store! Got my laptop at the lowest price.', '💻 MacBook Air M3', const Color(0xFFC9891A)),
            const SizedBox(width: 16),
            _reviewCard('AM', 'Arjun Mehta', 'Good product quality. Return process was seamless when needed.', '🎧 Sony WH-1000XM5', const Color(0xFFDC4444)),
          ],
        ),
      ),
    );
  }

  Widget _reviewCard(String initials, String name, String text, String product, Color color) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundColor: color, radius: 18, child: Text(initials, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                  const Text('✓ Verified Purchase', style: TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w600)),
                ],
              )
            ],
          ),
          const SizedBox(height: 12),
          const Text('★★★★★', style: TextStyle(color: AppColors.amber, fontSize: 14)),
          const SizedBox(height: 8),
          Text('"$text"', style: const TextStyle(fontSize: 13, color: AppColors.text2, height: 1.5)),
          const SizedBox(height: 12),
          Text(product, style: const TextStyle(fontSize: 11, color: AppColors.text3, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // --- NEWSLETTER ---
  Widget _buildNewsletter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        padding: const EdgeInsets.all(44),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF01305A), Color(0xFF0151A0)]),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const Text('Stay in the Loop 📬', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white)),
            const SizedBox(height: 8),
            const Text('Get exclusive deals, new launches & tech updates', style: TextStyle(color: Color(0xFF90BDD6), fontSize: 14)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your email address',
                      hintStyle: const TextStyle(color: Color(0xFF6B9CB8)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.teal),
                  onPressed: () {},
                  child: const Text('Subscribe'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // --- FOOTER ---
  Widget _buildFooter() {
    return Container(
      color: const Color(0xFF01213E),
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
                        children: [TextSpan(text: 'VOL'), TextSpan(text: 'TA', style: TextStyle(color: Color(0xFF80DEEA)))],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text("India's favourite destination for premium electronics. Quality products, honest prices.", style: TextStyle(color: Color(0xFF6B9CB8), fontSize: 13, height: 1.5)),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('SHOP', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
                    const SizedBox(height: 12),
                    _footerLink('Smartphones'), _footerLink('Laptops'), _footerLink('Audio'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('SUPPORT', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
                    const SizedBox(height: 12),
                    _footerLink('Track Order'), _footerLink('Returns'), _footerLink('Contact Us'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Divider(color: Color(0xFF1E3A5F)),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('© 2025 VOLTA Electronics. All rights reserved.', style: TextStyle(color: Color(0xFF6B9CB8), fontSize: 12)),
              Text('💳 VISA • MC • UPI • RuPay', style: TextStyle(color: Color(0xFF6B9CB8), fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }

  Widget _footerLink(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: const TextStyle(color: Color(0xFF6B9CB8), fontSize: 13)),
    );
  }

  // --- HEADER ---
  // --- HEADER ---
  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 4, // Adds shadow on scroll
      shadowColor: AppColors.primary.withOpacity(0.2),
      titleSpacing: 24,
      title: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          return Row(
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.text1, letterSpacing: -0.5),
                  children: [
                    TextSpan(text: 'VOL'),
                    TextSpan(text: 'TA', style: TextStyle(color: AppColors.primary)),
                  ],
                ),
              ),
              if (!isMobile) ...[
                const SizedBox(width: 40),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 44,
                      constraints: const BoxConstraints(maxWidth: 500),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        border: Border.all(color: AppColors.border1, width: 1.5),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 16.0, right: 8.0),
                            child: Icon(Icons.search, color: AppColors.text3, size: 20),
                          ),
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search laptops, phones, accessories...',
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                isDense: true,
                                filled: false, // Overrides the global theme
                                contentPadding: EdgeInsets.zero,
                                hintStyle: TextStyle(color: AppColors.text3, fontSize: 13),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                minimumSize: const Size(0, 36),
                                elevation: 0,
                              ),
                              child: const Text('Search', style: TextStyle(fontSize: 13)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ]
            ],
          );
        },
      ),
      actions: [
        // Show search icon in actions ONLY if we are on a small mobile screen
        Builder(
          builder: (context) {
            if (MediaQuery.of(context).size.width < 600) {
              return IconButton(icon: const Icon(Icons.search, color: AppColors.text2), onPressed: () {});
            }
            return const SizedBox.shrink();
          },
        ),
        IconButton(icon: const Icon(Icons.favorite_border, color: AppColors.text2), onPressed: () {}),
        IconButton(icon: const Icon(Icons.shopping_cart_outlined, color: AppColors.text2), onPressed: () {}),
        Padding(
          padding: const EdgeInsets.only(right: 24.0, left: 8.0, top: 10, bottom: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: AppColors.primary,
                  child: Text('JD', style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                SizedBox(width: 6),
                Text('John', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 13)),
              ],
            ),
          ),
        )
      ],
    );
  }

  // --- CATEGORY NAV ---
  Widget _buildCategoryNav() {
    final categories = [
      {'id': 'all', 'label': 'All Products', 'emoji': '🛍️'},
      {'id': 'smartphones', 'label': 'Phones', 'emoji': '📱'},
      {'id': 'laptops', 'label': 'Laptops', 'emoji': '💻'},
      {'id': 'audio', 'label': 'Audio', 'emoji': '🎧'},
    ];

    return Container(
      color: AppColors.surface,
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = selectedCategory == cat['id'];

          return GestureDetector(
            onTap: () => setState(() => selectedCategory = cat['id']!),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryLight : AppColors.surface,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border1,
                  width: 1.5,
                ),
                boxShadow: isSelected
                    ? [BoxShadow(color: AppColors.primary.withOpacity(0.12), blurRadius: 8, offset: const Offset(0, 2))]
                    : [],
              ),
              child: Row(
                children: [
                  Text(cat['emoji']!, style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Text(
                    cat['label']!,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? AppColors.primary : AppColors.text1,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // --- RESPONSIVE HERO ---
// --- RESPONSIVE HERO ---
  Widget _buildResponsiveHero() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Breakpoint matches your CSS @media(max-width:900px)
          if (constraints.maxWidth < 900) {
            return Column(
              children: [
                _buildHeroMainBanner(),
                const SizedBox(height: 18),
                // Using IntrinsicHeight allows the Row to stretch its children to match the tallest one safely
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: _buildHeroSideCard('New', '📱', 'Smartphones', 'From ₹8,999', const [Color(0xFFE3F2FD), Color(0xFFBBDEFB)])),
                      const SizedBox(width: 14),
                      Expanded(child: _buildHeroSideCard('Hot', '🎧', 'Audio Gear', 'From ₹1,499', const [Color(0xFFE0F7FA), Color(0xFFB2EBF2)])),
                    ],
                  ),
                ),
              ],
            );
          } else {
            // FIX: Wrapped the desktop row in a fixed height SizedBox!
            // This prevents the stretch/Expanded elements from growing to infinity and crashing the layout.
            return SizedBox(
              height: 340,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _buildHeroMainBanner()),
                  const SizedBox(width: 18),
                  SizedBox(
                    width: 320,
                    child: Column(
                      children: [
                        Expanded(child: _buildHeroSideCard('New', '📱', 'Smartphones', 'From ₹8,999', const [Color(0xFFE3F2FD), Color(0xFFBBDEFB)])),
                        const SizedBox(height: 14),
                        Expanded(child: _buildHeroSideCard('Hot', '🎧', 'Audio Gear', 'From ₹1,499', const [Color(0xFFE0F7FA), Color(0xFFB2EBF2)])),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildHeroMainBanner() {
    return Container(
      constraints: const BoxConstraints(minHeight: 340),
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Background decorations mimicking absolute CSS circles
          Positioned(
            right: -60, top: -60,
            child: Container(
              width: 250, height: 250,
              decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF00ACC1).withOpacity(0.25)),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF00ACC1).withOpacity(0.18),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF00ACC1).withOpacity(0.38)),
                ),
                child: const Text('✦ New Arrivals 2025', style: TextStyle(color: Color(0xFF80DEEA), fontSize: 12, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 18),
              const Text(
                'Next-Gen Tech\nAt Your Fingertips',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800, color: Colors.white, height: 1.15, letterSpacing: -0.8),
              ),
              const SizedBox(height: 14),
              const Text(
                'Discover the latest electronics with unbeatable prices.\nFree shipping on orders above ₹999.',
                style: TextStyle(color: Color(0xFF90BDD6), fontSize: 14, height: 1.65),
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.primary),
                    onPressed: () {},
                    child: const Text('Shop Now →'),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white.withOpacity(0.22), width: 1.5),
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    ),
                    onPressed: () {},
                    child: const Text('Explore Deals'),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSideCard(String badge, String emoji, String title, String subtitle, List<Color> gradient) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border1, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 38, height: 1)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                decoration: BoxDecoration(color: AppColors.red, borderRadius: BorderRadius.circular(20)),
                child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.text1)),
          const SizedBox(height: 3),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.text2)),
        ],
      ),
    );
  }

  // --- SECTION HEADER ---
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w700, color: AppColors.text1, letterSpacing: -0.3)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(50)),
            child: const Text('View All →', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  // --- RESPONSIVE PRODUCT GRID ---
  Widget _buildResponsiveProductGrid() {
    if (filteredProducts.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(48.0),
          child: Center(child: Text('No products found', style: TextStyle(fontWeight: FontWeight.bold))),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      // This is the Flutter equivalent of CSS: grid-template-columns: repeat(auto-fill, minmax(218px, 1fr))
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 260, // Cards will expand to fill, but won't exceed 260px width
          mainAxisSpacing: 18,
          crossAxisSpacing: 18,
          mainAxisExtent: 340, // Fixed height for exact CSS matching
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final product = filteredProducts[index];
            final discount = ((1 - (product.price / product.oldPrice)) * 100).round();

            return Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border1),
                boxShadow: [
                  BoxShadow(color: AppColors.primary.withOpacity(0.04), blurRadius: 4, offset: const Offset(0, 1))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Area (Gradient background like CSS)
                  Container(
                    height: 175,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xFFF2F6FA), Color(0xFFE8F0F8)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(19)),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(product.emoji, style: const TextStyle(fontSize: 70, height: 1)),
                        if (product.badge != null)
                          Positioned(
                            top: 10, left: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: product.badge == 'sale' ? const Color(0xFFFEF2F2) : AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: product.badge == 'sale' ? const Color(0xFFFECACA) : const Color(0xFF90CAF9)),
                              ),
                              child: Text(
                                product.badge!.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w700,
                                  color: product.badge == 'sale' ? AppColors.red : AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        Positioned(
                          top: 10, right: 10,
                          child: Container(
                            width: 32, height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.border1),
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 2))],
                            ),
                            child: const Icon(Icons.favorite_border, size: 14, color: AppColors.text2),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Info Area
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.brand.toUpperCase(), style: const TextStyle(fontSize: 10, color: AppColors.text3, fontWeight: FontWeight.w600, letterSpacing: 0.6)),
                          const SizedBox(height: 3),
                          Text(product.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.text1, height: 1.4)),
                          const SizedBox(height: 7),
                          Row(
                            children: [
                              const Icon(Icons.star, size: 12, color: AppColors.amber),
                              const SizedBox(width: 4),
                              Text('${product.rating} (${product.reviews})', style: const TextStyle(fontSize: 11, color: AppColors.text3)),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text('₹${product.price.toInt()}', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.text1)),
                              const SizedBox(width: 7),
                              Text('₹${product.oldPrice.toInt()}', style: const TextStyle(fontSize: 12, decoration: TextDecoration.lineThrough, color: AppColors.text3)),
                              const SizedBox(width: 7),
                              Text('$discount% off', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.green)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 9),
                                  ),
                                  child: const Text('Add to Cart', style: TextStyle(fontSize: 12)),
                                ),
                              ),
                              const SizedBox(width: 7),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
                                decoration: BoxDecoration(
                                  color: AppColors.surface2,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: AppColors.border1, width: 1.5),
                                ),
                                child: const Text('⇌', style: TextStyle(color: AppColors.text2, fontSize: 13, fontWeight: FontWeight.bold)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          childCount: filteredProducts.length,
        ),
      ),
    );
  }
}