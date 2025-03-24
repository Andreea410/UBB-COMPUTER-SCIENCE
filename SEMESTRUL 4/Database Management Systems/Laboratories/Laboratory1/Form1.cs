using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace Laboratory1
{
    public partial class Form1 : Form
    {
        SqlConnection conn;
        SqlDataAdapter daBookings;
        SqlDataAdapter daClients;
        DataSet dset;
        BindingSource bsBookings;
        BindingSource bsClients;
        DataRelation dr;

        SqlCommandBuilder cmdBuilder;

        public Form1()
        {
            InitializeComponent();

            try
            {
                conn = new SqlConnection("Data Source=DESKTOP-BVGO48P\\SQLEXPRESS; Initial Catalog=Booking; Integrated Security=True");
                ClientsDataGrid.AutoGenerateColumns = true;
                BookingsDataGrid.AutoGenerateColumns = true;
                dset = new DataSet();

                daClients = new SqlDataAdapter("SELECT * FROM Client", conn);
                daClients.Fill(dset, "Client");

                daBookings = new SqlDataAdapter("SELECT * FROM Booking", conn);
                daBookings.Fill(dset, "Booking");

                DataColumn ClientsID = dset.Tables["Client"].Columns["id"];
                DataColumn BookingClientsID = dset.Tables["Booking"].Columns["clientID"];
                dr = new DataRelation("FK_Booking_Clients", ClientsID, BookingClientsID);
                dset.Relations.Add(dr);

                bsClients = new BindingSource { DataSource = dset, DataMember = "Client" };
                bsBookings = new BindingSource { DataSource = bsClients, DataMember = "FK_Booking_Clients" };

                ClientsDataGrid.DataSource = bsClients;
                BookingsDataGrid.DataSource = bsBookings;

                ClientsDataGrid.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
                BookingsDataGrid.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Database error: " + ex.Message);
            }
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (BookingsDataGrid.SelectedRows.Count > 0)
            {
                DataGridViewRow selectedRow = BookingsDataGrid.SelectedRows[0];

                int id = Convert.ToInt32(selectedRow.Cells["id"].Value);
                string location = selectedRow.Cells["location"].Value?.ToString() ?? "";
                int capacity = Convert.ToInt32(selectedRow.Cells["capacity"].Value ?? 0);

                string query = "UPDATE Booking SET location = @location, capacity = @capacity WHERE id = @id";
                using (SqlCommand command = new SqlCommand(query, conn))
                {
                    command.Parameters.AddWithValue("@id", id);
                    command.Parameters.AddWithValue("@location", location);
                    command.Parameters.AddWithValue("@capacity", capacity);

                    try
                    {
                        if (conn.State == ConnectionState.Closed)
                            conn.Open();

                        int rowsAffected = command.ExecuteNonQuery();
                        MessageBox.Show(rowsAffected > 0 ? "Booking updated!" : "No rows updated.");
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("Error updating booking: " + ex.Message);
                    }
                    finally
                    {
                        conn.Close(); 
                    }
                }
            }
            else
            {
                MessageBox.Show("Please select a booking row to update.");
            }
        }



        private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void BookingsDataGrid_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            if (ClientsDataGrid.SelectedRows.Count == 0)
            {
                MessageBox.Show("Select a client to assign the booking to.");
                return;
            }

            int id = Convert.ToInt32(BookingsDataGrid.SelectedRows[0].Cells["id"].Value);
            int clientID = Convert.ToInt32(ClientsDataGrid.SelectedRows[0].Cells["id"].Value);

            string location = "New Location";  
            int capacity = 5;                  

            string insertQuery = @"INSERT INTO Booking (id,location, capacity, ownerID, clientID, paymentID)
                           VALUES (@id, @location, @capacity, @ownerID, @clientID, @paymentID)";

            using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
            {
                cmd.Parameters.AddWithValue("@id", id);
                cmd.Parameters.AddWithValue("@location", location);
                cmd.Parameters.AddWithValue("@capacity", capacity);
                cmd.Parameters.AddWithValue("@ownerID", 12);     
                cmd.Parameters.AddWithValue("@clientID", clientID);
                cmd.Parameters.AddWithValue("@paymentID", 1);    

                try
                {
                    if (conn.State == ConnectionState.Closed)
                        conn.Open();

                    int rows = cmd.ExecuteNonQuery();
                    MessageBox.Show(rows > 0 ? "Booking added!" : "Insert failed.");

                    dset.Tables["Booking"].Clear();
                    daBookings.Fill(dset, "Booking");
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error adding booking: " + ex.Message);
                }
                finally
                {
                    conn.Close();
                }
            }
        }

        private void button1_Click_2(object sender, EventArgs e)
        {
            if (BookingsDataGrid.SelectedRows.Count == 0)
            {
                MessageBox.Show("Select a booking to delete.");
                return;
            }

            int bookingID = Convert.ToInt32(BookingsDataGrid.SelectedRows[0].Cells["id"].Value);

            string deleteQuery = "DELETE FROM Booking WHERE id = @id";

            using (SqlCommand cmd = new SqlCommand(deleteQuery, conn))
            {
                cmd.Parameters.AddWithValue("@id", bookingID);

                try
                {
                    if (conn.State == ConnectionState.Closed)
                        conn.Open();

                    int rows = cmd.ExecuteNonQuery();
                    MessageBox.Show(rows > 0 ? "Booking deleted!" : "Delete failed.");

                    dset.Tables["Booking"].Clear();
                    daBookings.Fill(dset, "Booking");
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error deleting booking: " + ex.Message);
                }
                finally
                {
                    conn.Close();
                }
            }
        }
    }
}
