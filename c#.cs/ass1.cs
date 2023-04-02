using System;
using System.Transactions;

namespace OlufisayoAssignmentOne
{
    class Program
    {
        static void Main(string[] args)
        {
            // Prompt the user to enter the student name and assignment marks
            Console.Write("Enter student name: ");
            string name = Console.ReadLine();
            // Console.Write("Enter mark for assignment 1: ");
            // int mark1 = Convert.ToInt32(Console.ReadLine());
            // Console.Write("Enter mark for assignment 2: ");
            // int mark2 = Convert.ToInt32(Console.ReadLine());
            // Console.Write("Enter mark for assignment 3: ");
            // int mark3 = Convert.ToInt32(Console.ReadLine());

            int totalmark = 0;
            for (int i= 0; i < 3; i++)
            {
                string a;
                Console.WriteLine($"Enter for assignemt{i}");
                a = Console.ReadLine();
                totalmark += int.Parse(a);
            }

            // Calculate the total marks obtained out of 100
            // int totalMarks = mark1 + mark2 + mark3;
            // convert totalmark to double 
            double mark_percentage = (double)totalmark / 3;

            // Determine the letter grade based on the mark_percentage obtained
            string grade;
            if (mark_percentage >= 95)
            {
                grade = "A+";
            }
            else if (mark_percentage <= 94)
            {
                grade = "A";
            }
            else if (mark_percentage <= 89)
            {
                grade = "A-";
            }
            else if (mark_percentage <= 84)
            {
                grade = "B+";
            }
            else if (mark_percentage <= 79)
            {
                grade = "B";
            }
            else if (mark_percentage <= 74)
            {
                grade = "B-";
            }
            else if (mark_percentage <= 69)
            {
                grade = "C+";
            }
            else if (mark_percentage <= 66)
            {
                grade = "C";
            }
            else if (mark_percentage <= 63)
            {
                grade = "C-";
            }
            else if (mark_percentage <= 59)
            {
                grade = "D+";
            }
            else if (mark_percentage <= 54)
            {
                grade = "D";
            }
            else
            {
                grade = "F";
            }


            Console.WriteLine($"{name} your grade is {mark_percentage}");

            
            }
            // // Display the result
            // Console.WriteLine("Student Name: " + name);
            // Console.WriteLine("Total Marks Obtained: " + totalMarks);
            // Console.WriteLine("mark_percentage: " + mark_percentage + "%");
            // Console.WriteLine("Letter Grade: " + grade);
        
    }
}