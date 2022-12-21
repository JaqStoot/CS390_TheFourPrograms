import java.util.*;
import java.io.*;

public class report {
    public static void main(String[] args) {
        int grade = 0, points_earned = 0, points_possible;
        Scanner scanLine = null;
        ArrayList<String> assignmentType = new ArrayList<>(5);
        ArrayList<String[]> dataList = new ArrayList<>(100);
        Collections.addAll(assignmentType, "Homework", "Group", "Project", "Programming","Quizzes","Exams");
        Scanner scan = new Scanner(System.in);
        System.out.print("Enter the name of the file: ");
        String fname = scan.next().toLowerCase();
        System.out.println("File: " + fname);
        try {
            scanLine = new Scanner(new File("C:\\Users\\jacob\\Documents\\NetBeansProjects\\grades\\students\\" + fname));

        } catch (FileNotFoundException e) {
            System.out.println("An error occurred.");
        }
        points_possible = scanLine.nextInt();
        while (scanLine.hasNextLine()){
            String[] s = scanLine.nextLine().split(" ");
            s = cleanArray(s);

            dataList.add(removeNull(s));
        }

        dataList.remove(0);
        for(int i = 0; i < dataList.size(); i++){
            dataList.set(i,formatEntry(dataList.get(i),assignmentType));
        }


        ArrayList<String[]> GroupProject = new ArrayList<>(10);
        ArrayList<String[]> Homework = new ArrayList<>(10);
        ArrayList<String[]> Programming = new ArrayList<>(10);
        ArrayList<String[]> Quizzes = new ArrayList<>(10);
        ArrayList<String[]> Exams = new ArrayList<>(10);

        for(int i = 0; i < dataList.size(); i++){
            String[] s = dataList.get(i);
            switch(s[1]){
                case "Group Project": GroupProject.add(dataList.get(i));
                    break;
                case "Homework": Homework.add(dataList.get(i));
                    break;
                case "Programming": Programming.add(dataList.get(i));
                    break;
                case "Quizzes": Quizzes.add(dataList.get(i));
                    break;
                case "Exams": Exams.add(dataList.get(i));
                    break;
            }
        }
        int ptsEarned = 0, ptsPossible = 0;
        for(String[] s : GroupProject){
            ptsPossible += Integer.parseInt(s[2]);
            ptsEarned += Integer.parseInt(s[3]);
        }
        System.out.print("Group Project");
        System.out.printf("\t\t%5s%.0f", "(", ((float)ptsPossible/(float)points_possible)*100);
        System.out.println("%)");
        System.out.println("============================================");
        for(String[] s : GroupProject){
            System.out.printf("%s \t%5d/%d \t%3.0f", s[0], Integer.parseInt(s[3]), Integer.parseInt(s[2]), (Float.parseFloat(s[3])/Float.parseFloat(s[2]))*100);
            System.out.println("%");
        }
        System.out.println("============================================");
        System.out.printf("\t\t\t%5d/%d \t%3.1f", ptsEarned, ptsPossible, ((float)ptsEarned/(float)ptsPossible)*100);
        System.out.println("%\n");


        ptsEarned = ptsPossible = 0;
        for(String[] s : Homework){
            ptsPossible += Integer.parseInt(s[2]);
            ptsEarned += Integer.parseInt(s[3]);
        }
        System.out.print("Homework");
        System.out.printf("\t\t%5s%.0f", "(", ((float)ptsPossible/(float)points_possible)*100);
        System.out.println("%)");
        System.out.println("============================================");
        for(String[] s : Homework){
            System.out.printf("%s \t%5d/%d \t%3.0f", s[0], Integer.parseInt(s[3]), Integer.parseInt(s[2]), (Float.parseFloat(s[3])/Float.parseFloat(s[2]))*100);
            System.out.println("%");
        }
        System.out.println("============================================");
        System.out.printf("\t\t\t%5d/%d \t%3.1f", ptsEarned, ptsPossible, ((float)ptsEarned/(float)ptsPossible)*100);
        System.out.println("%\n");


        ptsEarned = ptsPossible = 0;
        for(String[] s : Programming){
            ptsPossible += Integer.parseInt(s[2]);
            ptsEarned += Integer.parseInt(s[3]);
        }
        System.out.print("Programming");
        System.out.printf("\t\t%5s%.0f", "(", ((float)ptsPossible/(float)points_possible)*100);
        System.out.println("%)");
        System.out.println("============================================");
        for(String[] s : Programming){
            System.out.printf("%-20s \t%5d/%d \t%3.0f", s[0], Integer.parseInt(s[3]), Integer.parseInt(s[2]), (Float.parseFloat(s[3])/Float.parseFloat(s[2]))*100);
            System.out.println("%");
        }
        System.out.println("============================================");
        System.out.printf("\t\t\t%5d/%d \t%3.1f", ptsEarned, ptsPossible, ((float)ptsEarned/(float)ptsPossible)*100);
        System.out.println("%\n");


        ptsEarned = ptsPossible = 0;
        for(String[] s : Quizzes){
            ptsPossible += Integer.parseInt(s[2]);
            ptsEarned += Integer.parseInt(s[3]);
        }
        System.out.print("Quizzes");
        System.out.printf("\t\t\t%5s%.0f", "(", ((float)ptsPossible/(float)points_possible)*100);
        System.out.println("%)");
        System.out.println("============================================");
        for(String[] s : Quizzes){
            System.out.printf("%-20s \t%5d/%d \t%3.0f", s[0], Integer.parseInt(s[3]), Integer.parseInt(s[2]), (Float.parseFloat(s[3])/Float.parseFloat(s[2]))*100);
            System.out.println("%");
        }
        System.out.println("============================================");
        System.out.printf("\t\t\t%5d/%d \t%3.1f", ptsEarned, ptsPossible, ((float)ptsEarned/(float)ptsPossible)*100);
        System.out.println("%\n");


        ptsEarned = ptsPossible = 0;
        for(String[] s : Exams){
            ptsPossible += Integer.parseInt(s[2]);
            ptsEarned += Integer.parseInt(s[3]);
        }
        System.out.print("Exams");
        System.out.printf("\t\t\t%5s%.0f", "(", ((float)ptsPossible*100/(float)points_possible)*100);
        System.out.println("%)");
        System.out.println("============================================");
        for(String[] s : Exams){
            System.out.printf("%-20s \t%5d/%d \t%3.0f", s[0], Integer.parseInt(s[3]), Integer.parseInt(s[2]), (Float.parseFloat(s[3])/Float.parseFloat(s[2]))*100);
            System.out.println("%");
        }
        System.out.println("============================================");
        System.out.printf("\t\t\t%5d/%d \t%3.1f", ptsEarned, ptsPossible, ((float)ptsEarned/(float)ptsPossible)*100);
        System.out.println("%\n");

        ptsEarned = ptsPossible = 0;
        for(String[] s : dataList){
            points_earned += Integer.parseInt(s[3]);
            ptsPossible += Integer.parseInt(s[2]);
        }
        grade = (points_earned * 100)/points_possible;
        System.out.println("Current Grade: " + grade + "%");
        int maximum = 0, minimum = 0;

        minimum = points_earned / ptsPossible;
        maximum = ((points_earned + (points_possible - ptsPossible))*100)/(points_possible);

        System.out.println("Minimum Final Grade: " + minimum + "%");
        System.out.println("Maximum Final Grade: " + maximum + "%");

    }



