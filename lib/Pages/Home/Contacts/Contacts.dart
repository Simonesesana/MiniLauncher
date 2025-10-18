import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {

  List contacts = [];

  // Function to call a number
  void callNumber(String number) async {
    final Uri uri = Uri(scheme: "tel", path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  // Funcion to load contacts
  void loadContacts() async {
    /*
    Iterable<Contact> _contacts = await ContactsService.getContacts();
    setState(() {
      contacts = _contacts.toList();
    });
     */
  }

  @override
  void initState() {
    loadContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rubrica")),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          final phone = contact.phones?.isNotEmpty == true
              ? contact.phones!.first.value
              : null;

          return ListTile(
            title: Text(contact.displayName ?? "Senza nome"),
            subtitle: Text(phone ?? "Nessun numero"),
            onTap: phone != null ? () => callNumber(phone) : null,
          );
        },
      ),
    );
  }
}
