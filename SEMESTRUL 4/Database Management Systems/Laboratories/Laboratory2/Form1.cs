using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Windows.Forms;

namespace Laboratory2
{
    public partial class Form1 : Form
    {
        private SqlConnection connection;
        private SqlDataAdapter daParentTable;
        private SqlDataAdapter daChildTable;
        private DataSet dset;
        private BindingSource bsParentTable;
        private BindingSource bsChildTable;
        private DataRelation dr;
        private string parentTableName;
        private string childTableName;
        private SqlCommandBuilder commandBuilder;

        private string GetConnectionString()
        {
            return ConfigurationManager
                   .ConnectionStrings["connectionString"]
                   .ConnectionString;
        }

        public Form1()
        {
            InitializeComponent();
            try
            {
                connection = new SqlConnection(GetConnectionString());
                connection.Open();

                dset = new DataSet();

                parentTableName = ConfigurationManager.AppSettings["parentTable"];
                string sqlRawParents = ConfigurationManager.AppSettings["sql.SelectAllParent"];
                string sqlParents = sqlRawParents.Replace("{parentTable}", parentTableName);
                daParentTable = new SqlDataAdapter(sqlParents, connection);
                daParentTable.Fill(dset, parentTableName);

                childTableName = ConfigurationManager.AppSettings["childTable"];
                string sqlRawChildren = ConfigurationManager.AppSettings["sql.SelectAllChildren"];
                string sqlChildren = sqlRawChildren.Replace("{childTable}", childTableName);
                daChildTable = new SqlDataAdapter(sqlChildren, connection);
                daChildTable.Fill(dset, childTableName);

                var parentIdCol = dset.Tables[parentTableName].Columns[
                    ConfigurationManager.AppSettings["parentKey"] ?? "id"];
                var fkCol = dset.Tables[childTableName].Columns[
                    ConfigurationManager.AppSettings["foreignKey"]];
                dr = new DataRelation("FK_Parent_Child", parentIdCol, fkCol);
                dset.Relations.Add(dr);

                commandBuilder = new SqlCommandBuilder(daChildTable);
                daChildTable.InsertCommand = commandBuilder.GetInsertCommand();
                daChildTable.UpdateCommand = commandBuilder.GetUpdateCommand();
                daChildTable.DeleteCommand = commandBuilder.GetDeleteCommand();

                bsParentTable = new BindingSource { DataSource = dset, DataMember = parentTableName };
                bsChildTable = new BindingSource { DataSource = bsParentTable, DataMember = "FK_Parent_Child" };

                parentTableDataViewGrid.DataSource = bsParentTable;
                childTableDataGridView.DataSource = bsChildTable;
                parentTableDataViewGrid.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
                childTableDataGridView.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Database connection error: " + ex.Message);
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Validate();                         
            childTableDataGridView.EndEdit();        
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

        private void deleteButton_Click(object sender, EventArgs e)
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

        private void insertButton_Click(object sender, EventArgs e)
        { }

        private void parentTableDataViewGrid_CellContentClick(object sender, EventArgs e)
        { }
        
        private void label1_Click(object sender, EventArgs e)
        { }

        private void label2_Click(object sender, EventArgs e)
        { }

    }
}
