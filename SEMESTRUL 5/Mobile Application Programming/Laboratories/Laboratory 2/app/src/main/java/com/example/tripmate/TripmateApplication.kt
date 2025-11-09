// File: app/src/main/java/com/example/tripmate/TripMateApplication.kt
package com.example.tripmate

import android.app.Application

// The app currently uses an in-memory repository for Trips (see `TripRepository`).
// Realm setup was present but not used anywhere else. To avoid an unchecked
// cast warning and an unused dependency, remove the Realm initialization.
class TripMateApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        // No-op: keep Application subclass in case future app-wide initialization is needed.
    }
}