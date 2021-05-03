import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.isMe, this.username, this.userImage, {this.key});
  final String message;
  final bool isMe;
  final Key key;
  final String username;
  final File userImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(12),
      ),
      width: 140,
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      margin: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      child: Column(
        children: [
          Text(message),
          Text(username),
        ],
      ),
    );
  }
}
