namespace Laboratory1
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.UpdateButton = new System.Windows.Forms.Button();
            this.BookingsDataGrid = new System.Windows.Forms.DataGridView();
            this.ClientsDataGrid = new System.Windows.Forms.DataGridView();
            this.BookingsLabel = new System.Windows.Forms.Label();
            this.ClientsLabel = new System.Windows.Forms.Label();
            this.AddButton = new System.Windows.Forms.Button();
            this.RemoveButton = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.BookingsDataGrid)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ClientsDataGrid)).BeginInit();
            this.SuspendLayout();
            // 
            // UpdateButton
            // 
            this.UpdateButton.Location = new System.Drawing.Point(428, 217);
            this.UpdateButton.Name = "UpdateButton";
            this.UpdateButton.Size = new System.Drawing.Size(105, 39);
            this.UpdateButton.TabIndex = 0;
            this.UpdateButton.Text = "Update";
            this.UpdateButton.UseVisualStyleBackColor = true;
            this.UpdateButton.Click += new System.EventHandler(this.button1_Click);
            // 
            // BookingsDataGrid
            // 
            this.BookingsDataGrid.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.BookingsDataGrid.Location = new System.Drawing.Point(25, 43);
            this.BookingsDataGrid.Name = "BookingsDataGrid";
            this.BookingsDataGrid.RowHeadersWidth = 51;
            this.BookingsDataGrid.RowTemplate.Height = 24;
            this.BookingsDataGrid.Size = new System.Drawing.Size(378, 421);
            this.BookingsDataGrid.TabIndex = 1;
            this.BookingsDataGrid.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.BookingsDataGrid_CellContentClick);
            // 
            // ClientsDataGrid
            // 
            this.ClientsDataGrid.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.ClientsDataGrid.Location = new System.Drawing.Point(567, 43);
            this.ClientsDataGrid.Name = "ClientsDataGrid";
            this.ClientsDataGrid.RowHeadersWidth = 51;
            this.ClientsDataGrid.RowTemplate.Height = 24;
            this.ClientsDataGrid.Size = new System.Drawing.Size(387, 421);
            this.ClientsDataGrid.TabIndex = 2;
            this.ClientsDataGrid.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView2_CellContentClick);
            // 
            // BookingsLabel
            // 
            this.BookingsLabel.AutoSize = true;
            this.BookingsLabel.Location = new System.Drawing.Point(175, 24);
            this.BookingsLabel.Name = "BookingsLabel";
            this.BookingsLabel.Size = new System.Drawing.Size(64, 16);
            this.BookingsLabel.TabIndex = 3;
            this.BookingsLabel.Text = "Bookings";
            this.BookingsLabel.Click += new System.EventHandler(this.label1_Click);
            // 
            // ClientsLabel
            // 
            this.ClientsLabel.AutoSize = true;
            this.ClientsLabel.Location = new System.Drawing.Point(742, 24);
            this.ClientsLabel.Name = "ClientsLabel";
            this.ClientsLabel.Size = new System.Drawing.Size(47, 16);
            this.ClientsLabel.TabIndex = 4;
            this.ClientsLabel.Text = "Clients";
            this.ClientsLabel.Click += new System.EventHandler(this.label2_Click);
            // 
            // AddButton
            // 
            this.AddButton.Location = new System.Drawing.Point(428, 144);
            this.AddButton.Name = "AddButton";
            this.AddButton.Size = new System.Drawing.Size(105, 37);
            this.AddButton.TabIndex = 5;
            this.AddButton.Text = "Add";
            this.AddButton.UseVisualStyleBackColor = true;
            this.AddButton.Click += new System.EventHandler(this.button1_Click_1);
            // 
            // RemoveButton
            // 
            this.RemoveButton.Location = new System.Drawing.Point(428, 288);
            this.RemoveButton.Name = "RemoveButton";
            this.RemoveButton.Size = new System.Drawing.Size(105, 38);
            this.RemoveButton.TabIndex = 6;
            this.RemoveButton.Text = "Remove";
            this.RemoveButton.UseVisualStyleBackColor = true;
            this.RemoveButton.Click += new System.EventHandler(this.button1_Click_2);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1009, 511);
            this.Controls.Add(this.RemoveButton);
            this.Controls.Add(this.AddButton);
            this.Controls.Add(this.ClientsLabel);
            this.Controls.Add(this.BookingsLabel);
            this.Controls.Add(this.ClientsDataGrid);
            this.Controls.Add(this.BookingsDataGrid);
            this.Controls.Add(this.UpdateButton);
            this.Name = "Form1";
            this.Text = "Form1";
            ((System.ComponentModel.ISupportInitialize)(this.BookingsDataGrid)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ClientsDataGrid)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button UpdateButton;
        private System.Windows.Forms.DataGridView BookingsDataGrid;
        private System.Windows.Forms.DataGridView ClientsDataGrid;
        private System.Windows.Forms.Label BookingsLabel;
        private System.Windows.Forms.Label ClientsLabel;
        private System.Windows.Forms.Button AddButton;
        private System.Windows.Forms.Button RemoveButton;
    }
}