    public static String[] cleanArray(String[] s){
        String[] newString = new String[s.length];

        int k = 0;
        for(int i = 0; i < s.length; i++){
            if(!s[i].equals("")){
                newString[k++] = s[i];
            }
        }
        return newString;
    }

    public static String[] removeNull(String[] s){
        int i = 0;
        while(s[i] != null){
            i++;
        }
        String[] newString = new String[i];

        for(int j = 0; j < newString.length; j++){
            newString[j] = s[j];
        }
        return newString;
    }
    public static String[] formatEntry(String[] s, ArrayList<String> assignmentType){
        int k = 0;
        for(int i = 0; i < s.length; i++){
            if(!assignmentType.contains(s[i]))
                k++;
            else
                break;
        }
        String[] newString = new String[4];
        String str = "";
        String str2 = "";
        if("Group".equals(s[k])){
            for(int i = 0; i < k; i++){
                str += " " + s[i];
            }
            str2 = s[k] + " " + s[k+1];
            newString[0] = str;
            newString[1] = str2;
            newString[2] = s[k+2];
            newString[3] = s[k+3];
        }else{
            for(int i = 0; i < k; i++){
                str += s[i] + " ";
            }
            newString[0] = str;
            newString[1] = s[k];
            newString[2] = s[k+1];
            newString[3] = s[k+2];

        }
        return newString;
    }



}
