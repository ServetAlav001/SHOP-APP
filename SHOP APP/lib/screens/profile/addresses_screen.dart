import 'package:flutter/material.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  static final List<Map<String, String>> _mockAddresses = [
    {
      'title': 'Ev',
      'address': 'Örnek Mah. Örnek Sok. No: 1\nKadıköy, İstanbul',
      'fullName': 'Misafir Kullanıcı',
      'phone': '+90 5XX XXX XX XX',
    },
    {
      'title': 'İş',
      'address': 'Örnek İş Merkezi, Kat: 5\nŞişli, İstanbul',
      'fullName': 'Misafir Kullanıcı',
      'phone': '+90 5XX XXX XX XX',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adreslerim'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Yeni adres ekleme henüz aktif değil')),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _mockAddresses.length,
        itemBuilder: (context, index) {
          final a = _mockAddresses[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(
                  index == 0 ? Icons.home : Icons.work_outline,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              title: Text(a['title']!),
              subtitle: Text(
                '${a['address']}\n${a['fullName']} • ${a['phone']}',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              isThreeLine: true,
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${a['title']} adresi seçildi')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
