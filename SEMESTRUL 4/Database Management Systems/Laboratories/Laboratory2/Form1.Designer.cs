namespace Laboratory2
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
            this.parentTableDataViewGrid = new System.Windows.Forms.DataGridView();
            this.childTableDataGridView = new System.Windows.Forms.DataGridView();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.deleteButton = new System.Windows.Forms.Button();
            this.updateButton = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.parentTableDataViewGrid)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.childTableDataGridView)).BeginInit();
            this.SuspendLayout();
            // 
            // parentTableDataViewGrid
            // 
            this.parentTableDataViewGrid.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.parentTableDataViewGrid.Location = new System.Drawing.Point(24, 52);
            this.parentTableDataViewGrid.Name = "parentTableDataViewGrid";
            this.parentTableDataViewGrid.RowHeadersWidth = 51;
            this.parentTableDataViewGrid.RowTemplate.Height = 24;
            this.parentTableDataViewGrid.Size = new System.Drawing.Size(329, 458);
            this.parentTableDataViewGrid.TabIndex = 0;
            this.parentTableDataViewGrid.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.parentTableDataViewGrid_CellContentClick);
            // 
            // childTableDataGridView
            // 
            this.childTableDataGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.childTableDataGridView.Location = new System.Drawing.Point(554, 52);
            this.childTableDataGridView.Name = "childTableDataGridView";
            this.childTableDataGridView.RowHeadersWidth = 51;
            this.childTableDataGridView.RowTemplate.Height = 24;
            this.childTableDataGridView.Size = new System.Drawing.Size(343, 458);
            this.childTableDataGridView.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(689, 33);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(76, 16);
            this.label1.TabIndex = 2;
            this.label1.Text = "Child Table";
            this.label1.Click += new System.EventHandler(this.label1_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(121, 33);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(85, 16);
            this.label2.TabIndex = 3;
            this.label2.Text = "Parent Table";
            this.label2.Click += new System.EventHandler(this.label2_Click);
            // 
            // deleteButton
            // 
            this.deleteButton.Location = new System.Drawing.Point(383, 224);
            this.deleteButton.Name = "deleteButton";
            this.deleteButton.Size = new System.Drawing.Size(141, 23);
            this.deleteButton.TabIndex = 5;
            this.deleteButton.Text = "Delete";
            this.deleteButton.UseVisualStyleBackColor = true;
            this.deleteButton.Click += new System.EventHandler(this.deleteButton_Click);
            // 
            // updateButton
            // 
            this.updateButton.Location = new System.Drawing.Point(383, 306);
            this.updateButton.Name = "updateButton";
            this.updateButton.Size = new System.Drawing.Size(141, 23);
            this.updateButton.TabIndex = 6;
            this.updateButton.Text = "Update/Insert";
            this.updateButton.UseVisualStyleBackColor = true;
            this.updateButton.Click += new System.EventHandler(this.button1_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(919, 572);
            this.Controls.Add(this.updateButton);
            this.Controls.Add(this.deleteButton);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.childTableDataGridView);
            this.Controls.Add(this.parentTableDataViewGrid);
            this.Name = "Form1";
            this.Text = "Form1";
            ((System.ComponentModel.ISupportInitialize)(this.parentTableDataViewGrid)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.childTableDataGridView)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView parentTableDataViewGrid;
        private System.Windows.Forms.DataGridView childTableDataGridView;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button deleteButton;
        private System.Windows.Forms.Button updateButton;
    }
}

