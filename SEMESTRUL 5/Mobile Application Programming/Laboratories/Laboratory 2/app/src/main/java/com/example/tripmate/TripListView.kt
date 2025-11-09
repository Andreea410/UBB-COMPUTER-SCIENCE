package com.example.tripmate

import android.os.Build
import androidx.annotation.RequiresApi
import androidx.lifecycle.LiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.tripmate.data.TripRepository
import com.example.tripmate.model.Trip
import kotlinx.coroutines.launch

class TripListViewModel : ViewModel() {

    private val repository = TripRepository

    @RequiresApi(Build.VERSION_CODES.O)
    val allTrips: LiveData<List<Trip>> = repository.trips()

    @RequiresApi(Build.VERSION_CODES.O)
    fun deleteTrip(tripId: String) {
        viewModelScope.launch {
            repository.remove(tripId)
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    fun addTrip(trip: Trip) {
        viewModelScope.launch {
            repository.add(trip)
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    fun updateTrip(trip: Trip) {
        viewModelScope.launch {
            repository.update(trip)
        }
    }
}
