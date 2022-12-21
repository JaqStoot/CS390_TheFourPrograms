import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;

public class advisor {

    public static void main(String[] args) throws IOException {
        Scanner scanner = new Scanner(System.in);

        Map<String, String[][]> completedCourses = new LinkedHashMap<>();
        Map<String, String[][]> uncompletedCourses = new LinkedHashMap<>();

        ArrayList<String> coursesToTakeNext = new ArrayList();

        System.out.print("Enter file name: ");
        String file = scanner.nextLine();

        double gpa = 0;
        int attemptedHours = 0;
        int completedHours = 0;
        int remainingCredits = 0;

        BufferedReader bf = new BufferedReader(new FileReader(file));

        String line;
        while ((line = bf.readLine()) != null) {
            String[] classInfo = line.trim().split("\\|", -1);

            String[] preReqs = classInfo[2].split(" ");
            String[][] preReqsCombinations = new String[preReqs.length][];

            for (int i = 0; i < preReqs.length; i++) {
                preReqs[i] = preReqs[i].replace("SeniorStanding", "Senior Standing");
            }


            for (int i = 0; i < preReqs.length; i++) {
                preReqsCombinations[i] = preReqs[i].split(",");
            }

            // If class was passed, move it to completed courses
            switch (classInfo[3]) {
                case "A":
                    completedCourses.put(classInfo[0], preReqsCombinations);
                    gpa += 4.0 * Integer.parseInt(classInfo[1]);
                    attemptedHours += Integer.parseInt(classInfo[1]);
                    completedHours += Integer.parseInt(classInfo[1]);
                    break;
                case "B":
                    completedCourses.put(classInfo[0], preReqsCombinations);
                    gpa += 3.0 * Integer.parseInt(classInfo[1]);
                    attemptedHours += Integer.parseInt(classInfo[1]);
                    completedHours += Integer.parseInt(classInfo[1]);
                    break;
                case "C":
                    completedCourses.put(classInfo[0], preReqsCombinations);
                    gpa += 2.0 * Integer.parseInt(classInfo[1]);
                    attemptedHours += Integer.parseInt(classInfo[1]);
                    completedHours += Integer.parseInt(classInfo[1]);
                    break;
                case "D":
                    completedCourses.put(classInfo[0], preReqsCombinations);
                    gpa += 1.0 * Integer.parseInt(classInfo[1]);
                    attemptedHours += Integer.parseInt(classInfo[1]);
                    completedHours += Integer.parseInt(classInfo[1]);
                    break;
                case "F":
                    uncompletedCourses.put(classInfo[0], preReqsCombinations);
                    attemptedHours += Integer.parseInt(classInfo[1]);
                    remainingCredits += Integer.parseInt(classInfo[1]);
                    break;
                default:
                    uncompletedCourses.put(classInfo[0], preReqsCombinations);
                    remainingCredits += Integer.parseInt(classInfo[1]);
                    break;
            }
        }

        // Calculate courses to take next
        for (String course: uncompletedCourses.keySet()) {
            if (uncompletedCourses.get(course)[0][0].equals("")) {
                coursesToTakeNext.add(course);
            }

            for (String[] preReqs: uncompletedCourses.get(course)) {
                for (String preReq: preReqs) {
                    Boolean takeNext = true;
                    if (!completedCourses.containsKey(preReq)) {
                        takeNext = false;
                    }

                    if (takeNext) {
                        if (!coursesToTakeNext.contains(course)) {
                            coursesToTakeNext.add(course);
                        }
                        break;
                    }
                }
            }
        }

        // Calculate GPA
        if(attemptedHours != 0) {
            gpa = gpa / attemptedHours;
        }

        // Display results
        System.out.println("File: " + file);
        System.out.println("GPA: " + String.format("%.2f", gpa));
        System.out.println("Hours Attempted: " + attemptedHours);
        System.out.println("Hours Completed: " + completedHours);
        System.out.println("Credits Remaining: " + remainingCredits + "\n");

        System.out.println("Possible Courses to Take Next");
        if (remainingCredits == 0) {
            System.out.println("None - Congratulations!");
        } else {
            for (String name : coursesToTakeNext) {
                System.out.println("    " + name);
            }
        }
    }
}
