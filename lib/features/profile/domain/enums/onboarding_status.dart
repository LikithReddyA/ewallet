enum OnboardingStatus { pendingSource, completed }

class OnboardingStatusMapper {
  static OnboardingStatus fromString(String value) {
    return OnboardingStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => OnboardingStatus.pendingSource,
    );
  }
}
