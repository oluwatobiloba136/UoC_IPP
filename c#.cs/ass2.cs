using System;
using System.Linq;


public class Olufisayo_Assignment_2
{
    public static void Main(string[] args)
    {
        // double[] tempss;
        double[] temps = new double[7];
        double sum_temps = 0, avg = 0; double temp_min; double temp_max;
        for (int i = 0; i < 7; i++)
        {
            string[] weekDays = new string[] { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" };



            Console.WriteLine($"Enter temperature for  {weekDays[i]}");
            // Console.WriteLine(temps[0])
            temps[i] = Convert.ToDouble(Console.ReadLine());

            sum_temps += temps[i];

        }

        avg = sum_temps / temps.Length;
        temp_min = temps.Min();
        temp_max = temps.Max();
            //Console.WriteLine("The Sum is : " + sum_temps);
        Console.WriteLine("The Average temperature is : " + avg);
        Console.WriteLine("The Min temperature is : " + temp_min);
        Console.WriteLine("The Max  temperature is : " + temp_max);
        Console.WriteLine("\n\nAscending: ");
        Array.Sort(temps);
        foreach (double i in temps)
        {
            Console.WriteLine(i);
        }
        Array.Reverse(temps);
        Console.WriteLine("\n\nDescending: ");
        foreach (double i in temps)
        {
            Console.WriteLine(i);
        }
    }
}