import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConnectionIcon extends StatelessWidget {
  final Stream<bool> connectionStateStream;

  const ConnectionIcon({
    required this.connectionStateStream,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: connectionStateStream,
      builder: (context, snapshot) {
        final isDisabled = snapshot.data == false;

        return isDisabled
            ? Padding(
                padding: const EdgeInsets.all(16).r,
                child: Icon(
                  Icons.signal_wifi_connected_no_internet_4,
                  color: Theme.of(context).colorScheme.error,
                  size: 24.r,
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
