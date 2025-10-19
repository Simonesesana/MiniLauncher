import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:minilauncher/Packages/Preferences/Preferences.dart';

class Contact {

  String name;
  String phoneNumber;

  Contact({required this.name, required this.phoneNumber});

}

class Contacts {

  // Prevents instantiation
  Contacts._();

  // List to hold favourite contacts
  static List<Contact> contacts = [];
  static List<Contact> favouriteContacts = [];

  // Fetch favourite contacts and contacts list
  static void fetchContacts() async {

    final contact_list = await FlutterContacts.getContacts(withProperties: true);
    for (var contact in contact_list) {
      if(contact.phones.isNotEmpty && contact.phones.first.number != "No number") {
        contacts.add(Contact(
          name: contact.displayName,
          phoneNumber: contact.phones.first.number,
        ));
      }
    }

    // Fetches favourite contacts
    favouriteContacts.clear();

    List<String> names = await getStringList("favourite_contacts_names");
    List<String> phoneNumbers = await getStringList("favourite_contacts_numbers");

    for(int i = 0; i < names.length; i++) {
      favouriteContacts.add(Contact(name: names[i], phoneNumber: phoneNumbers[i]));
    }

  }

  // Method to add favourite contact
  static void addFavouriteContact(String name, String phoneNumber) async {

    favouriteContacts.add(Contact(name: name, phoneNumber: phoneNumber));

    List<String> names = favouriteContacts.map((contact) => contact.name).toList();
    List<String> phoneNumbers = favouriteContacts.map((contact) => contact.phoneNumber).toList();

    await setStringList("favourite_contacts_names", names);
    await setStringList("favourite_contacts_numbers", phoneNumbers);

  }

  // Method to remove favourite contact
  static void removeFavouriteContact(String phoneNumber) async {

    favouriteContacts.removeWhere((contact) => contact.phoneNumber == phoneNumber);

    List<String> names = favouriteContacts.map((contact) => contact.name).toList();
    List<String> phoneNumbers = favouriteContacts.map((contact) => contact.phoneNumber).toList();

    await setStringList("favourite_contacts_names", names);
    await setStringList("favourite_contacts_numbers", phoneNumbers);

  }

}