open System
open System.Collections.Generic
open System.IO

let listAssignName = new List<string>()
let listCategory = new List<string>()
let listPossPoints = new List<int>()
let listEarnPoints = new List<int>()
let mutable posspointstotal = 0
let mutable earnpointstotal = 0
let mutable posspointstotal2 = 0

let mutable grouptotal = 0
let mutable groupearn = 0
let mutable progtotal = 0
let mutable progearn = 0
let mutable quizzestotal = 0
let mutable quizzesearn = 0
let mutable homeworktotal = 0
let mutable homeworkearn = 0


let mutable index = 0
let mutable total = 0
let mutable earn = 0
let mutable posstotal = 0
let mutable earntotal = 0
let mutable string = ""
let mutable pcnt = 0.
let mutable currAssign = ""

let mutable currGrade = 0
let mutable minFinal = 0
let mutable maxFinal = 0

//POINT CALCULATIONS AND PRINT
let outputLoop string total earn = 
    printfn ""
    printfn "%s"string
    printfn "==================================="
    for i in listCategory do
        if (i = string) then
            let posstotal = listPossPoints[index]
            let earntotal = listEarnPoints[index]
            let currAssign = listAssignName[index]
            printfn "%s %i/%i" currAssign earntotal posstotal
        index <- index + 1
    printfn "==================================="
    let pcnt = (earn*100)/total
    index <- 0
    posspointstotal <- posspointstotal + total
    earnpointstotal <- earnpointstotal + earn
    printfn "                      %i/%i %i Percent" earn total pcnt


type Data() = 
    member x.Read() = 
        printf "File: "
        let file = System.Console.ReadLine()
        use stream = new StreamReader(file)
        posspointstotal2 <- stream.ReadLine() |> int
        let mutable valid = true
        while (valid) do
            let line = stream.ReadLine()
            if (line = null) then
                valid <- false
            else
                if(line[20..32] = "Group Project") then
                    listAssignName.Add(line[0..19])
                    listCategory.Add(line[20..32])
                    grouptotal <- grouptotal + (line[40..41] |> int)
                    groupearn <- groupearn + (line[54..55] |> int)
                    listPossPoints.Add(line[40..41] |> int)
                    listEarnPoints.Add(line[54..55] |> int)
                    printfn "%A" (line)
                if(line[20..30] = "Programming") then
                    listAssignName.Add(line[0..19])
                    listCategory.Add(line[20..30])
                    progtotal <- progtotal + (line[40..41] |> int)
                    progearn <- progearn + (line[54..55] |> int)
                    listPossPoints.Add(line[40..41] |> int)
                    listEarnPoints.Add(line[54..55] |> int)
                    printfn "%A" (line)
                if(line[20..26] = "Quizzes") then
                    listAssignName.Add(line[0..19])
                    listCategory.Add(line[20..26])
                    quizzestotal <- quizzestotal + (line[40..41] |> int)
                    quizzesearn <- quizzesearn + (line[54..55] |> int)
                    listPossPoints.Add(line[40..41] |> int)
                    listEarnPoints.Add(line[54..55] |> int)
                    printfn "%A" (line)
                if(line[20..27] = "Homework") then
                    listAssignName.Add(line[0..19])
                    listCategory.Add(line[20..27])
                    homeworktotal <- homeworktotal + (line[40..41] |> int)
                    homeworkearn <- homeworkearn + (line[54..55] |> int)
                    listPossPoints.Add(line[40..41] |> int)
                    listEarnPoints.Add(line[54..55] |> int)
                    printfn "%A" (line)


let main() = 
    let data = Data()
    data.Read()

    outputLoop "Group Project" grouptotal groupearn
    outputLoop "Programming" progtotal progearn
    outputLoop "Quizzes" quizzestotal quizzesearn
    outputLoop "Homework" homeworktotal homeworkearn

    let currGrade = earnpointstotal*100/posspointstotal
    let minFinal = earnpointstotal*100/posspointstotal2
    let maxFinal = (posspointstotal2 - (posspointstotal-earnpointstotal))/10 
    
    printfn "Current Grade: %i" (currGrade)
    printfn "Minimum Final Grade: %i" (minFinal)
    printfn "Maximum Final Grade: %i" (maxFinal)
