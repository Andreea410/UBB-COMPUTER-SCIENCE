package com.example.tripmate.ui.list

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.appcompat.app.AlertDialog
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.tripmate.databinding.FragmentTripListBinding
import com.example.tripmate.model.Trip
import com.example.tripmate.viewmodel.TripViewModel

class TripListFragment : Fragment() {

    private var _binding: FragmentTripListBinding? = null
    private val binding get() = _binding!!

    private val viewModel: TripViewModel by activityViewModels()
    private lateinit var adapter: TripAdapter

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentTripListBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        adapter = TripAdapter(
            onEdit = { trip: Trip ->
                val bundle = Bundle().apply { putString("tripId", trip.id) }
                findNavController().navigate(com.example.tripmate.R.id.action_list_to_form, bundle)
            },
            onDelete = { trip: Trip ->
                showDeleteConfirmation(trip)
            }
        )

        binding.recyclerViewTrips.layoutManager = LinearLayoutManager(requireContext())
        binding.recyclerViewTrips.adapter = adapter

        viewModel.trips.observe(viewLifecycleOwner) { trips ->
            adapter.submitList(trips)
        }

        binding.fabAdd.setOnClickListener {
            findNavController().navigate(com.example.tripmate.R.id.action_list_to_form)
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }

    private fun showDeleteConfirmation(trip: Trip) {
        AlertDialog.Builder(requireActivity())
            .setTitle("Delete trip")
            .setMessage("Are you sure you want to delete \"${trip.name}\"?")
            .setPositiveButton("Delete") { _, _ -> viewModel.deleteTrip(trip.id) }
            .setNegativeButton("Cancel", null)
            .show()
    }
}
