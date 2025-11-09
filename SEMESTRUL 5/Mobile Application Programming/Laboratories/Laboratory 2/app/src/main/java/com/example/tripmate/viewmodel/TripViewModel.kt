package com.example.tripmate.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.ViewModel
import com.example.tripmate.data.TripRepository
import com.example.tripmate.model.Trip

class TripViewModel : ViewModel() {
    val trips: LiveData<List<Trip>> = TripRepository.trips()

    fun addTrip(t: Trip) = TripRepository.add(t)
    fun updateTrip(t: Trip) = TripRepository.update(t)
    fun deleteTrip(id: String) = TripRepository.remove(id)
    fun byId(id: String) = TripRepository.getById(id)
}
