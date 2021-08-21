
namespace Histogramm
{
    partial class Form_Histogramm
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
            this.components = new System.ComponentModel.Container();
            System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea1 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
            System.Windows.Forms.DataVisualization.Charting.Legend legend1 = new System.Windows.Forms.DataVisualization.Charting.Legend();
            System.Windows.Forms.DataVisualization.Charting.Series series1 = new System.Windows.Forms.DataVisualization.Charting.Series();
            System.Windows.Forms.DataVisualization.Charting.Title title1 = new System.Windows.Forms.DataVisualization.Charting.Title();
            System.Windows.Forms.DataVisualization.Charting.Title title2 = new System.Windows.Forms.DataVisualization.Charting.Title();
            this.label1 = new System.Windows.Forms.Label();
            this.comboBox_COMport = new System.Windows.Forms.ComboBox();
            this.button_open_COMport = new System.Windows.Forms.Button();
            this.button_refresh_COMports = new System.Windows.Forms.Button();
            this.button_close_COMport = new System.Windows.Forms.Button();
            this.timer = new System.Windows.Forms.Timer(this.components);
            this.chart_Histogramm = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.label2 = new System.Windows.Forms.Label();
            this.textBox_K = new System.Windows.Forms.TextBox();
            this.textBox_L = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.textBox_M = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.chart_Histogramm)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(10, 8);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(60, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "COM порт:";
            // 
            // comboBox_COMport
            // 
            this.comboBox_COMport.FormattingEnabled = true;
            this.comboBox_COMport.Location = new System.Drawing.Point(73, 5);
            this.comboBox_COMport.Name = "comboBox_COMport";
            this.comboBox_COMport.Size = new System.Drawing.Size(104, 21);
            this.comboBox_COMport.TabIndex = 1;
            // 
            // button_open_COMport
            // 
            this.button_open_COMport.Location = new System.Drawing.Point(182, 5);
            this.button_open_COMport.Name = "button_open_COMport";
            this.button_open_COMport.Size = new System.Drawing.Size(64, 20);
            this.button_open_COMport.TabIndex = 2;
            this.button_open_COMport.Text = "Открыть";
            this.button_open_COMport.UseVisualStyleBackColor = true;
            this.button_open_COMport.Click += new System.EventHandler(this.button_open_COMport_Click);
            // 
            // button_refresh_COMports
            // 
            this.button_refresh_COMports.Location = new System.Drawing.Point(251, 5);
            this.button_refresh_COMports.Name = "button_refresh_COMports";
            this.button_refresh_COMports.Size = new System.Drawing.Size(64, 20);
            this.button_refresh_COMports.TabIndex = 3;
            this.button_refresh_COMports.Text = "Обновить";
            this.button_refresh_COMports.UseVisualStyleBackColor = true;
            this.button_refresh_COMports.Click += new System.EventHandler(this.button_refresh_COMports_Click);
            // 
            // button_close_COMport
            // 
            this.button_close_COMport.Enabled = false;
            this.button_close_COMport.Location = new System.Drawing.Point(321, 5);
            this.button_close_COMport.Name = "button_close_COMport";
            this.button_close_COMport.Size = new System.Drawing.Size(64, 20);
            this.button_close_COMport.TabIndex = 4;
            this.button_close_COMport.Text = "Закрыть";
            this.button_close_COMport.UseVisualStyleBackColor = true;
            this.button_close_COMport.Click += new System.EventHandler(this.button_close_COMport_Click);
            // 
            // timer
            // 
            this.timer.Interval = 1;
            this.timer.Tick += new System.EventHandler(this.timer_Tick);
            // 
            // chart_Histogramm
            // 
            chartArea1.Name = "ChartArea1";
            this.chart_Histogramm.ChartAreas.Add(chartArea1);
            legend1.Name = "Legend1";
            this.chart_Histogramm.Legends.Add(legend1);
            this.chart_Histogramm.Location = new System.Drawing.Point(13, 58);
            this.chart_Histogramm.Name = "chart_Histogramm";
            series1.ChartArea = "ChartArea1";
            series1.Legend = "Legend1";
            series1.Name = "Quants";
            this.chart_Histogramm.Series.Add(series1);
            this.chart_Histogramm.Size = new System.Drawing.Size(372, 300);
            this.chart_Histogramm.TabIndex = 5;
            title1.Docking = System.Windows.Forms.DataVisualization.Charting.Docking.Bottom;
            title1.Name = "Quants";
            title1.Text = "Кванты";
            title2.Docking = System.Windows.Forms.DataVisualization.Charting.Docking.Left;
            title2.Name = "Count";
            title2.Text = "Количество";
            title2.TextOrientation = System.Windows.Forms.DataVisualization.Charting.TextOrientation.Rotated270;
            this.chart_Histogramm.Titles.Add(title1);
            this.chart_Histogramm.Titles.Add(title2);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 35);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(17, 13);
            this.label2.TabIndex = 6;
            this.label2.Text = "K:";
            // 
            // textBox_K
            // 
            this.textBox_K.Location = new System.Drawing.Point(33, 32);
            this.textBox_K.Name = "textBox_K";
            this.textBox_K.Size = new System.Drawing.Size(61, 20);
            this.textBox_K.TabIndex = 7;
            // 
            // textBox_L
            // 
            this.textBox_L.Location = new System.Drawing.Point(126, 32);
            this.textBox_L.Name = "textBox_L";
            this.textBox_L.Size = new System.Drawing.Size(61, 20);
            this.textBox_L.TabIndex = 9;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(105, 35);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(16, 13);
            this.label3.TabIndex = 8;
            this.label3.Text = "L:";
            // 
            // textBox_M
            // 
            this.textBox_M.Location = new System.Drawing.Point(221, 32);
            this.textBox_M.Name = "textBox_M";
            this.textBox_M.Size = new System.Drawing.Size(61, 20);
            this.textBox_M.TabIndex = 11;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(200, 35);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(19, 13);
            this.label4.TabIndex = 10;
            this.label4.Text = "M:";
            // 
            // Form_Histogramm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(397, 370);
            this.Controls.Add(this.textBox_M);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.textBox_L);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.textBox_K);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.chart_Histogramm);
            this.Controls.Add(this.button_close_COMport);
            this.Controls.Add(this.button_refresh_COMports);
            this.Controls.Add(this.button_open_COMport);
            this.Controls.Add(this.comboBox_COMport);
            this.Controls.Add(this.label1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.Name = "Form_Histogramm";
            this.Text = "Гистограмма";
            this.Load += new System.EventHandler(this.Form_Histogramm_Load);
            ((System.ComponentModel.ISupportInitialize)(this.chart_Histogramm)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox comboBox_COMport;
        private System.Windows.Forms.Button button_open_COMport;
        private System.Windows.Forms.Button button_refresh_COMports;
        private System.Windows.Forms.Button button_close_COMport;
        private System.Windows.Forms.Timer timer;
        private System.Windows.Forms.DataVisualization.Charting.Chart chart_Histogramm;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox textBox_K;
        private System.Windows.Forms.TextBox textBox_L;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox textBox_M;
        private System.Windows.Forms.Label label4;
    }
}

