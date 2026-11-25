import 'package:flutter/material.dart';

abstract final class AppTextStyles {
  static const TextStyle headline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.5,

  );

  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3
  );

static const TextStyle body = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  height: 1.4,
);

static const TextStyle caption = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  height: 1.3,
);


static const TextStyle button = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,

);

static const TextStyle label = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w500,
);

static const TextStyle wordmark = TextStyle(
  fontSize: 56,
  fontWeight: FontWeight.w700,
  letterSpacing: 2,
  height: 1,

);
static const TextStyle tagline = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w400,
  height: 1.4,
);

}