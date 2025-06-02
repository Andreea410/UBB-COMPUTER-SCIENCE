using System.Data;
using System.Data.SqlClient;

namespace practiceSeminarExample
{
    public partial class add_insert_button : Form
    {
        private readonly SqlConnection sqlConnection;
        private readonly SqlDataAdapter daParentTable;
        private readonly SqlDataAdapter daChildTable;
        private readonly DataSet dset;
        private BindingSource bsParentTable;
        private BindingSource bsChildTable;
        private DataRelation dr;
        private string parentTableName;
        private string childTableName;
        private SqlCommandBuilder commandBuilder;

        private string GetConnectionString()
        {
            return "Data Source=DESKTOP-BVGO48P\\SQLEXPRESS;Initial Catalog=Practice;Integrated Security=SSPI;";
        }

        public add_insert_button()
        {
            InitializeComponent();
            try
            {
                sqlConnection = new SqlConnection(GetConnectionString());
                sqlConnection.Open();

                dset = new DataSet();
                parentTableName = "Users";
                childTableName = "Posts";

                string sqlParent = "SELECT * FROM Users";
                string sqlChild = "SELECT * FROM Posts";

                daParentTable = new SqlDataAdapter(sqlParent, sqlConnection);
                daParentTable.Fill(dset, parentTableName);

                daChildTable = new SqlDataAdapter(sqlChild, sqlConnection);
                daChildTable.Fill(dset, childTableName);

                var parentIdCol = dset.Tables[parentTableName].Columns["id"];
                var fkCol = dset.Tables[childTableName].Columns["userId"];
                dr = new DataRelation("FK_Parent_Child", parentIdCol, fkCol);
                dset.Relations.Add(dr);

                commandBuilder = new SqlCommandBuilder(daChildTable);
                daChildTable.InsertCommand = commandBuilder.GetInsertCommand();
                daChildTable.UpdateCommand = commandBuilder.GetUpdateCommand();
                daChildTable.DeleteCommand = commandBuilder.GetDeleteCommand();

                bsParentTable = new BindingSource { DataSource = dset, DataMember = parentTableName };
                bsChildTable = new BindingSource { DataSource = bsParentTable, DataMember = "FK_Parent_Child" };

                dgvUsers.DataSource = bsParentTable;
                dgvPosts.DataSource = bsChildTable;
                dgvUsers.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
                dgvPosts.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Database connection error: " + ex.Message);
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (bsChildTable.Current is DataRowView drv)
            {
                drv.Row.Delete();
                try
                {
                    daChildTable.Update(dset, childTableName);
                    MessageBox.Show("Row deleted successfully.");
                }
                catch (SqlException ex)
                {
                    MessageBox.Show("Error deleting row: " + ex.Message);
                }
            }
            else
            {
                MessageBox.Show("Please select a row to delete.");
            }
        }

        private void dgvUsers_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void add_update_button_Click(object sender, EventArgs e)
        {
            this.Validate();
            dgvPosts.EndEdit();
            bsChildTable.EndEdit();
            try
            {
                daChildTable.Update(dset, childTableName);
                MessageBox.Show("Changes saved successfully.");
            }
            catch (SqlException ex)
            {
                MessageBox.Show("Error saving changes: " + ex.Message);
            }
        }

        private void dgvPosts_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void add_insert_button_Load(object sender, EventArgs e)
        {

        }
    }
}
