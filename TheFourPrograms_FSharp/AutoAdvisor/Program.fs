open System.IO
open System.Collections.Generic

printf "File: "
let file = System.Console.ReadLine()

let fileContents = File.ReadAllText(file).Replace("||", "| |")
let values = fileContents.Split('|', '\n')
let courses = new List<string>()
let credits = new List<int>()
let preqs = new List<string>()
let grades = new List<string>()

let mutable gpa = 0.0
let mutable attempted = 0
let mutable completed = 0
let mutable remaining = 0

let completedCourses = new List<string>()
let next = new List<string>()

let mutable andLogic = false
let mutable finalAnd = false
let mutable orLogic = false
let mutable finalOr = false

let rec getValues n limit col =
    let mutable colX = col
    if n < limit then
        if colX = 4 then
            colX <- 0
        
        match colX with
        | 0 -> courses.Add(values.[n])
        | 1 -> credits.Add(values.[n] |> int)
        | 2 -> preqs.Add(values.[n])
        | 3 -> grades.Add(values.[n])
        | _ -> printfn "ERROR"
        
        
        getValues (n+1) limit (colX+1)
        
let calCompletedCourses n x =
        completedCourses.Add(courses.[n])
        gpa <- gpa + float(x * credits.[n])
        attempted <- attempted + credits.[n]
        completed <- completed + credits.[n]
        
let rec getCompletedCourses n limit =
    if n < limit then
        match grades.[n] with
        | "A" -> calCompletedCourses n 4
        | "B" -> calCompletedCourses n 3
        | "C" -> calCompletedCourses n 2
        | "D" -> calCompletedCourses n 1
        | "F" -> attempted <- attempted + credits.[n]
        | _ -> ()
        
        getCompletedCourses (n+1) limit
        
let checkAnd (str: string) =
    let mutable out = true
    let andClasses = str.Split(',')
    
    for course in andClasses do
        if not (completedCourses.Contains course) then
            out <- false
    out

let checkOr (str: string) =
    let mutable orOut = false
    let orClasses = str.Split(' ')
    
    for course in orClasses do
        if checkAnd course then
            orOut <- true
    
    orOut
        
let getLogic n =
    andLogic <- false
    orLogic <- false

    if preqs.[n].Contains "," then
        andLogic <- true
        
    if preqs.[n].Contains " " && preqs.[n] <> " " && preqs.[n] <> "Senior Standing" then
        orLogic <- true
        
    if not orLogic && andLogic then
        finalAnd <- checkAnd preqs.[n]
        
    if orLogic then
        finalOr <- checkOr preqs.[n]
        
let rec getNextCourses n limit =
    if n < limit then
        if not (completedCourses.Contains courses.[n]) then
            remaining <- remaining + credits.[n]
            getLogic n
            
            if preqs.[n] = " " && grades.[n] = "" then
                next.Add(courses.[n])
                
            if completedCourses.Contains preqs.[n] then
                next.Add(courses.[n])
                
            if andLogic && finalAnd then
                next.Add(courses.[n])
                
            if orLogic && finalOr then
                next.Add(courses.[n])
            
        getNextCourses (n+1) limit
        
let displayResults x =
    if attempted = 0 then
        gpa <- 0.00
    else
        gpa <- gpa/float(attempted)
        
    printfn "GPA: %.2f" gpa
    printfn "Attempted: %d" attempted
    printfn "Completed: %d" completed
    printfn "Remaining: %d" remaining
    
    printfn "Next courses:"
    if remaining = 0 then
        printfn "None - Congratulations!"
    else
        for i in next do
            printfn "%s" i

let main() =
    getValues 0 (Seq.length values) 0
    
    getCompletedCourses 0 (Seq.length grades)
    
    getNextCourses 0 (Seq.length courses)
    
    displayResults 0
        
main()
