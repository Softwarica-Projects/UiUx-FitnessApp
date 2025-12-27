import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';

enum ListAnimationType { None, FadeIn, Scale, Slide, Flip }

const defaultAnimationDuration = Duration(milliseconds: 1000);
const defaultAnimationDelay = Duration(milliseconds: 50);

class AnimatedItemWidget extends StatelessWidget {
  final ListAnimationType listAnimationType;
  final Widget child;

  final SlideConfiguration? slideConfiguration;
  final FadeInConfiguration? fadeInConfiguration;
  final ScaleConfiguration? scaleConfiguration;
  final FlipConfiguration? flipConfiguration;

  AnimatedItemWidget({
    Key? key,
    required this.child,
    this.listAnimationType = ListAnimationType.Slide,
    SlideConfiguration? slideConfiguration,
    FadeInConfiguration? fadeInConfiguration,
    ScaleConfiguration? scaleConfiguration,
    FlipConfiguration? flipConfiguration,
  })  : slideConfiguration = slideConfiguration ?? SlideConfiguration(),
        fadeInConfiguration = fadeInConfiguration ?? FadeInConfiguration(),
        scaleConfiguration = scaleConfiguration ?? ScaleConfiguration(),
        flipConfiguration = flipConfiguration ?? FlipConfiguration(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (listAnimationType == ListAnimationType.FadeIn) {
      return FadeInAnimationWidget(
        child: child,
        duration: fadeInConfiguration!.duration,
        curve: fadeInConfiguration!.curve,
        delay: fadeInConfiguration!.delay,
      );
    } else if (listAnimationType == ListAnimationType.Flip) {
      return FadeInAnimationWidget(
        delay: flipConfiguration!.delay,
        curve: flipConfiguration!.curve,
        duration: flipConfiguration!.duration,
        child: FlipAnimationWidget(
          child: child,
          delay: flipConfiguration!.delay,
          curve: flipConfiguration!.curve,
          duration: flipConfiguration!.duration,
          flipAxis: flipConfiguration!.flipAxis,
        ),
      );
    } else if (listAnimationType == ListAnimationType.Slide) {
      return FadeInAnimationWidget(
        delay: slideConfiguration!.delay,
        curve: slideConfiguration!.curve,
        duration: slideConfiguration!.duration,
        child: SlideAnimationWidget(
          child: child,
          delay: slideConfiguration!.delay,
          curve: slideConfiguration!.curve,
          duration: slideConfiguration!.duration,
          horizontalOffset: slideConfiguration!.horizontalOffset,
          verticalOffset: slideConfiguration!.verticalOffset,
        ),
      );
    } else if (listAnimationType == ListAnimationType.Scale) {
      return FadeInAnimationWidget(
        delay: scaleConfiguration!.delay,
        curve: scaleConfiguration!.curve,
        duration: scaleConfiguration!.duration,
        child: ScaleAnimationWidget(
          child: child,
          delay: scaleConfiguration!.delay,
          curve: scaleConfiguration!.curve,
          duration: scaleConfiguration!.duration,
          scale: scaleConfiguration!.scale,
        ),
      );
    } else {
      return child;
    }
  }
}

class FadeInConfiguration {
  final Duration? duration;
  final Duration? delay;
  final Curve curve;

  FadeInConfiguration({
    this.duration = defaultAnimationDuration,
    this.delay = defaultAnimationDelay,
    this.curve = Curves.easeOutQuart,
  });
}

class ScaleConfiguration {
  final Duration? duration;
  final Duration? delay;
  final Curve curve;
  final double scale;

  ScaleConfiguration({
    this.duration = const Duration(milliseconds: 400),
    this.delay = defaultAnimationDelay,
    this.curve = Curves.ease,
    this.scale = 0.0,
  });
}

class SlideConfiguration {
  final Duration? duration;
  final Duration? delay;
  final Curve curve;
  final double? verticalOffset;
  final double? horizontalOffset;

  SlideConfiguration({
    this.duration = defaultAnimationDuration,
    this.delay = defaultAnimationDelay,
    this.curve = Curves.easeOutQuart,
    this.verticalOffset = 100.0,
    this.horizontalOffset = 0.0,
  });
}

class FlipConfiguration {
  final Duration? duration;
  final Duration? delay;
  final Curve curve;
  final FlipAxisClass flipAxis;

  FlipConfiguration({
    this.duration = defaultAnimationDuration,
    this.delay = defaultAnimationDelay,
    this.curve = Curves.easeOutQuart,
    this.flipAxis = FlipAxisClass.x,
  });
}

