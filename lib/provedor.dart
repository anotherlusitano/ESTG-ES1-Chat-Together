import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsernamesProvider with ChangeNotifier {
  final Map<String, String> _usernamesCache = {};

  Future<String> getUsername(String userId) async {
    if (_usernamesCache.containsKey(userId)) {
      return _usernamesCache[userId]!;
    } else {
      var userDoc = await FirebaseFirestore.instance.collection('Utilizadores').doc(userId).get();
      String username = userDoc['username'].toString();
      _usernamesCache[userId] = username;
      notifyListeners();
      return username;
    }
  }
}
