import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/app_config.dart';

import '../services/remote_config_service.dart';

class ForceUpdateDialog extends StatefulWidget {
  const ForceUpdateDialog({
    super.key,
    required this.requirement,
    required this.onCheckAgain,
  });

  final AppUpdateRequirement requirement;
  final Future<void> Function() onCheckAgain;

  @override
  State<ForceUpdateDialog> createState() => _ForceUpdateDialogState();
}

class _ForceUpdateDialogState extends State<ForceUpdateDialog> {
  bool _busy = false;
  String? _error;

  Future<void> _run(Future<void> Function() action) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
    } catch (_) {
      if (mounted) {
        setState(() => _error = 'Unable to open the store. Please try again.');
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _openStore() async {
    final uri = Uri.parse(AppConfig.appStoreUrl);
    if (!['https', 'http'].contains(uri.scheme) ||
        uri.host.isEmpty ||
        !await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw StateError('Unable to open the app store');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: const Text('Update required'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please update the app to continue.\n'
              'Your version: ${widget.requirement.currentVersion}\n'
              'Minimum version: ${widget.requirement.minimumVersion}',
            ),
            if (_error != null) Text(_error!),
          ],
        ),
        actions: [
          TextButton(
            onPressed: _busy ? null : () => _run(widget.onCheckAgain),
            child: const Text('Check again'),
          ),
          FilledButton(
            onPressed: _busy ? null : () => _run(_openStore),
            child: const Text('Update now'),
          ),
        ],
      ),
    );
  }
}
