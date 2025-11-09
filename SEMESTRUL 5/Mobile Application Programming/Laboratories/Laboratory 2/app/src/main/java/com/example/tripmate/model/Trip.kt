package com.example.tripmate.model

import java.time.LocalDate
import java.util.UUID

data class Trip(
    val id: String = UUID.randomUUID().toString(),
    val name: String,
    val destination: String,
    val startDate: LocalDate,
    val endDate: LocalDate,
    val totalBudget: Double,
    val notes: String?
)