main()
(*
// For more information see https://aka.ms/fsharp-console-apps
open System
open System.IO

let mutable listAssignName = []
let mutable listCategory = []
let mutable listPossPoints = []
let mutable listEarnPoints = []
let mutable posspointstotal = 0
let mutable earnpointstotal = 0

(*
let mutable listTemp = []
let mutable groupprojecttotal = 0
let mutable groupprojectearn = 0
let mutable progtotal = 0
let mutable progearn = 0
let mutable quizzestotal = 0
let mutable quizzesearn = 0
let mutable homeworktotal = 0
let mutable homeworkearn = 0
*)

let mutable index = 0
let mutable total = 0
let mutable earn = 0
let mutable posstotal = 0
let mutable earntotal = 0
let mutable string = ""
let mutable pcnt = 0

let mutable currGrade = 0
let mutable minFinal = 0
let mutable maxFinal = 0

//POINT CALCULATIONS AND PRINT
let outputLoop string total earn posstotal earntotal = 
    let index = 0
    
    printfn "%s"string
    printfn "================================================================"
    for i in listCategory do
        if (i == string) then
            let total = total + listPossPoints[index]
            let earn = earn + listEarnPoints[index]
            let posstotal = posstotal + listPossPoints[index]
            let earntotal = earntotal + listEarnPoints[index]
            let index = index + 1
            printfn "%s %i/%i" listAssignName[index] listEarnPoints[index] listPossPoints[index]
    printfn "================================================================"
    let pcnt = (earntotal*100)/posstotal
    printfn "                                        %i/%i  %i" earntotal posstotal pcnt



let main() = 

    // Read filename to Sequence
    let mutable lines = File.ReadAllLines("file name")

    // Convert lines to list
    let mutable list = Seq.toList lines
    // list now holds all lines of file in accessible strings

    for i in list do
        if (i.exists("Group Project") then
            listAssignName.append(temp[i[0,19]])
            listCategory.append(i[20..39])
            listPossPoints.append(i[40..41].toInt)
            listEarnPoints.append(i[54..55].toInt)
        elif (i.exists("Programming") then
            listAssignName.append(i[0,19])
            listCategory.append(i[20..39])
            listPossPoints.append(i[40..41].toInt)
            listEarnPoints.append(i[54..55].toInt)
        elif (i.exists("Quizzes") then
            listAssignName.append(i[0,19])
            listCategory.append(i[20..39])
            listPossPoints.append(i[40..41].toInt)
            listEarnPoints.append(i[54..55].toInt)
        elif (i.exists("Homework") then
            listAssignName.append(i[0,19])
            listCategory.append(i[20..39])
            listPossPoints.append(i[40..41].toInt)
            listEarnPoints.append(i[54..55].toInt)

    outputLoop "Group Project" groupprojecttotal groupprojectearn posspointstotal earnpointstotal

    outputLoop "Programming" progtotal progearn posspointstotal earnpointstotal

    outputLoop "Quizzes" quizzestotal quizzesearn posspointstotal earnpointstotal

    outputLoop "Homework" homeworktotal homeworkearn posspointstotal earnpointstotal

    let currGrade = earnpointstotal*100/posspointstotal
    let minFinal = earnpointstotal*100/1000
    let maxFinal = (1000 - (posspointstotal-earnpointstotal))/10 

    printfn "Current Grade: %i%" currGrade
    printfn "Minimum Final Grade: %i%" minFinal
    printfn "Maximum Final Grade: %i%" maxFinal
main()

(* 
    let index = 0
    printfn "================================================================"
    for i in listCategory do
        if (i = "Group Project") then
            let groupprojecttotal = groupprojecttotal + listPossPoints[index]
            let groupprojectearn = groupprojectearn + listEarnPoints[index]
            let posspointstotal = posspointstotal + listEarnPoints[index]
            let earnpointstotal = earnpointstotal + listEarnPoints[index]
            let index = index + 1
            printfn "%s %i/%i" listAssignName[index] listEarnPoints[index] listPossPoints[index]
    printfn "================================================================"

    let index = 0
    printfn "================================================================"
    for i in listCategory do
        if (i == "Programming") then
            let progtotal = progtotal + listPossPoints[index]
            let progearn = progearn + listEarnPoints[index]
            let earnpointstotal = earnpointstotal + listEarnPoints[index]
            let posspointstotal = posspointstotal + listPossPoints[index]
            let index = index + 1
            printfn "%s %i/%i" listAssignName[index] listEarnPoints[index] listPossPoints[index]
    printfn "================================================================"

    let index = 0
    printfn "================================================================"
    for i in listCategory do
        if (i == "Quizzes") then
            let quizzestotal = quizzestotal + listPossPoints[index]
            let quizzesearn = quizzesearn + listEarnPoints[index]
            let earnpointstotal = earnpointstotal + listEarnPoints[index]
            let posspointstotal = posspointstotal + listPossPoints[index]
            let index = index + 1
            printfn "%s %i/%i" listAssignName[index] listEarnPoints[index] listPossPoints[index]
    printfn "================================================================"

    let index = 0
    printfn "================================================================"
    for i in listCategory do
        if (i == "Homework") then
            let homeworktotal = homeworktotal + listPossPoints[index]
            let homeworkearn = homeworkearn + listEarnPoints[index]
            let earnpointstotal = earnpointstotal + listEarnPoints[index]
            let posspointstotal = posspointstotal + listPossPoints[index]
            let index = index + 1
            printfn "%s %i/%i" listAssignName[index] listEarnPoints[index] listPossPoints[index]
    printfn "================================================================"

*)
*)