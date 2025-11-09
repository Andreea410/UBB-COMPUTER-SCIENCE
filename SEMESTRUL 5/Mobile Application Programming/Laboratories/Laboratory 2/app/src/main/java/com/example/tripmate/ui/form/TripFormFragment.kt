package com.example.tripmate.ui.form

import android.app.DatePickerDialog
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import com.example.tripmate.databinding.FragmentTripFormBinding
import com.example.tripmate.model.Trip
import com.example.tripmate.viewmodel.TripViewModel
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.UUID
import java.util.Calendar
import android.view.MotionEvent

class TripFormFragment : Fragment() {

    private var _binding: FragmentTripFormBinding? = null
    private val binding get() = _binding!!

    private val vm: TripViewModel by activityViewModels()
    private var editingId: String? = null

    private val INPUT_DATE_FMT = DateTimeFormatter.ofPattern("dd-MM-yyyy")

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentTripFormBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        editingId = arguments?.getString("tripId")

        editingId?.let { id ->
            vm.byId(id)?.let { trip ->
                binding.editName.setText(trip.name)
                binding.editDestination.setText(trip.destination)
                binding.editStartDate.setText(trip.startDate.format(INPUT_DATE_FMT))
                binding.editEndDate.setText(trip.endDate.format(INPUT_DATE_FMT))
                binding.editBudget.setText(trip.totalBudget.toString())
                binding.editNotes.setText(trip.notes ?: "")
                binding.buttonSave.text = "Update Trip"
            }
        }

        // Make date fields non-editable and show a DatePicker when touched/clicked.
        // Use touch listener and disable keyboard input to ensure consistent behavior
        // across devices/emulators.
        binding.editStartDate.apply {
            isFocusable = false
            isFocusableInTouchMode = false
            isClickable = true
            // disable keyboard
            inputType = android.text.InputType.TYPE_NULL
            setOnTouchListener { _, event ->
                if (event.action == MotionEvent.ACTION_UP) {
                    val initial = try {
                        LocalDate.parse(text?.toString().orEmpty(), INPUT_DATE_FMT)
                    } catch (_: Exception) { null }
                    showDatePicker(initial) { ld -> setText(ld.format(INPUT_DATE_FMT)) }
                }
                true
            }
        }

        binding.editEndDate.apply {
            isFocusable = false
            isFocusableInTouchMode = false
            isClickable = true
            inputType = android.text.InputType.TYPE_NULL
            setOnTouchListener { _, event ->
                if (event.action == MotionEvent.ACTION_UP) {
                    val initial = try {
                        LocalDate.parse(text?.toString().orEmpty(), INPUT_DATE_FMT)
                    } catch (_: Exception) { null }
                    showDatePicker(initial) { ld -> setText(ld.format(INPUT_DATE_FMT)) }
                }
                true
            }
        }

        binding.buttonSave.setOnClickListener {
            val name = binding.editName.text?.toString()?.trim().orEmpty()
            val dest = binding.editDestination.text?.toString()?.trim().orEmpty()
            val startStr = binding.editStartDate.text?.toString()?.trim().orEmpty()
            val endStr = binding.editEndDate.text?.toString()?.trim().orEmpty()
            val budget = binding.editBudget.text?.toString()?.toDoubleOrNull() ?: 0.0
            val notes = binding.editNotes.text?.toString()?.trim().takeIf { it?.isNotEmpty() == true }

            binding.tilName.error = null
            binding.tilDestination.error = null
            binding.tilStart.error = null
            binding.tilEnd.error = null

            var hasError = false
            if (name.isEmpty()) { binding.tilName.error = "Required"; hasError = true }
            if (dest.isEmpty()) { binding.tilDestination.error = "Required"; hasError = true }
            if (startStr.isEmpty()) { binding.tilStart.error = "Required"; hasError = true }
            if (endStr.isEmpty()) { binding.tilEnd.error = "Required"; hasError = true }
            if (hasError) return@setOnClickListener

            val startDate = try {
                LocalDate.parse(startStr, INPUT_DATE_FMT)
            } catch (_: Exception) {
                binding.tilStart.error = "Use format dd-MM-yyyy"
                return@setOnClickListener
            }

            val endDate = try {
                LocalDate.parse(endStr, INPUT_DATE_FMT)
            } catch (_: Exception) {
                binding.tilEnd.error = "Use format dd-MM-yyyy"
                return@setOnClickListener
            }

            if (endDate.isBefore(startDate)) {
                binding.tilEnd.error = "End date must be after start date"
                return@setOnClickListener
            }

            val trip = Trip(
                id = editingId ?: UUID.randomUUID().toString(),
                name = name,
                destination = dest,
                startDate = startDate,
                endDate = endDate,
                totalBudget = budget,
                notes = notes
            )

            if (editingId == null) vm.addTrip(trip) else vm.updateTrip(trip)
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }

    private fun showDatePicker(initial: LocalDate?, onSelected: (LocalDate) -> Unit) {
        val now = initial ?: LocalDate.now()
        // DatePickerDialog uses month index 0..11
        val dp = DatePickerDialog(requireContext(), { _, year, month, dayOfMonth ->
            val picked = LocalDate.of(year, month + 1, dayOfMonth)
            onSelected(picked)
        }, now.year, now.monthValue - 1, now.dayOfMonth)
        dp.show()
    }
}
