using System;

class Program {
    static void Main(string[] args) {
        // Prompt the user to enter the student name and assignment marks
        Console.Write("Enter student name: ");
        string name = Console.ReadLine();
        Console.Write("Enter mark for assignment 1: ");
        int mark1 = Convert.ToInt32(Console.ReadLine());
        Console.Write("Enter mark for assignment 2: ");
        int mark2 = Convert.ToInt32(Console.ReadLine());
        Console.Write("Enter mark for assignment 3: ");
        int mark3 = Convert.ToInt32(Console.ReadLine());
        int marks[3] =ew 
        int markLopped = 0;
        for(int i = 0;i<3;i++){
            Console.Write($"looped Enter mark for assignment {i}: ");
            markLopped += i;
        }


        // Calculate the total marks obtained out of 100
        int totalMarks = mark1 + mark2 + mark3;
        double percentage = (double)totalMarks / 3;

        // Determine the letter grade based on the percentage obtained
        char grade;
        if (percentage >= 90) {
            grade = 'A';
        } else if (percentage >= 80) {
            grade = 'B';
        } else if (percentage >= 70) {
            grade = 'C';
        } else if (percentage >= 60) {
            grade = 'D';
        } else if (percentage >= 50) {
            grade = 'E';
        } else {
            grade = 'F';
        }

        // Display the result
        Console.WriteLine("Student Name: " + name);
        Console.WriteLine("Total Marks Obtained: " + totalMarks);
        Console.WriteLine("Percentage: " + percentage + "%");
        Console.WriteLine("Letter Grade: " + grade);
    }
}