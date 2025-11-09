plugins {
    id("com.android.application") version "8.9.3" apply false
    id("org.jetbrains.kotlin.android") version "2.0.21" apply false
}

buildscript {
    val agp_version by extra("8.7.0")
}

// NOTE: Repositories are configured in `settings.gradle.kts` via
// dependencyResolutionManagement to enforce a centralized repository policy.
// Avoid declaring `google()`/`mavenCentral()` here to prevent
// "prefer settings repositories over project repositories" errors.

