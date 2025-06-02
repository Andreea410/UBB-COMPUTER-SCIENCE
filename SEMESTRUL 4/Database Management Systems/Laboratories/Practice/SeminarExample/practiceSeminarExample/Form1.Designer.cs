namespace practiceSeminarExample
{
    partial class add_insert_button
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
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
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            dgvUsers = new DataGridView();
            dgvPosts = new DataGridView();
            add_update_button = new Button();
            button1 = new Button();
            ((System.ComponentModel.ISupportInitialize)dgvUsers).BeginInit();
            ((System.ComponentModel.ISupportInitialize)dgvPosts).BeginInit();
            SuspendLayout();
            // 
            // dgvUsers
            // 
            dgvUsers.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dgvUsers.Location = new Point(12, 63);
            dgvUsers.Name = "dgvUsers";
            dgvUsers.RowHeadersWidth = 51;
            dgvUsers.Size = new Size(300, 330);
            dgvUsers.TabIndex = 0;
            dgvUsers.CellContentClick += dgvUsers_CellContentClick;
            // 
            // dgvPosts
            // 
            dgvPosts.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dgvPosts.Location = new Point(488, 63);
            dgvPosts.Name = "dgvPosts";
            dgvPosts.RowHeadersWidth = 51;
            dgvPosts.Size = new Size(300, 330);
            dgvPosts.TabIndex = 1;
            dgvPosts.CellContentClick += dgvPosts_CellContentClick;
            // 
            // add_update_button
            // 
            add_update_button.Location = new Point(344, 166);
            add_update_button.Name = "add_update_button";
            add_update_button.Size = new Size(123, 29);
            add_update_button.TabIndex = 2;
            add_update_button.Text = "Add/Update";
            add_update_button.UseVisualStyleBackColor = true;
            add_update_button.Click += add_update_button_Click;
            // 
            // button1
            // 
            button1.Location = new Point(344, 239);
            button1.Name = "button1";
            button1.Size = new Size(123, 29);
            button1.TabIndex = 3;
            button1.Text = "Delete";
            button1.UseVisualStyleBackColor = true;
            button1.Click += button1_Click;
            // 
            // add_insert_button
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(button1);
            Controls.Add(add_update_button);
            Controls.Add(dgvPosts);
            Controls.Add(dgvUsers);
            Name = "add_insert_button";
            Text = "Add/Insert";
            Load += add_insert_button_Load;
            ((System.ComponentModel.ISupportInitialize)dgvUsers).EndInit();
            ((System.ComponentModel.ISupportInitialize)dgvPosts).EndInit();
            ResumeLayout(false);
        }

        #endregion

        private DataGridView dgvUsers;
        private DataGridView dgvPosts;
        private Button add_update_button;
        private Button button1;
    }
}
