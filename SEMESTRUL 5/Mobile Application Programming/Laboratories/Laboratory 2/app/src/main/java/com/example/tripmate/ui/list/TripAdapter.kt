package com.example.tripmate.ui.list

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.example.tripmate.databinding.ItemTripBinding
import com.example.tripmate.model.Trip
import java.time.format.DateTimeFormatter

class TripAdapter(
    private val onEdit: (Trip) -> Unit,
    private val onDelete: (Trip) -> Unit
) : ListAdapter<Trip, TripAdapter.VH>(TripDiffCallback()) {

    init {
        // Enable stable IDs so RecyclerView can better animate and preserve
        // item state when lists are updated via DiffUtil.
        setHasStableIds(true)
    }

    class VH(val b: ItemTripBinding) : RecyclerView.ViewHolder(b.root)

    companion object {
        private val DISPLAY_FORMAT: DateTimeFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy")
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): VH {
        val b = ItemTripBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return VH(b)
    }

    override fun getItemId(position: Int): Long {
        // Use a stable long derived from the Trip id string.
        return try {
            getItem(position).id.hashCode().toLong()
        } catch (t: Exception) {
            super.getItemId(position)
        }
    }

    override fun onBindViewHolder(holder: VH, position: Int) {
        val t = getItem(position)
        holder.b.textName.text = t.name
        holder.b.textDestination.text = t.destination
        holder.b.textStart.text = t.startDate.format(DISPLAY_FORMAT)
        holder.b.textEnd.text = t.endDate.format(DISPLAY_FORMAT)
        holder.b.textBudget.text = t.totalBudget.toString()
        holder.b.btnEdit.setOnClickListener { onEdit(t) }
        holder.b.btnDelete.setOnClickListener { onDelete(t) }
    }

}

class TripDiffCallback : DiffUtil.ItemCallback<Trip>() {
    override fun areItemsTheSame(oldItem: Trip, newItem: Trip): Boolean =
        oldItem.id == newItem.id

    override fun areContentsTheSame(oldItem: Trip, newItem: Trip): Boolean =
        oldItem == newItem
}
