import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showInAppMessage(String message, ToastificationType toastificationType) {
  toastification.show(
    style: ToastificationStyle.flat,
    type: toastificationType,
    autoCloseDuration: const Duration(seconds: 5),
    description: Text(message),
    alignment: Alignment.topRight,
    direction: TextDirection.ltr,
    borderSide: const BorderSide(color: Color(0xFF1F2833)),
    animationDuration: const Duration(milliseconds: 300),
    backgroundColor: const Color(0xFF0B0C10),
    foregroundColor: const Color(0xFFC5C6C7),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      )
    ],
    showProgressBar: true,
    closeButtonShowType: CloseButtonShowType.onHover,
    closeOnClick: false,
    pauseOnHover: true,
    dragToClose: true,
    applyBlurEffect: true,
  );
}
