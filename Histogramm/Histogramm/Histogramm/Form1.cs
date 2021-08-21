using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO.Ports;
using System.Windows.Forms.DataVisualization.Charting;

namespace Histogramm
{
    public partial class Form_Histogramm : Form
    {
        static SerialPort serialPort;
        static SortedDictionary<int, int> histogramm = new SortedDictionary<int, int>();
        static float K, L, M;

        public Form_Histogramm()
        {
            InitializeComponent();
        }

        private void updateCOMportsList()
        {
            this.comboBox_COMport.Items.Clear();
            this.comboBox_COMport.Items.AddRange(SerialPort.GetPortNames());
            this.comboBox_COMport.SelectedIndex = -1;
            this.comboBox_COMport.Text = "";
        }

        private void Form_Histogramm_Load(object sender, System.EventArgs e)
        {
            updateCOMportsList();
            this.chart_Histogramm.Legends.Clear();
        }

        private void button_refresh_COMports_Click(object sender, System.EventArgs e)
        {
            updateCOMportsList();
        }

        private void button_open_COMport_Click(object sender, System.EventArgs e)
        {      
            if (this.comboBox_COMport.SelectedIndex != -1)
            {
                if (this.textBox_K.Text == "" || this.textBox_L.Text == "" || this.textBox_M.Text == "")
                {
                    MessageBox.Show(
                        "Введите значения K, L, M",
                        "Ошибка",
                        MessageBoxButtons.OK,
                        MessageBoxIcon.Error,
                        MessageBoxDefaultButton.Button1,
                        MessageBoxOptions.DefaultDesktopOnly);
                    return;
                }

                try
                {
                    K = (float)Convert.ToDouble(this.textBox_K.Text);
                    L = (float)Convert.ToDouble(this.textBox_L.Text);
                    M = (float)Convert.ToDouble(this.textBox_M.Text);
                }
                catch (System.FormatException)
                {
                    MessageBox.Show(
                        "Неверный формат значений K, L, M",
                        "Ошибка",
                        MessageBoxButtons.OK,
                        MessageBoxIcon.Error,
                        MessageBoxDefaultButton.Button1,
                        MessageBoxOptions.DefaultDesktopOnly);
                    return;
                }

                try
                {
                    serialPort = new SerialPort(this.comboBox_COMport.SelectedItem.ToString(), 9600,
                        System.IO.Ports.Parity.None, 8, System.IO.Ports.StopBits.One);
                    serialPort.Open();
                }
                catch
                {
                    MessageBox.Show(
                        "Не удалось открыть последовательный порт " + this.comboBox_COMport.SelectedItem.ToString(),
                        "Ошибка",
                        MessageBoxButtons.OK,
                        MessageBoxIcon.Error,
                        MessageBoxDefaultButton.Button1,
                        MessageBoxOptions.DefaultDesktopOnly);
                    return;
                }
                this.comboBox_COMport.Enabled = false;
                this.button_open_COMport.Enabled = false;
                this.button_refresh_COMports.Enabled = false;
                this.button_close_COMport.Enabled = true;
                this.timer.Enabled = true;
                this.timer.Start();

                byte[] buffer = new byte[1];
                buffer[0] = 0x55;
                serialPort.Write(buffer, 0, 1);
            }
        }

        private void button_close_COMport_Click(object sender, System.EventArgs e)
        {
            serialPort.Close();
            this.comboBox_COMport.Enabled = true;
            this.button_open_COMport.Enabled = true;
            this.button_refresh_COMports.Enabled = true;
            this.button_close_COMport.Enabled = false;
            this.timer.Stop();
            this.timer.Enabled = false;
            updateCOMportsList();
        }

        private void timer_Tick(object sender, System.EventArgs e)
        {
            uint value = 0;
            for (int i = 0; i < 4; i++)
                value |= (uint)serialPort.ReadByte() << (8 * i);

            value = (uint)(value / (K * M * (System.Math.Abs(K - L) + 2)))/*22*/;

            // Add value to histogramm
            this.chart_Histogramm.Series["Quants"].Points.Clear();
            if (histogramm.ContainsKey((int)value))
            {
                histogramm[(int)value]++;
            }
            else
                histogramm.Add((int)value, 1);

            foreach (KeyValuePair<int, int> kvp in histogramm)
            {
                this.chart_Histogramm.Series["Quants"].Points.AddXY(kvp.Key, kvp.Value);
            }
        }
    }
}
