import Array "mo:base/Array"; // Import Array module for working with arrays
import Float "mo:base/Float"; // Import Float module for floating-point operations

actor {
    // Define a record to store information about a single course
    type Course = {
        gradePoint: Float;    // The grade point earned in the course
        creditHours: Nat;     // The number of credit hours for the course
    };

    // A variable to store the list of all courses added by the user
    var courses: [Course] = [];

    // Function to add a new course to the list
    public func addCourse(gradePoint: Float, creditHours: Nat): async Text {
        // Append a new course record to the courses array
        courses := Array.append<Course>(courses, [{gradePoint; creditHours}]);
        return "Course added successfully!"; // Return a success message
    };

    // Function to calculate the Cumulative Grade Point Average (CGPA)
    public func calculateCGPA(): async Text {
        // Check if no courses have been added yet
        if (courses.size() == 0) {
            return "No courses added yet!"; // Notify the user if no courses are available
        };

        // Calculate the total grade points by multiplying grade points with credit hours for each course
        let totalGradePoints = Array.foldLeft<Course, Float>(courses, 0.0, func(acc: Float, course: Course): Float {
            acc + course.gradePoint * Float.fromInt(course.creditHours); // Accumulate weighted grade points
        });

        // Calculate the total credit hours by summing the credit hours for all courses
        let totalCreditHours = Array.foldLeft<Course, Nat>(courses, 0, func(acc: Nat, course: Course): Nat {
            acc + course.creditHours; // Accumulate credit hours
        });

        // Compute CGPA by dividing the total grade points by total credit hours
        let CGPA = totalGradePoints / Float.fromInt(totalCreditHours);

        // Return the computed CGPA as a formatted text
        return "Your CGPA is: " # Float.toText(CGPA);
    };

    // Function to clear all courses (reset the courses array)
    public func reset(): async Text {
        courses := []; // Reset the courses array to an empty array
        return "All courses cleared!"; // Notify the user that courses have been cleared
    };
};
