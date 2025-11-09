package com.example.tripmate.data

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.example.tripmate.model.Trip
import java.time.LocalDate

object TripRepository {
    private val _state = MutableLiveData<List<Trip>>(
        listOf(
            Trip(name = "Summer In Italy", destination = "Rome, Italy",
                startDate = LocalDate.of(2026, 6, 3), endDate = LocalDate.of(2026, 6, 10), totalBudget = 4500.0, notes = null),
            Trip(name = "Winter in Romania", destination = "Poiana Brasov, Romania",
                startDate = LocalDate.of(2026, 1, 4), endDate = LocalDate.of(2026, 1, 10), totalBudget = 2800.0, notes = null),
            Trip(name = "Childhood Dream", destination = "DisneyLand, Paris",
                startDate = LocalDate.of(2026, 9, 10), endDate = LocalDate.of(2026, 9, 14), totalBudget = 4500.0, notes = null)
        )
    )

    fun trips(): LiveData<List<Trip>> = _state

    @Synchronized
    fun add(trip: Trip) {
        val newList = (_state.value ?: emptyList()) + trip
        _state.value = newList
    }

    @Synchronized
    fun update(updated: Trip) {
        val newList = _state.value?.map { if (it.id == updated.id) updated else it }
        _state.value = newList
    }

    @Synchronized
    fun remove(id: String) {
        val newList = _state.value?.filterNot { it.id == id }
        _state.value = newList
    }

    fun getById(id: String) = _state.value?.firstOrNull { it.id == id }
}
