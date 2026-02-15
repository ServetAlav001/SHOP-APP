import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static final List<Map<String, String>> _mockOrders = [
    {'id': '#12345', 'date': '15 Şubat 2026', 'status': 'Teslim edildi', 'total': '\$129'},
    {'id': '#12344', 'date': '10 Şubat 2026', 'status': 'Kargoda', 'total': '\$299'},
    {'id': '#12340', 'date': '1 Şubat 2026', 'status': 'Teslim edildi', 'total': '\$59'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Siparişlerim'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _mockOrders.length,
        itemBuilder: (context, index) {
          final o = _mockOrders[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(
                  Icons.receipt_long,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              title: Text('Sipariş ${o['id']}'),
              subtitle: Text('${o['date']} • ${o['status']}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    o['total']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const Icon(Icons.chevron_right, size: 20),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrderDetailScreen(
                      orderId: o['id']!,
                      date: o['date']!,
                      status: o['status']!,
                      total: o['total']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class OrderDetailScreen extends StatelessWidget {
  final String orderId;
  final String date;
  final String status;
  final String total;

  const OrderDetailScreen({
    super.key,
    required this.orderId,
    required this.date,
    required this.status,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sipariş $orderId'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _row('Sipariş No', orderId),
                  const Divider(),
                  _row('Tarih', date),
                  const Divider(),
                  _row('Durum', status),
                  const Divider(),
                  _row('Toplam', total),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Sipariş özeti (örnek): 2 ürün teslim edildi.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text(value, style: const TextStyle(fontWeight: FontWeight.w600))],
      ),
    );
  }
}