class AnimationLimiterWidget extends StatefulWidget {
  final Widget child;

  const AnimationLimiterWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _AnimationLimiterWidgetState createState() => _AnimationLimiterWidgetState();

  static bool? shouldRunAnimation(BuildContext context) {
    return _AnimationLimiterProviderClass.of(context)?.shouldRunAnimation;
  }
}

class _AnimationLimiterWidgetState extends State<AnimationLimiterWidget> {
  bool _shouldRunAnimation = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((Duration value) {
      if (!mounted) return;
      setState(() {
        _shouldRunAnimation = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _AnimationLimiterProviderClass(
      shouldRunAnimation: _shouldRunAnimation,
      child: widget.child,
    );
  }
}

class _AnimationLimiterProviderClass extends InheritedWidget {
  final bool? shouldRunAnimation;

  _AnimationLimiterProviderClass({
    this.shouldRunAnimation,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static _AnimationLimiterProviderClass? of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<_AnimationLimiterProviderClass>();
  }
}

class AnimationConfigurationClass extends InheritedWidget {
  final int position;
  final Duration duration;
  final Duration? delay;
  final int columnCount;

  const AnimationConfigurationClass.synchronized({
    Key? key,
    this.duration = const Duration(milliseconds: 40),
    required Widget child,
  })  : position = 0,
        delay = Duration.zero,
        columnCount = 1,
        super(key: key, child: child);

  const AnimationConfigurationClass.staggeredList({
    Key? key,
    required this.position,
    this.duration = const Duration(milliseconds: 225),
    this.delay,
    required Widget child,
  })  : columnCount = 1,
        super(key: key, child: child);

  const AnimationConfigurationClass.staggeredGrid({
    Key? key,
    required this.position,
    this.duration = const Duration(milliseconds: 225),
    this.delay,
    required this.columnCount,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static List<Widget> toStaggeredList({
    Duration? duration,
    Duration? delay,
    required Widget Function(Widget) childAnimationBuilder,
    required List<Widget> children,
  }) =>
      children
          .asMap()
          .map((index, widget) {
            return MapEntry(
              index,
              AnimationConfigurationClass.staggeredList(
                position: index,
                duration: duration ?? const Duration(milliseconds: 225),
                delay: delay,
                child: childAnimationBuilder(widget),
              ),
            );
          })
          .values
          .toList();

  static AnimationConfigurationClass? of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<AnimationConfigurationClass>();
  }
}

class AnimationConfiguratorClass extends StatelessWidget {
  final Duration? duration;
  final Duration? delay;
  final Widget Function(Animation<double>) animatedChildBuilder;

  const AnimationConfiguratorClass({
    Key? key,
    this.duration,
    this.delay,
    required this.animatedChildBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationConfiguration = AnimationConfigurationClass.of(context);

    if (animationConfiguration == null) {
      throw FlutterError.fromParts(
        <DiagnosticsNode>[
          ErrorSummary('Animation not wrapped in an AnimationConfiguration.'),
          ErrorDescription('This error happens if you use an Animation that is not wrapped in an '
              'AnimationConfiguration.'),
          ErrorHint('The solution is to wrap your Animation(s) with an AnimationConfiguration. '
              'Reminder: an AnimationConfiguration provides the configuration '
              'used as a base for every children Animation. Configuration made in AnimationConfiguration '
              'can be overridden in Animation children if needed.'),
        ],
      );
    }

    final _position = animationConfiguration.position;
    final _duration = duration ?? animationConfiguration.duration;
    final _delay = delay ?? animationConfiguration.delay;
    final _columnCount = animationConfiguration.columnCount;

    return AnimationExecutorClass(
      duration: _duration,
      delay: stagger(_position, _duration, _delay, _columnCount),
      builder: (context, animationController) => animatedChildBuilder(animationController!),
    );
  }

  Duration stagger(int position, Duration duration, Duration? delay, int columnCount) {
    var delayInMilliseconds = (delay == null ? duration.inMilliseconds ~/ 6 : delay.inMilliseconds);

    int _computeStaggeredGridDuration() {
      return (position ~/ columnCount + position % columnCount) * delayInMilliseconds;
    }

    int _computeStaggeredListDuration() {
      return position * delayInMilliseconds;
    }

    return Duration(milliseconds: columnCount > 1 ? _computeStaggeredGridDuration() : _computeStaggeredListDuration());
  }
}

typedef AnimatedConfigBuilder = Widget Function(BuildContext context, AnimationController? animationController);

class AnimationExecutorClass extends StatefulWidget {
  final Duration duration;
  final Duration delay;
  final AnimatedConfigBuilder builder;

  const AnimationExecutorClass({
    Key? key,
    required this.duration,
    this.delay = Duration.zero,
    required this.builder,
  }) : super(key: key);

  @override
  _AnimationExecutorClassState createState() => _AnimationExecutorClassState();
}

class _AnimationExecutorClassState extends State<AnimationExecutorClass> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(duration: widget.duration, vsync: this);

    if (AnimationLimiterWidget.shouldRunAnimation(context) ?? true) {
      _timer = Timer(widget.delay, () => _animationController!.forward());
    } else {
      _animationController!.value = 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: _animationController!,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController!.dispose();
    super.dispose();
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return widget.builder(context, _animationController);
  }
}

class FadeInAnimationWidget extends StatelessWidget {
  final Duration? duration;
  final Duration? delay;
  final Curve curve;
  final Widget child;

  const FadeInAnimationWidget({
    Key? key,
    this.duration,
    this.delay,
    this.curve = Curves.ease,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguratorClass(
      duration: duration,
      delay: delay,
      animatedChildBuilder: _fadeInAnimation,
    );
  }

  Widget _fadeInAnimation(Animation<double> animation) {
    final _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(0.0, 1.0, curve: curve),
      ),
    );

    return Opacity(
      opacity: _opacityAnimation.value,
      child: child,
    );
  }
}

enum FlipAxisClass {
  x,
  y,
}

class FlipAnimationWidget extends StatelessWidget {
  final Duration? duration;
  final Duration? delay;
  final Curve curve;
  final FlipAxisClass flipAxis;
  final Widget child;

  const FlipAnimationWidget({
    Key? key,
    this.duration,
    this.delay,
    this.curve = Curves.ease,
    this.flipAxis = FlipAxisClass.x,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguratorClass(
      duration: duration,
      delay: delay,
      animatedChildBuilder: _flipAnimation,
    );
  }

  Widget _flipAnimation(Animation<double> animation) {
    final _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(0.0, 1.0, curve: curve),
      ),
    );

    Matrix4 _computeTransformationMatrix() {
      var radians = (1 - _flipAnimation.value) * pi / 2;

      switch (flipAxis) {
        case FlipAxisClass.y:
          return Matrix4.rotationY(radians);
        case FlipAxisClass.x:
        default:
          return Matrix4.rotationX(radians);
      }
    }

    return Transform(
      transform: _computeTransformationMatrix(),
      alignment: Alignment.center,
      child: child,
    );
  }
}

class ScaleAnimationWidget extends StatelessWidget {
  final Duration? duration;
  final Duration? delay;
  final Curve curve;
  final double scale;
  final Widget child;

  const ScaleAnimationWidget({
    Key? key,
    this.duration,
    this.delay,
    this.curve = Curves.ease,
    this.scale = 0.0,
    required this.child,
  })  : assert(scale >= 0.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguratorClass(
      duration: duration,
      delay: delay,
      animatedChildBuilder: _landingAnimation,
    );
  }

  Widget _landingAnimation(Animation<double> animation) {
    final _landingAnimation = Tween<double>(begin: scale, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(0.0, 1.0, curve: curve),
      ),
    );

    return Transform.scale(
      scale: _landingAnimation.value,
      child: child,
    );
  }
}

class SlideAnimationWidget extends StatelessWidget {
  final Duration? duration;
  final Duration? delay;
  final Curve curve;
  final double verticalOffset;
  final double horizontalOffset;
  final Widget child;

  const SlideAnimationWidget({
    Key? key,
    this.duration,
    this.delay,
    this.curve = Curves.ease,
    double? verticalOffset,
    double? horizontalOffset,
    required this.child,
  })  : verticalOffset = verticalOffset ?? 50.0,
        horizontalOffset = horizontalOffset ?? 0.0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguratorClass(
      duration: duration,
      delay: delay,
      animatedChildBuilder: _slideAnimation,
    );
  }

  Widget _slideAnimation(Animation<double> animation) {
    Animation<double> offsetAnimation(double offset, Animation<double> animation) {
      return Tween<double>(begin: offset, end: 0.0).animate(
        CurvedAnimation(
          parent: animation,
          curve: Interval(0.0, 1.0, curve: curve),
        ),
      );
    }

    return Transform.translate(
      offset: Offset(
        horizontalOffset == 0.0 ? 0.0 : offsetAnimation(horizontalOffset, animation).value,
        verticalOffset == 0.0 ? 0.0 : offsetAnimation(verticalOffset, animation).value,
      ),
      child: child,
    );
  }
}
//endregion
