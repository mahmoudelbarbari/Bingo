import 'package:bingo/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class FileUploadProgressCard extends StatelessWidget {
  final String fileName;
  final String fileSize;
  final double progress;
  final bool isCompleted;
  final VoidCallback? onDelete;

  const FileUploadProgressCard({
    super.key,
    required this.fileName,
    required this.fileSize,
    required this.progress,
    this.isCompleted = false,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isCompleted
                      ? Colors.green.withOpacity(0.1)
                      : Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.insert_drive_file,
                  color: isCompleted ? Colors.green : Colors.blue,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fileName,
                      style: TextStyle(
                        color: isCompleted ? Colors.green : Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      fileSize,
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
              ),
              if (isCompleted)
                Icon(Icons.check_circle, color: Colors.green, size: 22)
              else
                const SizedBox(width: 22),
              const SizedBox(width: 8),
              IconButton(
                icon: Image.asset(
                  isCompleted
                      ? Assets.images.redDeleteIcon.path
                      : Assets.images.greyDeleteIcon.path,
                ),
                onPressed: onDelete,
                tooltip: 'Delete',
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isCompleted ? Colors.green : Colors.blue,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                isCompleted
                    ? '100%'
                    : '${(progress * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  color: isCompleted ? Colors.green : Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
