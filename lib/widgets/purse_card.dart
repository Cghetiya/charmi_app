import 'package:flutter/material.dart';
import '../models/purse.dart';

class PurseCard extends StatefulWidget {
  final Purse purse;
  final VoidCallback onAdd;

  const PurseCard({required this.purse, required this.onAdd, Key? key})
      : super(key: key);

  @override
  State<PurseCard> createState() => _PurseCardState();
}

class _PurseCardState extends State<PurseCard> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Like icon on top-left
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isLiked = !isLiked;
                  });
                },
                child: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 4),

            // Purse Image
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.purse.imageUrl,
                  fit: BoxFit.contain,
                  height: 120,
                ),
              ),
            ),

            SizedBox(height: 8),

            // Purse Name
            Text(
              widget.purse.name,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 4),

            // Price
            Text(
              '\$${widget.purse.price.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.grey[700]),
            ),

            SizedBox(height: 8),

            // Add Button
            ElevatedButton(
              onPressed: widget.onAdd,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
